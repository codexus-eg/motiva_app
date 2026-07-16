import 'package:app/core/network/dio_client.dart';
import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/vendor-services/data/models/vendor_service_model.dart';
import 'package:app/features/vendor-services/domain/entities/vendor_service.dart';
import 'package:app/features/vendor-services/domain/failures/vendor_service_failure.dart';
import 'package:dio/dio.dart';

abstract class VendorServiceRemoteDataSource {
  Future<List<VendorService>> getServices();
  Future<VendorService> getService(String id);
  Future<VendorService> createService(Map<String, dynamic> request);
  Future<VendorService> updateService(String id, Map<String, dynamic> request);
  Future<VendorService> archiveService(String id);
  Future<VendorService> restoreService(String id);
}

class VendorServiceRemoteDataSourceImpl
    implements VendorServiceRemoteDataSource {
  final DioClient _dioClient;

  VendorServiceRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<VendorService>> getServices() async {
    try {
      final response = await _dioClient.dio.get('/api/vendor-services');
      return VendorServiceModel.fromJsonList(response.data as List<dynamic>);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getServices failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<VendorService> getService(String id) async {
    try {
      final response = await _dioClient.dio.get('/api/vendor-services/$id');
      return VendorServiceModel.fromJson(response.data).vendorService;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getService failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<VendorService> createService(Map<String, dynamic> request) async {
    try {
      final response = await _dioClient.dio.post(
        '/api/vendor-services',
        data: request,
      );
      return VendorServiceModel.fromJson(response.data).vendorService;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('createService failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<VendorService> updateService(
    String id,
    Map<String, dynamic> request,
  ) async {
    try {
      final response = await _dioClient.dio.patch(
        '/api/vendor-services/$id',
        data: request,
      );
      return VendorServiceModel.fromJson(response.data).vendorService;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('updateService failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<VendorService> archiveService(String id) async {
    try {
      final response = await _dioClient.dio.patch(
        '/api/vendor-services/$id/archive',
      );
      return VendorServiceModel.fromJson(response.data).vendorService;
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'archiveService failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    }
  }

  @override
  Future<VendorService> restoreService(String id) async {
    try {
      final response = await _dioClient.dio.patch(
        '/api/vendor-services/$id/restore',
      );
      return VendorServiceModel.fromJson(response.data).vendorService;
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'restoreService failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    }
  }

  VendorServiceFailure _handleError(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = DioErrorHandler.handle(e).message;

    switch (statusCode) {
      case 401:
        return VendorServiceFailure.unauthorized();
      case 404:
        return VendorServiceFailure.notFound();
      case 400:
        return VendorServiceFailure.validation(message);
      case 500:
        return VendorServiceFailure.serverError();
      default:
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          return VendorServiceFailure.networkError();
        }
        return VendorServiceFailure.unknown(message);
    }
  }
}
