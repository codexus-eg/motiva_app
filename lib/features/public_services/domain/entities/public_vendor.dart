class PublicVendor {
  final String id;
  final String? userId;
  final String businessName;
  final String? logoUrl;
  final String? coverImageUrl;
  final String? description;
  final String? rating;
  final int totalReviews;
  final int totalServices;
  final bool isVerified;
  final Map<String, dynamic>? workingHours;

  const PublicVendor({
    required this.id,
    this.userId,
    required this.businessName,
    this.logoUrl,
    this.coverImageUrl,
    this.description,
    this.rating,
    required this.totalReviews,
    required this.totalServices,
    this.isVerified = false,
    this.workingHours,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PublicVendor &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
