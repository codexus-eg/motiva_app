import 'package:app/features/vendor/domain/entities/vendor_status.dart';
import 'package:app/features/vendor/domain/entities/working_hours.dart';

class VendorProfile {
  final String id;
  final String userId;
  final String businessName;
  final String? commercialLicenseNo;
  final String? logoUrl;
  final String? coverImageUrl;
  final bool isVerified;
  final bool isArchived;
  final bool isDeleted;
  final bool isActive;
  final bool isAvailable;
  final VendorStatus status;
  final int orderCapacity;
  final String rating;
  final int totalReviews;
  final DateTime createdAt;
  final DateTime updatedAt;
  final WorkingHours? workingHours;

  const VendorProfile({
    required this.id,
    required this.userId,
    required this.businessName,
    this.commercialLicenseNo,
    this.logoUrl,
    this.coverImageUrl,
    this.isVerified = false,
    this.isArchived = false,
    this.isDeleted = false,
    this.isActive = true,
    this.isAvailable = true,
    this.status = VendorStatus.open,
    this.orderCapacity = 1,
    this.rating = '0.00',
    this.totalReviews = 0,
    required this.createdAt,
    required this.updatedAt,
    this.workingHours,
  });

  VendorProfile copyWith({
    String? id,
    String? userId,
    String? businessName,
    String? commercialLicenseNo,
    String? logoUrl,
    String? coverImageUrl,
    bool? isVerified,
    bool? isArchived,
    bool? isDeleted,
    bool? isActive,
    bool? isAvailable,
    VendorStatus? status,
    int? orderCapacity,
    String? rating,
    int? totalReviews,
    DateTime? createdAt,
    DateTime? updatedAt,
    WorkingHours? workingHours,
  }) {
    return VendorProfile(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      businessName: businessName ?? this.businessName,
      commercialLicenseNo: commercialLicenseNo ?? this.commercialLicenseNo,
      logoUrl: logoUrl ?? this.logoUrl,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      isVerified: isVerified ?? this.isVerified,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      isAvailable: isAvailable ?? this.isAvailable,
      status: status ?? this.status,
      orderCapacity: orderCapacity ?? this.orderCapacity,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      workingHours: workingHours ?? this.workingHours,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VendorProfile &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'VendorProfile(id: $id, businessName: $businessName, isVerified: $isVerified, isActive: $isActive, isArchived: $isArchived, isAvailable: $isAvailable, status: $status, orderCapacity: $orderCapacity)';
}
