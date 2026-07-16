import 'package:app/features/public_services/domain/entities/entities.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';

class PublicVendorServiceModel extends PublicVendorService {
  const PublicVendorServiceModel({
    required super.id,
    required super.vendorId,
    required super.categoryId,
    required super.name,
    super.description,
    super.basePrice,
    super.imageUrl,
    super.coverImageUrl,
    required super.categoryServiceAttributes,
    super.requiredCustomerFields,
    super.availabilityRadiusKm,
    required super.vendorBusinessName,
    super.vendorLogoUrl,
    super.vendorCoverImageUrl,
    super.vendorRating,
    required super.vendorTotalReviews,
  });

  factory PublicVendorServiceModel.fromJson(Map<String, dynamic> json) {
    final attributesRaw = json['categoryServiceAttributes'];
    final Map<String, dynamic> categoryServiceAttributes = attributesRaw != null
        ? Map<String, dynamic>.from(attributesRaw as Map)
        : {};

    return PublicVendorServiceModel(
      id: json['id'] as String,
      vendorId: json['vendorId'] as String,
      categoryId: json['categoryId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      basePrice: json['basePrice'] as String?,
      imageUrl: json['imageUrl'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      categoryServiceAttributes: categoryServiceAttributes,
      requiredCustomerFields: json['requiredCustomerFields'] != null
          ? AttributeField.fromJsonList(
              json['requiredCustomerFields'] as List<dynamic>,
            )
          : const [],
      availabilityRadiusKm: json['availabilityRadiusKm'] as int?,
      vendorBusinessName: json['vendorBusinessName'] as String? ?? '',
      vendorLogoUrl: json['vendorLogoUrl'] as String?,
      vendorCoverImageUrl: json['vendorCoverImageUrl'] as String?,
      vendorRating: json['vendorRating'] as String?,
      vendorTotalReviews: json['vendorTotalReviews'] as int? ?? 0,
    );
  }

  static List<PublicVendorService> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map(
          (json) =>
              PublicVendorServiceModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }
}
