import '../../domain/entities/wallet_transaction.dart';

class WalletTransactionModel {
  final WalletTransaction transaction;

  const WalletTransactionModel(this.transaction);

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionModel(
      WalletTransaction(
        id: json['id'] as String,
        walletId: json['walletId'] as String,
        userId: json['userId'] as String?,
        type: json['type'] as String,
        amount: json['amount'] as String,
        balanceBefore: json['balanceBefore'] as String,
        balanceAfter: json['balanceAfter'] as String,
        referenceType: json['referenceType'] as String,
        referenceId: json['referenceId'] as String?,
        description: json['description'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': transaction.id,
    'walletId': transaction.walletId,
    'userId': transaction.userId,
    'type': transaction.type,
    'amount': transaction.amount,
    'balanceBefore': transaction.balanceBefore,
    'balanceAfter': transaction.balanceAfter,
    'referenceType': transaction.referenceType,
    'referenceId': transaction.referenceId,
    'description': transaction.description,
    'createdAt': transaction.createdAt.toIso8601String(),
  };
}
