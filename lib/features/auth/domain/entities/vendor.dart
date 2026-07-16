class Vendor {
  final String id;
  final String userId;
  final String businessName;
  final String? commercialLicenseNo;
  final String? logoUrl;
  final bool isVerified;
  final bool isArchived;
  final bool isDeleted;
  final bool isActive;
  final double rating;
  final int totalReviews;

  const Vendor({
    required this.id,
    required this.userId,
    required this.businessName,
    this.commercialLicenseNo,
    this.logoUrl,
    this.isVerified = false,
    this.isArchived = false,
    this.isDeleted = false,
    this.isActive = true,
    this.rating = 0.0,
    this.totalReviews = 0,
  });

  Vendor copyWith({
    String? id,
    String? userId,
    String? businessName,
    String? commercialLicenseNo,
    String? logoUrl,
    bool? isVerified,
    bool? isArchived,
    bool? isDeleted,
    bool? isActive,
    double? rating,
    int? totalReviews,
  }) {
    return Vendor(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      businessName: businessName ?? this.businessName,
      commercialLicenseNo: commercialLicenseNo ?? this.commercialLicenseNo,
      logoUrl: logoUrl ?? this.logoUrl,
      isVerified: isVerified ?? this.isVerified,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'businessName': businessName,
    'commercialLicenseNo': commercialLicenseNo,
    'logoUrl': logoUrl,
    'isVerified': isVerified,
    'isArchived': isArchived,
    'isDeleted': isDeleted,
    'isActive': isActive,
    'rating': rating.toString(),
    'totalReviews': totalReviews,
  };

  factory Vendor.fromJson(Map<String, dynamic> json) {
    final isArchived = json['isArchived'] as bool? ?? false;
    final isDeleted = json['isDeleted'] as bool? ?? false;
    final isActive = json['isActive'] as bool?;

    return Vendor(
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
    );
  }

  static double _parseRating(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Vendor &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          businessName == other.businessName &&
          commercialLicenseNo == other.commercialLicenseNo &&
          logoUrl == other.logoUrl &&
          isVerified == other.isVerified &&
          isArchived == other.isArchived &&
          isDeleted == other.isDeleted &&
          isActive == other.isActive &&
          rating == other.rating &&
          totalReviews == other.totalReviews;

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    businessName,
    commercialLicenseNo,
    logoUrl,
    isVerified,
    isArchived,
    isDeleted,
    isActive,
    rating,
    totalReviews,
  );

  @override
  String toString() =>
      'Vendor(id: $id, userId: $userId, businessName: $businessName, isVerified: $isVerified, isActive: $isActive, isArchived: $isArchived)';
}
