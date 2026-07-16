import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/vendor-products/data/datasources/inventory_transaction_remote_data_source.dart';
import 'package:app/features/vendor-products/data/repositories/inventory_transaction_repository_impl.dart';
import 'package:app/features/vendor-products/domain/entities/inventory_transaction.dart';
import 'package:app/features/vendor-products/domain/repositories/inventory_transaction_repository.dart';
import 'package:app/features/vendor-products/presentation/providers/inventory_transactions_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inventoryTransactionRemoteDataSourceProvider =
    Provider<InventoryTransactionRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return InventoryTransactionRemoteDataSourceImpl(dioClient);
    });

final inventoryTransactionRepositoryProvider =
    Provider<InventoryTransactionRepository>((ref) {
      final remoteDataSource = ref.watch(
        inventoryTransactionRemoteDataSourceProvider,
      );
      return InventoryTransactionRepositoryImpl(remoteDataSource);
    });

final inventoryTransactionsNotifierProvider =
    AsyncNotifierProvider<
      InventoryTransactionsNotifier,
      InventoryTransactionsState
    >(() => InventoryTransactionsNotifier());

class InventoryTransactionsNotifier
    extends AsyncNotifier<InventoryTransactionsState> {
  static const int _pageSize = 20;

  @override
  Future<InventoryTransactionsState> build() async {
    return _fetchTransactions(page: 1);
  }

  Future<InventoryTransactionsState> _fetchTransactions({
    required int page,
    TransactionType? transactionType,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    final repository = ref.read(inventoryTransactionRepositoryProvider);
    final result = await repository.getTransactions(
      page: page,
      limit: _pageSize,
      transactionType: transactionType,
      fromDate: fromDate,
      toDate: toDate,
    );

    final hasReachedMax =
        result.page >= result.totalPages ||
        result.transactions.length < _pageSize;

    return InventoryTransactionsState(
      transactions: result.transactions,
      total: result.total,
      page: result.page,
      limit: result.limit,
      totalPages: result.totalPages,
      hasReachedMax: hasReachedMax,
    );
  }

  Future<void> refresh({
    TransactionType? transactionType,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return _fetchTransactions(
        page: 1,
        transactionType: transactionType,
        fromDate: fromDate,
        toDate: toDate,
      );
    });
  }

  Future<void> fetchNextPage({
    TransactionType? transactionType,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    final currentState = state.valueOrNull;
    if (currentState == null ||
        currentState.hasReachedMax ||
        currentState.isLoadingMore) {
      return;
    }

    final nextPage = currentState.page + 1;

    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

    try {
      final repository = ref.read(inventoryTransactionRepositoryProvider);
      final result = await repository.getTransactions(
        page: nextPage,
        limit: _pageSize,
        transactionType: transactionType,
        fromDate: fromDate,
        toDate: toDate,
      );

      final allTransactions = [
        ...currentState.transactions,
        ...result.transactions,
      ];
      final hasReachedMax =
          result.page >= result.totalPages ||
          result.transactions.length < _pageSize;

      state = AsyncValue.data(
        currentState.copyWith(
          transactions: allTransactions,
          page: result.page,
          total: result.total,
          totalPages: result.totalPages,
          hasReachedMax: hasReachedMax,
          isLoadingMore: false,
        ),
      );
    } catch (e, stackTrace) {
      AppLogger.error('fetchNextPage failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
    }
  }
}
