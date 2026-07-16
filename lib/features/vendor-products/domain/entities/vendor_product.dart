class CompatibilityEntry {
  final String make;
  final String model;
  final int yearStart;
  final int yearEnd;

  const CompatibilityEntry({
    required this.make,
    required this.model,
    required this.yearStart,
    required this.yearEnd,
  });

  factory CompatibilityEntry.fromJson(Map<String, dynamic> json) {
    return CompatibilityEntry(
      make: json['make'] as String? ?? '',
      model: json['model'] as String? ?? '',
      yearStart: (json['yearStart'] as num?)?.toInt() ?? 0,
      yearEnd: (json['yearEnd'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'make': make,
        'model': model,
        'yearStart': yearStart,
        'yearEnd': yearEnd,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CompatibilityEntry &&
        other.make == make &&
        other.model == model &&
        other.yearStart == yearStart &&
        other.yearEnd == yearEnd;
  }

  @override
  int get hashCode => Object.hash(make, model, yearStart, yearEnd);

  @override
  String toString() => '$make $model $yearStart-$yearEnd';
}

class VendorProduct {
  final String id;
  final String vendorId;
  final String name;
  final String? description;
  final String? categoryId;
  final String price;
  final String currency;
  final int stockQuantity;
  final String productType;
  final String? partNumber;
  final String? brand;
  final int? warrantyMonths;
  final List<CompatibilityEntry>? compatibility;
  final List<String> images;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const VendorProduct({
    required this.id,
    required this.vendorId,
    required this.name,
    this.description,
    this.categoryId,
    required this.price,
    required this.currency,
    required this.stockQuantity,
    required this.productType,
    this.partNumber,
    this.brand,
    this.warrantyMonths,
    this.compatibility,
    required this.images,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  VendorProduct copyWith({
    String? id,
    String? vendorId,
    String? name,
    String? description,
    String? categoryId,
    String? price,
    String? currency,
    int? stockQuantity,
    String? productType,
    String? partNumber,
    String? brand,
    int? warrantyMonths,
    List<CompatibilityEntry>? compatibility,
    List<String>? images,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VendorProduct(
      id: id ?? this.id,
      vendorId: vendorId ?? this.vendorId,
      name: name ?? this.name,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      productType: productType ?? this.productType,
      partNumber: partNumber ?? this.partNumber,
      brand: brand ?? this.brand,
      warrantyMonths: warrantyMonths ?? this.warrantyMonths,
      compatibility: compatibility ?? this.compatibility,
      images: images ?? this.images,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VendorProduct &&
        other.id == id &&
        other.vendorId == vendorId &&
        other.name == name &&
        other.description == description &&
        other.categoryId == categoryId &&
        other.price == price &&
        other.currency == currency &&
        other.stockQuantity == stockQuantity &&
        other.productType == productType &&
        _listEquals(other.images, images) &&
        other.isActive == isActive &&
        other.partNumber == partNumber &&
        other.brand == brand &&
        other.warrantyMonths == warrantyMonths &&
        _listEquals(other.compatibility, compatibility) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => Object.hash(
        id,
        vendorId,
        name,
        description,
        categoryId,
        price,
        currency,
        stockQuantity,
        productType,
        Object.hashAll(images),
        isActive,
        partNumber,
        brand,
        warrantyMonths,
        Object.hashAll(compatibility ?? const []),
        createdAt,
        updatedAt,
      );

  static bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  String toString() {
    return 'VendorProduct(id: $id, name: $name, price: $price $currency, stock: $stockQuantity, isActive: $isActive, partNumber: $partNumber, brand: $brand, warrantyMonths: $warrantyMonths, compatibility: $compatibility)';
  }
}
