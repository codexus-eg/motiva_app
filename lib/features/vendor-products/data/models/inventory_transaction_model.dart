import 'package:app/features/vendor-products/domain/entities/inventory_transaction.dart';

class InventoryTransactionModel {
  final InventoryTransaction transaction;

  const InventoryTransactionModel({required this.transaction});

  factory InventoryTransactionModel.fromJson(Map<String, dynamic> json) {
    return InventoryTransactionModel(
      transaction: InventoryTransaction(
        id: json['id'] as String,
        productId: json['productId'] as String,
        productName: json['productName'] as String,
        orderId: json['orderId'] as String?,
        transactionType: _parseTransactionType(json['transactionType'] as String),
        quantityChange: (json['quantityChange'] as num).toDouble(),
        quantityBefore: (json['quantityBefore'] as num).toDouble(),
        quantityAfter: (json['quantityAfter'] as num).toDouble(),
        notes: json['notes'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': transaction.id,
      'productId': transaction.productId,
      'productName': transaction.productName,
      'orderId': transaction.orderId,
      'transactionType': _transactionTypeToString(transaction.transactionType),
      'quantityChange': transaction.quantityChange,
      'quantityBefore': transaction.quantityBefore,
      'quantityAfter': transaction.quantityAfter,
      'notes': transaction.notes,
      'createdAt': transaction.createdAt.toIso8601String(),
    };
  }

  static List<InventoryTransaction> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => InventoryTransactionModel.fromJson(json as Map<String, dynamic>).transaction)
        .toList();
  }

  static TransactionType _parseTransactionType(String value) {
    switch (value) {
      case 'sale':
        return TransactionType.sale;
      case 'restock':
        return TransactionType.restock;
      case 'adjustment':
        return TransactionType.adjustment;
      case 'refund':
        return TransactionType.refund;
      default:
        return TransactionType.adjustment;
    }
  }

  static String _transactionTypeToString(TransactionType type) {
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
}
