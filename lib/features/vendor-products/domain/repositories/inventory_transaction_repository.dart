import 'package:app/features/vendor-products/domain/entities/inventory_transaction.dart';

abstract class InventoryTransactionRepository {
  Future<InventoryTransactionsResult> getTransactions({
    String? productId,
    TransactionType? transactionType,
    DateTime? fromDate,
    DateTime? toDate,
    int page = 1,
    int limit = 20,
  });
}

class InventoryTransactionsResult {
  final List<InventoryTransaction> transactions;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  const InventoryTransactionsResult({
    required this.transactions,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });
}
