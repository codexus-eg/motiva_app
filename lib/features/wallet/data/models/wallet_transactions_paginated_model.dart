import '../../domain/entities/wallet_transaction.dart';
import '../../domain/entities/wallet_transactions_paginated.dart';
import 'wallet_transaction_model.dart';

class WalletTransactionsPaginatedModel {
  final WalletTransactionsPaginated paginated;

  const WalletTransactionsPaginatedModel(this.paginated);

  factory WalletTransactionsPaginatedModel.fromJson(Map<String, dynamic> json) {
    final dataList = (json['data'] as List<dynamic>)
        .map((item) => WalletTransactionModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return WalletTransactionsPaginatedModel(
      WalletTransactionsPaginated(
        transactions: dataList.map((m) => m.transaction).toList(),
        total: (json['total'] as num).toInt(),
        page: (json['page'] as num).toInt(),
        limit: (json['limit'] as num).toInt(),
        totalPages: (json['totalPages'] as num).toInt(),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'data': paginated.transactions
        .map((t) => WalletTransactionModel(WalletTransaction(
      id: t.id,
      walletId: t.walletId,
      userId: t.userId,
      type: t.type,
      amount: t.amount,
      balanceBefore: t.balanceBefore,
      balanceAfter: t.balanceAfter,
      referenceType: t.referenceType,
      referenceId: t.referenceId,
      description: t.description,
      createdAt: t.createdAt,
    )).toJson())
        .toList(),
    'total': paginated.total,
    'page': paginated.page,
    'limit': paginated.limit,
    'totalPages': paginated.totalPages,
  };
}
