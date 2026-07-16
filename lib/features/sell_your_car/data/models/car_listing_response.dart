import 'package:app/features/sell_your_car/domain/entities/entities.dart';

class CarListingResponseModel extends CarListing {
  const CarListingResponseModel({
    required super.id,
    super.vehicleId,
    required super.listingType,
    super.title,
    super.description,
    required super.make,
    required super.model,
    required super.year,
    super.trim,
    super.color,
    super.vin,
    required super.mileage,
    super.engineSize,
    super.transmission,
    required super.conditionStatus,
    super.conditionReport,
    required super.images,
    super.damageImages,
    super.registrationDocUrl,
    super.inspectionReportUrl,
    super.askingPrice,
    super.fastTrackOfferAmount,
    super.locationCity,
    required super.sellerId,
    required super.listingStatus,
    required super.isFeatured,
    super.expiresAt,
    super.soldAt,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
  });

  factory CarListingResponseModel.fromJson(Map<String, dynamic> json) {
    return CarListingResponseModel(
      id: json['id'] as String,
      vehicleId: json['vehicleId'] as String?,
      listingType: _parseListingType(json['listingType'] as String),
      title: json['title'] as String?,
      description: json['description'] as String?,
      make: json['make'] as String,
      model: json['model'] as String,
      year: json['year'] as int,
      trim: json['trim'] as String?,
      color: json['color'] as String?,
      vin: json['vin'] as String?,
      mileage: json['mileage'] as int,
      engineSize: json['engineSize'] as String?,
      transmission: json['transmission'] != null
          ? _parseTransmission(json['transmission'] as String)
          : null,
      conditionStatus: _parseVehicleCondition(
        json['conditionStatus'] as String,
      ),
      conditionReport: json['conditionReport'] != null
          ? _parseConditionReport(
              json['conditionReport'] as Map<String, dynamic>,
            )
          : null,
      images: List<String>.from(json['images'] as List),
      damageImages: json['damageImages'] != null
          ? List<String>.from(json['damageImages'] as List)
          : null,
      registrationDocUrl: json['registrationDocUrl'] as String?,
      inspectionReportUrl: json['inspectionReportUrl'] as String?,
      askingPrice: json['askingPrice'] != null
          ? double.parse(json['askingPrice'].toString())
          : null,
      fastTrackOfferAmount: json['fastTrackOfferAmount'] != null
          ? double.parse(json['fastTrackOfferAmount'].toString())
          : null,
      locationCity: json['locationCity'] as String?,
      sellerId: json['sellerId'] as String,
      listingStatus: _parseListingStatus(json['listingStatus'] as String),
      isFeatured: json['isFeatured'] as bool,
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'] as String)
          : null,
      soldAt: json['soldAt'] != null
          ? DateTime.parse(json['soldAt'] as String)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'] as String)
          : null,
    );
  }

  static ListingType _parseListingType(String value) {
    return ListingType.values.firstWhere(
      (e) => e.name.toUpperCase() == value.toUpperCase(),
      orElse: () => ListingType.regular,
    );
  }

  static Transmission? _parseTransmission(String value) {
    return Transmission.values.firstWhere(
      (e) => e.name.toUpperCase() == value.toUpperCase(),
      orElse: () => Transmission.automatic,
    );
  }

  static VehicleCondition _parseVehicleCondition(String value) {
    return VehicleCondition.values.firstWhere(
      (e) => e.name.toUpperCase() == value.toUpperCase(),
      orElse: () => VehicleCondition.good,
    );
  }

  static ListingStatus _parseListingStatus(String value) {
    return ListingStatus.values.firstWhere(
      (e) => e.name.toUpperCase() == value.toUpperCase(),
      orElse: () => ListingStatus.draft,
    );
  }

  static ConditionReport? _parseConditionReport(Map<String, dynamic> json) {
    final pointsJson = json['points'] as List<dynamic>?;
    return ConditionReport(
      points:
          pointsJson
              ?.map(
                (p) => ConditionPoint(
                  x: p['x'] as int,
                  y: p['y'] as int,
                  severity: p['severity'] as String,
                  note: p['note'] as String?,
                ),
              )
              .toList() ??
          [],
      overallNotes: json['overallNotes'] as String?,
      damagedPanels: json['damagedPanels'] != null
          ? List<String>.from(json['damagedPanels'] as List)
          : null,
      runsAndDrives: json['runsAndDrives'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicleId': vehicleId,
      'listingType': listingType.name.toUpperCase(),
      'title': title,
      'description': description,
      'make': make,
      'model': model,
      'year': year,
      'trim': trim,
      'color': color,
      'vin': vin,
      'mileage': mileage,
      'engineSize': engineSize,
      'transmission': transmission?.name.toUpperCase(),
      'conditionStatus': conditionStatus.name.toUpperCase(),
      'conditionReport': conditionReport != null
          ? {
              'points': conditionReport!.points
                  .map(
                    (p) => {
                      'x': p.x,
                      'y': p.y,
                      'severity': p.severity,
                      'note': p.note,
                    },
                  )
                  .toList(),
              'overallNotes': conditionReport!.overallNotes,
              'damagedPanels': conditionReport!.damagedPanels,
              'runsAndDrives': conditionReport!.runsAndDrives,
            }
          : null,
      'images': images,
      'damageImages': damageImages,
      'registrationDocUrl': registrationDocUrl,
      'inspectionReportUrl': inspectionReportUrl,
      'askingPrice': askingPrice,
      'fastTrackOfferAmount': fastTrackOfferAmount,
      'locationCity': locationCity,
      'sellerId': sellerId,
      'listingStatus': listingStatus.name.toUpperCase(),
      'isFeatured': isFeatured,
      'expiresAt': expiresAt?.toIso8601String(),
      'soldAt': soldAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }

  static List<CarListingResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CarListingResponseModel.fromJson(json))
        .toList();
  }
}
