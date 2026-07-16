import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/vendor/data/datasources/vendor_operators_remote_data_source.dart';
import 'package:app/features/vendor/domain/entities/operator.dart';
import 'package:app/features/vendor/domain/repositories/vendor_operators_repository.dart';
import 'package:dio/dio.dart';

class VendorOperatorsRepositoryImpl implements VendorOperatorsRepository {
  final VendorOperatorsRemoteDataSource _remoteDataSource;

  VendorOperatorsRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Operator>> getOperators() async {
    try {
      return await _remoteDataSource.getOperators();
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getOperators failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<Operator> createOperator(CreateOperatorParams params) async {
    try {
      return await _remoteDataSource.createOperator(params);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('createOperator failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<Operator> activateOperator(String operatorId) async {
    try {
      return await _remoteDataSource.activateOperator(operatorId);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('activateOperator failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<Operator> deactivateOperator(String operatorId) async {
    try {
      return await _remoteDataSource.deactivateOperator(operatorId);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('deactivateOperator failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<void> deleteOperator(String operatorId) async {
    try {
      return await _remoteDataSource.deleteOperator(operatorId);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('deleteOperator failed', error: e, stackTrace: stackTrace);
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
        return Exception('Operator not found');
      case 409:
        return Exception('Operator already exists: $message');
      case 500:
        return Exception('Server error: $message');
      default:
        return Exception('Failed to perform operator operation: $message');
    }
  }
}
