import 'package:app/features/vendor-products/domain/entities/inventory_transaction.dart';

class InventoryTransactionsState {
  final List<InventoryTransaction> transactions;
  final int total;
  final int page;
  final int limit;
  final int totalPages;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const InventoryTransactionsState({
    required this.transactions,
    this.total = 0,
    this.page = 1,
    this.limit = 20,
    this.totalPages = 0,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  InventoryTransactionsState copyWith({
    List<InventoryTransaction>? transactions,
    int? total,
    int? page,
    int? limit,
    int? totalPages,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return InventoryTransactionsState(
      transactions: transactions ?? this.transactions,
      total: total ?? this.total,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      totalPages: totalPages ?? this.totalPages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
