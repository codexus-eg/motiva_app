enum TransactionType { sale, restock, adjustment, refund }

class InventoryTransaction {
  final String id;
  final String productId;
  final String productName;
  final String? orderId;
  final TransactionType transactionType;
  final double quantityChange;
  final double quantityBefore;
  final double quantityAfter;
  final String? notes;
  final DateTime createdAt;

  const InventoryTransaction({
    required this.id,
    required this.productId,
    required this.productName,
    this.orderId,
    required this.transactionType,
    required this.quantityChange,
    required this.quantityBefore,
    required this.quantityAfter,
    this.notes,
    required this.createdAt,
  });

  bool get isPositiveChange => quantityChange > 0;

  InventoryTransaction copyWith({
    String? id,
    String? productId,
    String? productName,
    String? orderId,
    TransactionType? transactionType,
    double? quantityChange,
    double? quantityBefore,
    double? quantityAfter,
    String? notes,
    DateTime? createdAt,
  }) {
    return InventoryTransaction(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      orderId: orderId ?? this.orderId,
      transactionType: transactionType ?? this.transactionType,
      quantityChange: quantityChange ?? this.quantityChange,
      quantityBefore: quantityBefore ?? this.quantityBefore,
      quantityAfter: quantityAfter ?? this.quantityAfter,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryTransaction &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
