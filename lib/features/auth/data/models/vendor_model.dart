import 'package:app/features/auth/domain/entities/vendor.dart';

class VendorModel {
  final Vendor vendor;

  const VendorModel._(this.vendor);

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    final isArchived = json['isArchived'] as bool? ?? false;
    final isDeleted = json['isDeleted'] as bool? ?? false;
    final isActive = json['isActive'] as bool?;

    return VendorModel._(
      Vendor(
        id: json['id'] as String,
        userId: json['userId'] as String,
        businessName: json['businessName'] as String,
        commercialLicenseNo: json['commercialLicenseNo'] as String?,
        logoUrl: json['logoUrl'] as String?,
        isVerified: json['isVerified'] as bool? ?? false,
        isArchived: isArchived,
        isDeleted: isDeleted,
        isActive: isActive ?? !(isArchived || isDeleted),
        rating: _parseRating(json['rating']),
        totalReviews: json['totalReviews'] as int? ?? 0,
      ),
    );
  }

  static double _parseRating(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  Map<String, dynamic> toJson() => {
    'id': vendor.id,
    'userId': vendor.userId,
    'businessName': vendor.businessName,
    'commercialLicenseNo': vendor.commercialLicenseNo,
    'logoUrl': vendor.logoUrl,
    'isVerified': vendor.isVerified,
    'isArchived': vendor.isArchived,
    'isDeleted': vendor.isDeleted,
    'isActive': vendor.isActive,
    'rating': vendor.rating.toString(),
    'totalReviews': vendor.totalReviews,
  };
}
