import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/vendor/data/datasources/vendor_remote_data_source.dart';
import 'package:app/features/vendor/domain/entities/schedule_exception.dart';
import 'package:app/features/vendor/domain/entities/vendor_profile.dart';
import 'package:app/features/vendor/domain/entities/vendor_status.dart';
import 'package:app/features/vendor/domain/entities/working_hours.dart';
import 'package:app/features/vendor/domain/repositories/vendor_repository.dart';
import 'package:dio/dio.dart';

class VendorRepositoryImpl implements VendorRepository {
  final VendorRemoteDataSource _remoteDataSource;

  VendorRepositoryImpl(this._remoteDataSource);

  @override
  Future<VendorProfile?> getProfile() async {
    try {
      return await _remoteDataSource.getProfile();
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getProfile failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<VendorProfile> updateProfile(UpdateVendorParams params) async {
    try {
      return await _remoteDataSource.updateProfile(params.toJson());
    } on DioException catch (e, stackTrace) {
      AppLogger.error('updateProfile failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<VendorProfile> updateAvailability(bool isAvailable) async {
    try {
      return await _remoteDataSource.updateAvailability(isAvailable);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'updateAvailability failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    }
  }

  @override
  Future<VendorProfile> updateStatus(VendorStatus status) async {
    try {
      return await _remoteDataSource.updateStatus(status);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('updateStatus failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<VendorProfile> updateWorkingHours(WorkingHours workingHours) async {
    try {
      return await _remoteDataSource.updateWorkingHours(workingHours);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'updateWorkingHours failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    }
  }

  @override
  Future<List<ScheduleException>> getScheduleExceptions() async {
    try {
      return await _remoteDataSource.getScheduleExceptions();
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getScheduleExceptions failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    }
  }

  @override
  Future<ScheduleException> createScheduleException(
    CreateScheduleExceptionParams params,
  ) async {
    try {
      return await _remoteDataSource.createScheduleException(params);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'createScheduleException failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    }
  }

  @override
  Future<void> deleteScheduleException(String id) async {
    try {
      return await _remoteDataSource.deleteScheduleException(id);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'deleteScheduleException failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    }
  }

  @override
  Future<VendorProfile> updateCapacity(int orderCapacity) async {
    try {
      return await _remoteDataSource.updateCapacity(orderCapacity);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'updateCapacity failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = DioErrorHandler.handle(e).message;

    switch (statusCode) {
      case 401:
        return Exception('Unauthorized: $message');
      case 404:
        return Exception('Vendor profile not found');
      case 500:
        return Exception('Server error: $message');
      default:
        return Exception('Failed to fetch vendor profile: $message');
    }
  }
}
