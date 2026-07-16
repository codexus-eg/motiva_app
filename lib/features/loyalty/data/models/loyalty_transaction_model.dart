import '../../domain/entities/loyalty_transaction.dart';

class LoyaltyTransactionModel {
  final LoyaltyTransaction transaction;

  const LoyaltyTransactionModel(this.transaction);

  factory LoyaltyTransactionModel.fromJson(Map<String, dynamic> json) {
    return LoyaltyTransactionModel(
      LoyaltyTransaction(
        id: json['id'] as String,
        type: json['type'] as String,
        points: (json['points'] as num).toInt(),
        description: json['description'] as String?,
        referenceId: json['referenceId'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': transaction.id,
    'type': transaction.type,
    'points': transaction.points,
    'description': transaction.description,
    'referenceId': transaction.referenceId,
    'createdAt': transaction.createdAt.toIso8601String(),
  };
}
