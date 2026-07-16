import 'cart_item.dart';

class Cart {
  final String? id;
  final List<CartItem> items;
  final String? promoCode;
  final String? discount;
  final String totalAmount;
  final int itemCount;
  final DateTime? updatedAt;

  const Cart({
    this.id,
    required this.items,
    this.promoCode,
    this.discount,
    required this.totalAmount,
    required this.itemCount,
    this.updatedAt,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    final root = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;
    final itemsJson = root['items'] as List<dynamic>? ?? [];
    final items = CartItem.fromJsonList(itemsJson);

    final rawTotal = root['totalAmount'] ?? root['total'] ?? root['amount'];
    final computedTotal = items
        .fold<double>(
          0,
          (sum, item) => sum + (double.tryParse(item.subtotal) ?? 0),
        )
        .toString();

    return Cart(
      id: root['id'] as String?,
      items: items,
      promoCode: root['promoCode'] as String?,
      discount: root['discount']?.toString(),
      totalAmount: rawTotal?.toString() ?? computedTotal,
      itemCount: (root['itemCount'] as num?)?.toInt() ?? items.length,
      updatedAt: root['updatedAt'] != null
          ? DateTime.parse(root['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((e) => e.toJson()).toList(),
      'promoCode': promoCode,
      'discount': discount,
      'totalAmount': totalAmount,
      'itemCount': itemCount,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Cart copyWith({
    String? id,
    List<CartItem>? items,
    String? promoCode,
    String? discount,
    String? totalAmount,
    int? itemCount,
    DateTime? updatedAt,
  }) {
    return Cart(
      id: id ?? this.id,
      items: items ?? this.items,
      promoCode: promoCode ?? this.promoCode,
      discount: discount ?? this.discount,
      totalAmount: totalAmount ?? this.totalAmount,
      itemCount: itemCount ?? this.itemCount,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isEmpty => items.isEmpty;
}
