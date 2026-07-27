import 'package:app/core/network/dio_client.dart';
import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/loyalty/data/models/loyalty_config_model.dart';
import 'package:app/features/loyalty/data/models/loyalty_transaction_model.dart';
import 'package:app/features/loyalty/domain/failures/loyalty_failure.dart';
import 'package:dio/dio.dart';

abstract class LoyaltyRemoteDataSource {
  Future<List<LoyaltyTransactionModel>> getTransactions({
    String? type,
    int page = 1,
    int limit = 20,
  });

  Future<LoyaltyConfigModel> getLoyaltyConfig();
}

class LoyaltyRemoteDataSourceImpl implements LoyaltyRemoteDataSource {
  final DioClient _dioClient;

  LoyaltyRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<LoyaltyTransactionModel>> getTransactions({
    String? type,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/loyalty/transactions',
        queryParameters: {'type': ?type, 'page': page, 'limit': limit},
      );

      final data = response.data as Map<String, dynamic>;
      final items =
          (data['items'] ?? data['data'] ?? data['transactions'] ?? [])
              as List<dynamic>;

      return items
          .map(
            (item) =>
                LoyaltyTransactionModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getTransactions failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'getTransactions failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw LoyaltyFailure.unknown(e.toString());
    }
  }

  @override
  Future<LoyaltyConfigModel> getLoyaltyConfig() async {
    try {
      final response = await _dioClient.dio.get('/api/loyalty/balance');
      return LoyaltyConfigModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getLoyaltyConfig failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'getLoyaltyConfig failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw LoyaltyFailure.unknown(e.toString());
    }
  }

  LoyaltyFailure _handleError(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = DioErrorHandler.handle(e).message;

    switch (statusCode) {
      case 401:
        return LoyaltyFailure.unauthorized();
      case 404:
        return LoyaltyFailure.notFound();
      case 400:
        return LoyaltyFailure.validation(message);
      case 500:
        return LoyaltyFailure.serverError();
      default:
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          return LoyaltyFailure.networkError();
        }
        return LoyaltyFailure.unknown(message);
    }
  }
}
