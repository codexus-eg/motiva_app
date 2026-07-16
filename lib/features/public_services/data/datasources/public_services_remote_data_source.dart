import 'package:app/core/network/dio_client.dart';
import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/public_services/data/models/models.dart';
import 'package:app/features/public_services/domain/entities/entities.dart';
import 'package:app/features/public_services/domain/failures/public_services_failure.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';
import 'package:app/features/service-categories/data/models/service_category_model.dart';
import 'package:dio/dio.dart';

abstract class PublicServicesRemoteDataSource {
  Future<List<ServiceCategory>> getServiceCategories();
  Future<ServiceCategoryWithSchema> getCategoryDetails(String categoryId);
  Future<List<PublicVendor>> getVendorsByCategory(String categoryId);
  Future<PublicVendor> getVendorProfile(String vendorId);
  Future<List<PublicVendorService>> getVendorServices({
    String? categoryId,
    String? vendorId,
  });
  Future<PublicVendorService> getServiceDetails(String serviceId);
}

class PublicServicesRemoteDataSourceImpl
    implements PublicServicesRemoteDataSource {
  final DioClient _dioClient;

  PublicServicesRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<ServiceCategory>> getServiceCategories() async {
    try {
      AppLogger.debug(
        'Fetching service categories from /api/public/service-categories',
      );
      final response = await _dioClient.dio.get(
        '/api/public/service-categories',
      );
      AppLogger.debug('Service categories response: ${response.data}');
      final categories = ServiceCategoryModel.fromJsonList(
        response.data as List<dynamic>,
      );
      AppLogger.debug('Parsed ${categories.length} service categories');
      return categories;
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getServiceCategories failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    }
  }

  @override
  Future<ServiceCategoryWithSchema> getCategoryDetails(
    String categoryId,
  ) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/public/service-categories/$categoryId',
      );
      return ServiceCategoryWithSchema.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getCategoryDetails failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    }
  }

  @override
  Future<List<PublicVendor>> getVendorsByCategory(String categoryId) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/public/vendors/by-category/$categoryId',
      );
      return PublicVendorModel.fromJsonList(response.data as List<dynamic>);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getVendorsByCategory failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    }
  }

  @override
  Future<PublicVendor> getVendorProfile(String vendorId) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/public/vendors/$vendorId',
      );
      return PublicVendorModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getVendorProfile failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    }
  }

  @override
  Future<List<PublicVendorService>> getVendorServices({
    String? categoryId,
    String? vendorId,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (categoryId != null) queryParams['categoryId'] = categoryId;
      if (vendorId != null) queryParams['vendorId'] = vendorId;

      final response = await _dioClient.dio.get(
        '/api/public/vendor-services',
        queryParameters: queryParams.isEmpty ? null : queryParams,
      );
      return PublicVendorServiceModel.fromJsonList(
        response.data as List<dynamic>,
      );
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getVendorServices failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    }
  }

  @override
  Future<PublicVendorService> getServiceDetails(String serviceId) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/public/vendor-services/$serviceId',
      );
      return PublicVendorServiceModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getServiceDetails failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    }
  }

  PublicServicesFailure _handleError(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = DioErrorHandler.handle(e).message;

    switch (statusCode) {
      case 404:
        return PublicServicesFailure.notFound();
      case 500:
        return PublicServicesFailure.serverError();
      default:
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          return PublicServicesFailure.networkError();
        }
        return PublicServicesFailure.unknown(message);
    }
  }
}
