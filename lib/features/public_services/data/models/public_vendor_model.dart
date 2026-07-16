import 'package:app/features/public_services/domain/entities/entities.dart';

class PublicVendorModel extends PublicVendor {
  const PublicVendorModel({
    required super.id,
    super.userId,
    required super.businessName,
    super.logoUrl,
    super.coverImageUrl,
    super.description,
    super.rating,
    required super.totalReviews,
    required super.totalServices,
    super.isVerified,
    super.workingHours,
  });

  factory PublicVendorModel.fromJson(Map<String, dynamic> json) {
    return PublicVendorModel(
      id: json['id'] as String,
      userId: json['userId'] as String?,
      businessName: json['businessName'] as String,
      logoUrl: json['logoUrl'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      description: json['description'] as String?,
      rating: json['rating'] as String?,
      totalReviews: json['totalReviews'] as int? ?? 0,
      totalServices: json['totalServices'] as int? ?? 0,
      isVerified: json['isVerified'] as bool? ?? false,
      workingHours: json['workingHours'] as Map<String, dynamic>?,
    );
  }

  static List<PublicVendor> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => PublicVendorModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
