import 'package:app/core/network/dio_client.dart';
import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/public_marketplace/domain/failures/public_marketplace_failure.dart';
import 'package:app/features/public_marketplace/domain/repositories/public_marketplace_repository.dart';
import 'package:app/features/public_services/data/models/public_vendor_model.dart';
import 'package:app/features/public_services/domain/entities/entities.dart';
import 'package:app/features/vendor-products/data/models/vendor_product_model.dart';
import 'package:app/features/vendor-products/domain/entities/vendor_product.dart';
import 'package:dio/dio.dart';

abstract class PublicMarketplaceRemoteDataSource {
  Future<VendorProduct> getProduct(String id);
  Future<List<PublicVendor>> getVendorsByProductType(String? productType);
  Future<List<VendorProduct>> getVendorProducts(
    String vendorId, {
    PublicProductFilter? filter,
  });
}

class PublicMarketplaceRemoteDataSourceImpl
    implements PublicMarketplaceRemoteDataSource {
  final DioClient _dioClient;

  PublicMarketplaceRemoteDataSourceImpl(this._dioClient);

  @override
  Future<VendorProduct> getProduct(String id) async {
    try {
      final response = await _dioClient.dio.get('/api/products/$id');
      return VendorProductModel.fromJson(
        response.data as Map<String, dynamic>,
      ).vendorProduct;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getProduct failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<List<PublicVendor>> getVendorsByProductType(
    String? productType,
  ) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/products/vendors',
        queryParameters: productType != null
            ? {'productType': productType}
            : null,
      );
      return PublicVendorModel.fromJsonList(response.data as List<dynamic>);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getVendorsByProductType failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    }
  }

  @override
  Future<List<VendorProduct>> getVendorProducts(
    String vendorId, {
    PublicProductFilter? filter,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/products/catalog',
        queryParameters: {'vendorId': vendorId, ...?filter?.toQueryParams()},
      );
      final data = response.data;
      AppLogger.debug(
        'getVendorProducts raw response type: ${data.runtimeType}',
      );

      List<dynamic> productList = [];
      if (data is Map<String, dynamic> && data.containsKey('data')) {
        final inner = data['data'];
        if (inner is List) {
          productList = inner;
        } else if (inner is Map<String, dynamic> &&
            inner.containsKey('items')) {
          productList = inner['items'] as List<dynamic>;
        }
      } else if (data is Map<String, dynamic> && data.containsKey('items')) {
        productList = data['items'] as List<dynamic>;
      } else if (data is List) {
        productList = data;
      }

      return VendorProductModel.fromJsonList(productList);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getVendorProducts failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    }
  }

  PublicMarketplaceFailure _handleError(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = DioErrorHandler.handle(e).message;

    switch (statusCode) {
      case 404:
        return PublicMarketplaceFailure.notFound();
      case 500:
        return PublicMarketplaceFailure.serverError();
      default:
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          return PublicMarketplaceFailure.networkError();
        }
        return PublicMarketplaceFailure.unknown(message);
    }
  }
}
