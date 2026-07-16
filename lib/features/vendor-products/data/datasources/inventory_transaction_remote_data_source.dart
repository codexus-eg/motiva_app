import 'package:app/core/network/dio_client.dart';
import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/vendor-products/data/models/inventory_transaction_model.dart';
import 'package:app/features/vendor-products/domain/entities/inventory_transaction.dart';
import 'package:app/features/vendor-products/domain/repositories/inventory_transaction_repository.dart';
import 'package:app/features/vendor-products/domain/failures/inventory_transaction_failure.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

abstract class InventoryTransactionRemoteDataSource {
  Future<InventoryTransactionsResult> getTransactions({
    String? productId,
    TransactionType? transactionType,
    DateTime? fromDate,
    DateTime? toDate,
    int page,
    int limit,
  });
}

class InventoryTransactionRemoteDataSourceImpl
    implements InventoryTransactionRemoteDataSource {
  final DioClient _dioClient;

  InventoryTransactionRemoteDataSourceImpl(this._dioClient);

  @override
  Future<InventoryTransactionsResult> getTransactions({
    String? productId,
    TransactionType? transactionType,
    DateTime? fromDate,
    DateTime? toDate,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };

      if (productId != null) {
        queryParams['productId'] = productId;
      }
      if (transactionType != null) {
        queryParams['transactionType'] = _transactionTypeToApiString(transactionType);
      }
      if (fromDate != null) {
        queryParams['fromDate'] = DateFormat('yyyy-MM-dd').format(fromDate);
      }
      if (toDate != null) {
        queryParams['toDate'] = DateFormat('yyyy-MM-dd').format(toDate);
      }

      final response = await _dioClient.dio.get(
        '/api/products/inventory-transactions',
        queryParameters: queryParams,
      );

      final data = response.data as Map<String, dynamic>;
      final items = data['data'] as List<dynamic>;
      final transactions = InventoryTransactionModel.fromJsonList(items);

      return InventoryTransactionsResult(
        transactions: transactions,
        total: (data['total'] as num).toInt(),
        page: (data['page'] as num).toInt(),
        limit: (data['limit'] as num).toInt(),
        totalPages: (data['totalPages'] as num).toInt(),
      );
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getInventoryTransactions failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleError(e);
    }
  }

  String _transactionTypeToApiString(TransactionType type) {
    switch (type) {
      case TransactionType.sale:
        return 'sale';
      case TransactionType.restock:
        return 'restock';
      case TransactionType.adjustment:
        return 'adjustment';
      case TransactionType.refund:
        return 'refund';
    }
  }

  InventoryTransactionFailure _handleError(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = DioErrorHandler.handle(e).message;

    switch (statusCode) {
      case 401:
        return InventoryTransactionFailure.unauthorized();
      case 404:
        return InventoryTransactionFailure.notFound();
      case 400:
        return InventoryTransactionFailure.validation(message);
      case 500:
        return InventoryTransactionFailure.serverError();
      default:
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          return InventoryTransactionFailure.networkError();
        }
        return InventoryTransactionFailure.unknown(message);
    }
  }
}
