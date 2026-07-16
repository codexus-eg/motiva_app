class CartItem {
  final String id;
  final String productId;
  final String name;
  final String? description;
  final String? imageUrl;
  final int quantity;
  final String price;
  final String subtotal;
  final int? bonusPoints;
  final String? vendorId;
  final String? vendorName;
  final String? vendorLogoUrl;
  final String? vendorRating;

  const CartItem({
    required this.id,
    required this.productId,
    required this.name,
    this.description,
    this.imageUrl,
    required this.quantity,
    required this.price,
    required this.subtotal,
    this.bonusPoints,
    this.vendorId,
    this.vendorName,
    this.vendorLogoUrl,
    this.vendorRating,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    final productJson = json['product'] is Map<String, dynamic>
        ? json['product'] as Map<String, dynamic>
        : null;

    final rawPrice =
        json['price'] ?? productJson?['price'] ?? json['unitPrice'];
    final priceStr = rawPrice?.toString() ?? '0';

    final quantity = (json['quantity'] as num?)?.toInt() ?? 1;

    final rawSubtotal = json['subtotal'] ?? json['total'];
    final subtotalStr =
        rawSubtotal?.toString() ??
        (priceStr != '0' ? (double.tryParse(priceStr) ?? 0) * quantity : 0)
            .toString();

    return CartItem(
      id: json['id'] as String? ?? json['productId'] as String? ?? '',
      productId: json['productId'] as String? ?? json['id'] as String? ?? '',
      name: json['name'] as String? ?? productJson?['name'] as String? ?? '',
      description:
          json['description'] as String? ??
          productJson?['description'] as String?,
      imageUrl:
          json['imageUrl'] as String? ??
          productJson?['imageUrl'] as String? ??
          _extractFirstImage(productJson),
      quantity: quantity,
      price: priceStr,
      subtotal: subtotalStr,
      bonusPoints: (json['bonusPoints'] as num?)?.toInt(),
      vendorId:
          json['vendorId'] as String? ?? productJson?['vendorId'] as String?,
      vendorName:
          json['vendorName'] as String? ??
          productJson?['vendorName'] as String?,
      vendorLogoUrl:
          json['vendorLogoUrl'] as String? ??
          productJson?['vendorLogoUrl'] as String?,
      vendorRating:
          json['vendorRating']?.toString() ??
          productJson?['vendorRating']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'price': price,
      'subtotal': subtotal,
      'bonusPoints': bonusPoints,
      'vendorId': vendorId,
      'vendorName': vendorName,
      'vendorLogoUrl': vendorLogoUrl,
      'vendorRating': vendorRating,
    };
  }

  static String? _extractFirstImage(Map<String, dynamic>? productJson) {
    if (productJson == null) return null;
    final images = productJson['images'];
    if (images is List && images.isNotEmpty) {
      final first = images[0];
      if (first is String) return first;
    }
    return null;
  }

  static List<CartItem> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CartItem.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  CartItem copyWith({
    String? id,
    String? productId,
    String? name,
    String? description,
    String? imageUrl,
    int? quantity,
    String? price,
    String? subtotal,
    int? bonusPoints,
    String? vendorId,
    String? vendorName,
    String? vendorLogoUrl,
    String? vendorRating,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      subtotal: subtotal ?? this.subtotal,
      bonusPoints: bonusPoints ?? this.bonusPoints,
      vendorId: vendorId ?? this.vendorId,
      vendorName: vendorName ?? this.vendorName,
      vendorLogoUrl: vendorLogoUrl ?? this.vendorLogoUrl,
      vendorRating: vendorRating ?? this.vendorRating,
    );
  }
}
