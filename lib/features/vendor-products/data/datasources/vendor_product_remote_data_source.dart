import 'package:app/core/network/dio_client.dart';
import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/vendor-products/data/models/vendor_product_model.dart';
import 'package:app/features/vendor-products/domain/entities/vendor_product.dart';
import 'package:app/features/vendor-products/domain/failures/vendor_product_failure.dart';
import 'package:dio/dio.dart';

abstract class VendorProductRemoteDataSource {
  Future<List<VendorProduct>> getProducts(String vendorId);
  Future<VendorProduct> getProduct(String id);
  Future<VendorProduct> createProduct(Map<String, dynamic> request);
  Future<VendorProduct> updateProduct(String id, Map<String, dynamic> request);
  Future<VendorProduct> deleteProduct(String id);
  Future<VendorProduct> toggleProductActive(String id);
}

class VendorProductRemoteDataSourceImpl
    implements VendorProductRemoteDataSource {
  final DioClient _dioClient;

  VendorProductRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<VendorProduct>> getProducts(String vendorId) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/products/catalog',
        queryParameters: {'vendorId': vendorId},
      );
      final data = response.data;
      AppLogger.debug('getProducts raw response type: ${data.runtimeType}');

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

      if (productList.isNotEmpty) {
        final first = productList.first as Map<String, dynamic>;
        AppLogger.debug('First product images raw: ${first['images']}');
      }

      return VendorProductModel.fromJsonList(productList);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getProducts failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

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
  Future<VendorProduct> createProduct(Map<String, dynamic> request) async {
    try {
      final response = await _dioClient.dio.post(
        '/api/products',
        data: request,
      );
      return VendorProductModel.fromJson(
        response.data as Map<String, dynamic>,
      ).vendorProduct;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('createProduct failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<VendorProduct> updateProduct(
    String id,
    Map<String, dynamic> request,
  ) async {
    try {
      final response = await _dioClient.dio.put(
        '/api/products/$id',
        data: request,
      );
      return VendorProductModel.fromJson(
        response.data as Map<String, dynamic>,
      ).vendorProduct;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('updateProduct failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<VendorProduct> deleteProduct(String id) async {
    try {
      final response = await _dioClient.dio.delete('/api/products/$id');
      return VendorProductModel.fromJson(
        response.data as Map<String, dynamic>,
      ).vendorProduct;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('deleteProduct failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<VendorProduct> toggleProductActive(String id) async {
    try {
      final response = await _dioClient.dio.patch('/api/products/$id/activate');
      return VendorProductModel.fromJson(
        response.data as Map<String, dynamic>,
      ).vendorProduct;
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'toggleProductActive failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    }
  }

  VendorProductFailure _handleError(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = DioErrorHandler.handle(e).message;

    switch (statusCode) {
      case 401:
        return VendorProductFailure.unauthorized();
      case 404:
        return VendorProductFailure.notFound();
      case 400:
        return VendorProductFailure.validation(message);
      case 500:
        return VendorProductFailure.serverError();
      default:
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          return VendorProductFailure.networkError();
        }
        return VendorProductFailure.unknown(message);
    }
  }
}
