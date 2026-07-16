import 'package:app/features/sell_your_car/domain/entities/entities.dart';

class CreateListingRequest {
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
  final String? selectedPlanId;

  const CreateListingRequest({
    this.vehicleId,
    this.listingType = 'REGULAR',
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
    this.selectedPlanId,
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
      if (expiresAt != null) 'expiresAt': expiresAt?.toIso8601String(),
      if (selectedPlanId != null) 'selectedPlanId': selectedPlanId,
    };
  }
}

class UpdateListingRequest {
  final String? vehicleId;
  final String? title;
  final String? description;
  final String? make;
  final String? model;
  final int? year;
  final String? trim;
  final String? color;
  final String? vin;
  final int? mileage;
  final String? engineSize;
  final String? transmission;
  final String? conditionStatus;
  final Map<String, dynamic>? conditionReport;
  final List<String>? images;
  final List<String>? damageImages;
  final String? registrationDocUrl;
  final String? inspectionReportUrl;
  final double? askingPrice;
  final String? locationCity;
  final bool? isFeatured;
  final DateTime? expiresAt;

  const UpdateListingRequest({
    this.vehicleId,
    this.title,
    this.description,
    this.make,
    this.model,
    this.year,
    this.trim,
    this.color,
    this.vin,
    this.mileage,
    this.engineSize,
    this.transmission,
    this.conditionStatus,
    this.conditionReport,
    this.images,
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
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (make != null) 'make': make,
      if (model != null) 'model': model,
      if (year != null) 'year': year,
      if (trim != null) 'trim': trim,
      if (color != null) 'color': color,
      if (vin != null) 'vin': vin,
      if (mileage != null) 'mileage': mileage,
      if (engineSize != null) 'engineSize': engineSize,
      if (transmission != null) 'transmission': transmission,
      if (conditionStatus != null) 'conditionStatus': conditionStatus,
      if (conditionReport != null) 'conditionReport': conditionReport,
      if (images != null) 'images': images,
      if (damageImages != null) 'damageImages': damageImages,
      if (registrationDocUrl != null) 'registrationDocUrl': registrationDocUrl,
      if (inspectionReportUrl != null)
        'inspectionReportUrl': inspectionReportUrl,
      if (askingPrice != null) 'askingPrice': askingPrice,
      if (locationCity != null) 'locationCity': locationCity,
      if (isFeatured != null) 'isFeatured': isFeatured,
      if (expiresAt != null) 'expiresAt': expiresAt?.toIso8601String(),
    };
  }
}

abstract class CarMarketplaceRepository {
  Future<CarListing> createDraftListing(CreateListingRequest request);
  Future<CarListing> createFastTrackListing(CreateFastTrackRequest request);
  Future<CarListing> updateListing(String id, UpdateListingRequest request);
  Future<CarListing> getListing(String id);
  Future<List<CarListing>> getMyListings({int page = 1, int limit = 20});
  Future<List<CarListing>> getListings({
    int page = 1,
    int limit = 20,
    String? conditionStatus,
    String? listingStatus,
    String? search,
    String? make,
    String? model,
    String? trim,
    int? yearFrom,
    int? yearTo,
    int? mileageFrom,
    int? mileageTo,
    String? transmission,
  });
  Future<FilterOptions> getFilterOptions();
  Future<FastTrackSettings> getFastTrackSettings();
  Future<ListingPlansResponse> getListingPlans();
  Future<CarListing> publishListing(String id);
  Future<void> deleteListing(String id);
}

class FilterOptions {
  final List<String> makes;
  final Map<String, List<String>> models;
  final Map<String, List<String>> trims;
  final ({int min, int max}) years;
  final List<String> transmissions;

  const FilterOptions({
    required this.makes,
    required this.models,
    required this.trims,
    required this.years,
    required this.transmissions,
  });
}

class CreateFastTrackRequest {
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

  const CreateFastTrackRequest({
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
      if (expiresAt != null) 'expiresAt': expiresAt?.toIso8601String(),
    };
  }
}
