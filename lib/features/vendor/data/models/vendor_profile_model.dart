import 'package:app/features/vendor/data/models/working_hours_model.dart';
import 'package:app/features/vendor/domain/entities/vendor_profile.dart';
import 'package:app/features/vendor/domain/entities/vendor_status.dart';

class VendorProfileModel {
  final VendorProfile vendorProfile;

  const VendorProfileModel({required this.vendorProfile});

  factory VendorProfileModel.fromJson(Map<String, dynamic> json) {
    final isArchived = json['isArchived'] as bool? ?? false;
    final isDeleted = json['isDeleted'] as bool? ?? false;
    final isActive = json['isActive'] as bool?;

    return VendorProfileModel(
      vendorProfile: VendorProfile(
        id: json['id'] as String,
        userId: json['userId'] as String,
        businessName: json['businessName'] as String,
        commercialLicenseNo: json['commercialLicenseNo'] as String?,
        logoUrl: json['logoUrl'] as String?,
        coverImageUrl: json['coverImageUrl'] as String?,
        isVerified: json['isVerified'] as bool? ?? false,
        isArchived: isArchived,
        isDeleted: isDeleted,
        isActive: isActive ?? !(isArchived || isDeleted),
        isAvailable: json['isAvailable'] as bool? ?? true,
        status: VendorStatus.fromApiValue(json['status'] as String?),
        orderCapacity: json['orderCapacity'] as int? ?? 1,
        rating: (json['rating'] as String?) ?? '0.00',
        totalReviews: json['totalReviews'] as int? ?? 0,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
        workingHours: json['workingHours'] != null
            ? WorkingHoursModel.fromJson(
                json['workingHours'] as Map<String, dynamic>,
              ).workingHours
            : null,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': vendorProfile.id,
      'userId': vendorProfile.userId,
      'businessName': vendorProfile.businessName,
      'commercialLicenseNo': vendorProfile.commercialLicenseNo,
      'logoUrl': vendorProfile.logoUrl,
      'coverImageUrl': vendorProfile.coverImageUrl,
      'isVerified': vendorProfile.isVerified,
      'isArchived': vendorProfile.isArchived,
      'isDeleted': vendorProfile.isDeleted,
      'isActive': vendorProfile.isActive,
      'isAvailable': vendorProfile.isAvailable,
      'status': vendorProfile.status.apiValue,
      'orderCapacity': vendorProfile.orderCapacity,
      'rating': vendorProfile.rating,
      'totalReviews': vendorProfile.totalReviews,
      'createdAt': vendorProfile.createdAt.toIso8601String(),
      'updatedAt': vendorProfile.updatedAt.toIso8601String(),
      if (vendorProfile.workingHours != null)
        'workingHours': WorkingHoursModel(
          workingHours: vendorProfile.workingHours!,
        ).toJson(),
    };
  }
}
