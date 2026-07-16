import 'package:flutter/foundation.dart';

import 'wallet_transaction.dart';

@immutable
class WalletTransactionsPaginated {
  final List<WalletTransaction> transactions;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  const WalletTransactionsPaginated({
    required this.transactions,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  WalletTransactionsPaginated copyWith({
    List<WalletTransaction>? transactions,
    int? total,
    int? page,
    int? limit,
    int? totalPages,
  }) {
    return WalletTransactionsPaginated(
      transactions: transactions ?? this.transactions,
      total: total ?? this.total,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletTransactionsPaginated &&
          runtimeType == other.runtimeType &&
          total == other.total &&
          page == other.page &&
          limit == other.limit &&
          totalPages == other.totalPages &&
          listEquals(transactions, other.transactions);

  @override
  int get hashCode => Object.hash(
    Object.hashAll(transactions),
    total,
    page,
    limit,
    totalPages,
  );

  @override
  String toString() =>
      'WalletTransactionsPaginated(transactions: $transactions, total: $total, page: $page, limit: $limit, totalPages: $totalPages)';
}
