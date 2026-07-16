import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/sell_your_car/data/datasources/datasources.dart';
import 'package:app/features/sell_your_car/data/models/models.dart';
import 'package:app/features/sell_your_car/data/exceptions/exceptions.dart';
import 'package:app/features/sell_your_car/domain/entities/entities.dart';
import 'package:app/features/sell_your_car/domain/repositories/repositories.dart';

class CarMarketplaceRepositoryImpl implements CarMarketplaceRepository {
  final CarMarketplaceRemoteDataSource _remoteDataSource;

  CarMarketplaceRepositoryImpl(this._remoteDataSource);

  @override
  Future<CarListing> createDraftListing(CreateListingRequest request) async {
    try {
      final modelRequest = CreateListingRequestModel(
        vehicleId: request.vehicleId,
        listingType: request.listingType,
        title: request.title,
        description: request.description,
        make: request.make,
        model: request.model,
        year: request.year,
        trim: request.trim,
        color: request.color,
        vin: request.vin,
        mileage: request.mileage,
        engineSize: request.engineSize,
        transmission: request.transmission,
        conditionStatus: request.conditionStatus,
        conditionReport: request.conditionReport,
        images: request.images,
        damageImages: request.damageImages,
        registrationDocUrl: request.registrationDocUrl,
        inspectionReportUrl: request.inspectionReportUrl,
        askingPrice: request.askingPrice,
        locationCity: request.locationCity,
        isFeatured: request.isFeatured,
        expiresAt: request.expiresAt,
        selectedPlanId: request.selectedPlanId,
      );
      return await _remoteDataSource.createDraftListing(modelRequest);
    } on CarListingException {
      rethrow;
    } on Exception catch (e, stackTrace) {
      AppLogger.error('FAILED', error: e, stackTrace: stackTrace);
      throw CarListingException.network();
    }
  }

  @override
  Future<CarListing> createFastTrackListing(
    CreateFastTrackRequest request,
  ) async {
    try {
      final modelRequest = CreateFastTrackRequestModel(
        vehicleId: request.vehicleId,
        listingType: request.listingType,
        title: request.title,
        description: request.description,
        make: request.make,
        model: request.model,
        year: request.year,
        trim: request.trim,
        color: request.color,
        vin: request.vin,
        mileage: request.mileage,
        engineSize: request.engineSize,
        transmission: request.transmission,
        conditionStatus: request.conditionStatus,
        conditionReport: request.conditionReport,
        images: request.images,
        damageImages: request.damageImages,
        registrationDocUrl: request.registrationDocUrl,
        inspectionReportUrl: request.inspectionReportUrl,
        askingPrice: request.askingPrice,
        locationCity: request.locationCity,
        isFeatured: request.isFeatured,
        expiresAt: request.expiresAt,
      );
      return await _remoteDataSource.createFastTrackListing(modelRequest);
    } on CarListingException {
      rethrow;
    } on Exception catch (e, stackTrace) {
      AppLogger.error('FAILED', error: e, stackTrace: stackTrace);
      throw CarListingException.network();
    }
  }

  @override
  Future<CarListing> updateListing(
    String id,
    UpdateListingRequest request,
  ) async {
    try {
      final modelRequest = UpdateListingRequestModel(
        vehicleId: request.vehicleId,
        title: request.title,
        description: request.description,
        make: request.make,
        model: request.model,
        year: request.year,
        trim: request.trim,
        color: request.color,
        vin: request.vin,
        mileage: request.mileage,
        engineSize: request.engineSize,
        transmission: request.transmission,
        conditionStatus: request.conditionStatus,
        conditionReport: request.conditionReport,
        images: request.images,
        damageImages: request.damageImages,
        registrationDocUrl: request.registrationDocUrl,
        inspectionReportUrl: request.inspectionReportUrl,
        askingPrice: request.askingPrice,
        locationCity: request.locationCity,
        isFeatured: request.isFeatured,
        expiresAt: request.expiresAt,
      );
      return await _remoteDataSource.updateListing(id, modelRequest);
    } on CarListingException {
      rethrow;
    } on Exception catch (e, stackTrace) {
      AppLogger.error('FAILED', error: e, stackTrace: stackTrace);
      throw CarListingException.network();
    }
  }

  @override
  Future<CarListing> getListing(String id) async {
    try {
      return await _remoteDataSource.getListing(id);
    } on CarListingException {
      rethrow;
    } on Exception catch (e, stackTrace) {
      AppLogger.error('FAILED', error: e, stackTrace: stackTrace);
      throw CarListingException.network();
    }
  }

  @override
  Future<List<CarListing>> getMyListings({int page = 1, int limit = 20}) async {
    try {
      return await _remoteDataSource.getMyListings(page: page, limit: limit);
    } on CarListingException {
      rethrow;
    } on Exception catch (e, stackTrace) {
      AppLogger.error('FAILED', error: e, stackTrace: stackTrace);
      throw CarListingException.network();
    }
  }

  @override
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
  }) async {
    try {
      return await _remoteDataSource.getListings(
        page: page,
        limit: limit,
        conditionStatus: conditionStatus,
        listingStatus: listingStatus,
        search: search,
        make: make,
        model: model,
        trim: trim,
        yearFrom: yearFrom,
        yearTo: yearTo,
        mileageFrom: mileageFrom,
        mileageTo: mileageTo,
        transmission: transmission,
      );
    } on CarListingException {
      rethrow;
    } on Exception catch (e, stackTrace) {
      AppLogger.error('FAILED', error: e, stackTrace: stackTrace);
      throw CarListingException.network();
    }
  }

  @override
  Future<FilterOptions> getFilterOptions() async {
    try {
      final model = await _remoteDataSource.getFilterOptions();
      return FilterOptions(
        makes: model.makes,
        models: model.models,
        trims: model.trims,
        years: model.years,
        transmissions: model.transmissions,
      );
    } on CarListingException {
      rethrow;
    } on Exception catch (e, stackTrace) {
      AppLogger.error('FAILED', error: e, stackTrace: stackTrace);
      throw CarListingException.network();
    }
  }

  @override
  Future<FastTrackSettings> getFastTrackSettings() async {
    try {
      final model = await _remoteDataSource.getFastTrackSettings();
      return model.toEntity();
    } on CarListingException {
      rethrow;
    } on Exception catch (e, stackTrace) {
      AppLogger.error('FAILED', error: e, stackTrace: stackTrace);
      throw CarListingException.network();
    }
  }

  @override
  Future<ListingPlansResponse> getListingPlans() async {
    try {
      final response = await _remoteDataSource.getListingPlans();
      return response;
    } on CarListingException {
      rethrow;
    } on Exception catch (e, stackTrace) {
      AppLogger.error('FAILED', error: e, stackTrace: stackTrace);
      throw CarListingException.network();
    }
  }

  @override
  Future<CarListing> publishListing(String id) async {
    try {
      return await _remoteDataSource.publishListing(id);
    } on CarListingException {
      rethrow;
    } on Exception catch (e, stackTrace) {
      AppLogger.error('FAILED', error: e, stackTrace: stackTrace);
      throw CarListingException.network();
    }
  }

  @override
  Future<void> deleteListing(String id) async {
    try {
      await _remoteDataSource.deleteListing(id);
    } on CarListingException {
      rethrow;
    } on Exception catch (e, stackTrace) {
      AppLogger.error('FAILED', error: e, stackTrace: stackTrace);
      throw CarListingException.network();
    }
  }
}
