enum ListingType { regular, fastTrack }

enum VehicleCondition { excellent, good, fair, poor, damaged }

enum ListingStatus {
  draft,
  pendingReview,
  buyoutQueue,
  active,
  rejected,
  sold,
  expired,
}

enum Transmission { automatic, manual }

class ConditionPoint {
  final int x;
  final int y;
  final String severity;
  final String? note;

  const ConditionPoint({
    required this.x,
    required this.y,
    required this.severity,
    this.note,
  });
}

class ConditionReport {
  final List<ConditionPoint> points;
  final String? overallNotes;
  final List<String>? damagedPanels;
  final bool? runsAndDrives;

  const ConditionReport({
    required this.points,
    this.overallNotes,
    this.damagedPanels,
    this.runsAndDrives,
  });
}

class CarListing {
  final String id;
  final String? vehicleId;
  final ListingType listingType;
  final String? title;
  final String? description;
  final String make;
  final String model;
  final int year;
  final String? trim;
  final String? color;
  final String? vin;
  final int mileage;
  final String? engineSize;
  final Transmission? transmission;
  final VehicleCondition conditionStatus;
  final ConditionReport? conditionReport;
  final List<String> images;
  final List<String>? damageImages;
  final String? registrationDocUrl;
  final String? inspectionReportUrl;
  final double? askingPrice;
  final double? fastTrackOfferAmount;
  final String? locationCity;
  final String sellerId;
  final ListingStatus listingStatus;
  final bool isFeatured;
  final DateTime? expiresAt;
  final DateTime? soldAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const CarListing({
    required this.id,
    this.vehicleId,
    required this.listingType,
    this.title,
    this.description,
    required this.make,
    required this.model,
    required this.year,
    this.trim,
    this.color,
    this.vin,
    required this.mileage,
    this.engineSize,
    this.transmission,
    required this.conditionStatus,
    this.conditionReport,
    required this.images,
    this.damageImages,
    this.registrationDocUrl,
    this.inspectionReportUrl,
    this.askingPrice,
    this.fastTrackOfferAmount,
    this.locationCity,
    required this.sellerId,
    required this.listingStatus,
    required this.isFeatured,
    this.expiresAt,
    this.soldAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
}
