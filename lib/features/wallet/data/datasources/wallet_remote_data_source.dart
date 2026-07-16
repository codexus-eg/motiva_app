// ignore_for_file: use_null_aware_elements

import 'package:app/core/network/dio_client.dart';
import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/wallet/domain/failures/wallet_failure.dart';
import 'package:dio/dio.dart';

abstract class WalletRemoteDataSource {
  Future<Map<String, dynamic>> getBalance();

  Future<Map<String, dynamic>> getTransactions({
    String? type,
    String? referenceType,
    String? fromDate,
    String? toDate,
    int page = 1,
    int limit = 20,
  });

  Future<Map<String, dynamic>> createPayoutRequest(String amount);

  Future<Map<String, dynamic>> getPayoutRequests({
    int page = 1,
    int limit = 20,
  });

  Future<Map<String, dynamic>> getDashboardStats(String period);
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final DioClient _dioClient;

  WalletRemoteDataSourceImpl(this._dioClient);

  @override
  Future<Map<String, dynamic>> getBalance() async {
    try {
      final response = await _dioClient.dio.get('/api/wallet/balance');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getBalance failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('getBalance failed', error: e, stackTrace: stackTrace);
      throw WalletFailure.unknown(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> getTransactions({
    String? type,
    String? referenceType,
    String? fromDate,
    String? toDate,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/wallet/transactions',
        queryParameters: {
          if (type != null) 'type': type,
          if (referenceType != null) 'referenceType': referenceType,
          if (fromDate != null) 'fromDate': fromDate,
          if (toDate != null) 'toDate': toDate,
          'page': page,
          'limit': limit,
        },
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getTransactions failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('getTransactions failed', error: e, stackTrace: stackTrace);
      throw WalletFailure.unknown(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> createPayoutRequest(String amount) async {
    try {
      final response = await _dioClient.dio.post(
        '/api/wallet/payout-requests',
        data: {'amount': amount},
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('createPayoutRequest failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('createPayoutRequest failed', error: e, stackTrace: stackTrace);
      throw WalletFailure.unknown(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> getPayoutRequests({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/wallet/payout-requests',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getPayoutRequests failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('getPayoutRequests failed', error: e, stackTrace: stackTrace);
      throw WalletFailure.unknown(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> getDashboardStats(String period) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/vendors/dashboard-stats',
        queryParameters: {'period': period},
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getDashboardStats failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('getDashboardStats failed', error: e, stackTrace: stackTrace);
      throw WalletFailure.unknown(e.toString());
    }
  }

  WalletFailure _handleError(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = DioErrorHandler.handle(e).message;

    switch (statusCode) {
      case 401:
        return WalletFailure.unauthorized();
      case 404:
        return WalletFailure.notFound();
      case 400:
        return WalletFailure.validation(message);
      case 500:
        return WalletFailure.serverError();
      default:
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          return WalletFailure.networkError();
        }
        return WalletFailure.unknown(message);
    }
  }
}
