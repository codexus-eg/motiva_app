class CreateFastTrackRequestModel {
  final String? vehicleId;
  final String listingType;
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
  final String? transmission;
  final String conditionStatus;
  final Map<String, dynamic>? conditionReport;
  final List<String> images;
  final List<String>? damageImages;
  final String? registrationDocUrl;
  final String? inspectionReportUrl;
  final double? askingPrice;
  final String? locationCity;
  final bool? isFeatured;
  final DateTime? expiresAt;

  const CreateFastTrackRequestModel({
    this.vehicleId,
    this.listingType = 'FAST_TRACK',
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
    this.locationCity,
    this.isFeatured,
    this.expiresAt,
  });

  Map<String, dynamic> toJson() {
    return {
      if (vehicleId != null) 'vehicleId': vehicleId,
      'listingType': listingType,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      'make': make,
      'model': model,
      'year': year,
      if (trim != null) 'trim': trim,
      if (color != null) 'color': color,
      if (vin != null) 'vin': vin,
      'mileage': mileage,
      if (engineSize != null) 'engineSize': engineSize,
      if (transmission != null) 'transmission': transmission,
      'conditionStatus': conditionStatus,
      if (conditionReport != null) 'conditionReport': conditionReport,
      'images': images,
      if (damageImages != null) 'damageImages': damageImages,
      if (registrationDocUrl != null) 'registrationDocUrl': registrationDocUrl,
      if (inspectionReportUrl != null)
        'inspectionReportUrl': inspectionReportUrl,
      if (askingPrice != null) 'askingPrice': askingPrice,
      if (locationCity != null) 'locationCity': locationCity,
      if (isFeatured != null) 'isFeatured': isFeatured,
      if (expiresAt != null) 'expiresAt': expiresAt!.toIso8601String(),
    };
  }
}
