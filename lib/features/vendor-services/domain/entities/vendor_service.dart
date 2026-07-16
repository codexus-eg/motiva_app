import 'package:app/features/service-categories/domain/entities/service_category.dart';

class VendorService {
  final String id;
  final String vendorId;
  final String categoryId;
  final String name;
  final String? description;
  final String? basePrice;
  final String? imageUrl;
  final Map<String, dynamic> categoryServiceAttributes;
  final List<AttributeField> requiredCustomerFields;
  final double? availabilityRadiusKm;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;

  const VendorService({
    required this.id,
    required this.vendorId,
    required this.categoryId,
    required this.name,
    this.description,
    this.basePrice,
    this.imageUrl,
    required this.categoryServiceAttributes,
    this.requiredCustomerFields = const [],
    this.availabilityRadiusKm,
    this.isArchived = false,
    required this.createdAt,
    required this.updatedAt,
  });

  VendorService copyWith({
    String? id,
    String? vendorId,
    String? categoryId,
    String? name,
    String? description,
    String? basePrice,
    String? imageUrl,
    Map<String, dynamic>? categoryServiceAttributes,
    List<AttributeField>? requiredCustomerFields,
    double? availabilityRadiusKm,
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VendorService(
      id: id ?? this.id,
      vendorId: vendorId ?? this.vendorId,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      basePrice: basePrice ?? this.basePrice,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryServiceAttributes:
          categoryServiceAttributes ?? this.categoryServiceAttributes,
      requiredCustomerFields:
          requiredCustomerFields ?? this.requiredCustomerFields,
      availabilityRadiusKm: availabilityRadiusKm ?? this.availabilityRadiusKm,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VendorService &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'VendorService(id: $id, name: $name, categoryId: $categoryId, isArchived: $isArchived)';
  }
}
