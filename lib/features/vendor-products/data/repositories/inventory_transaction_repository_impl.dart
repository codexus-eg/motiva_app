import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/vendor-products/data/datasources/inventory_transaction_remote_data_source.dart';
import 'package:app/features/vendor-products/domain/entities/inventory_transaction.dart';
import 'package:app/features/vendor-products/domain/failures/inventory_transaction_failure.dart';
import 'package:app/features/vendor-products/domain/repositories/inventory_transaction_repository.dart';

class InventoryTransactionRepositoryImpl
    implements InventoryTransactionRepository {
  final InventoryTransactionRemoteDataSource _remoteDataSource;

  InventoryTransactionRepositoryImpl(this._remoteDataSource);

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
      return await _remoteDataSource.getTransactions(
        productId: productId,
        transactionType: transactionType,
        fromDate: fromDate,
        toDate: toDate,
        page: page,
        limit: limit,
      );
    } catch (e, stackTrace) {
      if (e is InventoryTransactionFailure) rethrow;
      AppLogger.error(
        'getInventoryTransactions failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw InventoryTransactionFailure.unknown(e.toString());
    }
  }
}
