import 'package:app/features/service-categories/domain/entities/service_category.dart';

class PublicVendorService {
  final String id;
  final String vendorId;
  final String categoryId;
  final String name;
  final String? description;
  final String? basePrice;
  final String? imageUrl;
  final String? coverImageUrl;
  final Map<String, dynamic> categoryServiceAttributes;
  final List<AttributeField> requiredCustomerFields;
  final int? availabilityRadiusKm;
  final String vendorBusinessName;
  final String? vendorLogoUrl;
  final String? vendorCoverImageUrl;
  final String? vendorRating;
  final int vendorTotalReviews;

  const PublicVendorService({
    required this.id,
    required this.vendorId,
    required this.categoryId,
    required this.name,
    this.description,
    this.basePrice,
    this.imageUrl,
    this.coverImageUrl,
    required this.categoryServiceAttributes,
    this.requiredCustomerFields = const [],
    this.availabilityRadiusKm,
    required this.vendorBusinessName,
    this.vendorLogoUrl,
    this.vendorCoverImageUrl,
    this.vendorRating,
    required this.vendorTotalReviews,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PublicVendorService &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
