import 'package:app/core/network/dio_client.dart';
import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/sell_your_car/data/models/models.dart';
import 'package:app/features/sell_your_car/data/exceptions/exceptions.dart';
import 'package:app/features/sell_your_car/domain/entities/listing_plan.dart';
import 'package:dio/dio.dart';

abstract class CarMarketplaceRemoteDataSource {
  Future<CarListingResponseModel> createDraftListing(
    CreateListingRequestModel request,
  );
  Future<CarListingResponseModel> createFastTrackListing(
    CreateFastTrackRequestModel request,
  );
  Future<CarListingResponseModel> updateListing(
    String id,
    UpdateListingRequestModel request,
  );
  Future<CarListingResponseModel> getListing(String id);
  Future<List<CarListingResponseModel>> getMyListings({
    int page = 1,
    int limit = 20,
  });
  Future<List<CarListingResponseModel>> getListings({
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
  Future<FilterOptionsModel> getFilterOptions();
  Future<FastTrackSettingsModel> getFastTrackSettings();
  Future<ListingPlansResponse> getListingPlans();
  Future<CarListingResponseModel> publishListing(String id);
  Future<void> deleteListing(String id);
}

class CarMarketplaceRemoteDataSourceImpl
    implements CarMarketplaceRemoteDataSource {
  final DioClient _dioClient;

  CarMarketplaceRemoteDataSourceImpl(this._dioClient);

  @override
  Future<CarListingResponseModel> createDraftListing(
    CreateListingRequestModel request,
  ) async {
    try {
      final response = await _dioClient.dio.post(
        '/api/car-marketplace',
        data: request.toJson(),
      );
      return CarListingResponseModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'createDraftListing failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'createDraftListing failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw CarListingException.unknown(e.toString());
    }
  }

  @override
  Future<CarListingResponseModel> createFastTrackListing(
    CreateFastTrackRequestModel request,
  ) async {
    try {
      final response = await _dioClient.dio.post(
        '/api/car-marketplace',
        data: request.toJson(),
      );
      return CarListingResponseModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'createFastTrackListing failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'createFastTrackListing failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw CarListingException.unknown(e.toString());
    }
  }

  @override
  Future<CarListingResponseModel> updateListing(
    String id,
    UpdateListingRequestModel request,
  ) async {
    try {
      final response = await _dioClient.dio.patch(
        '/api/car-marketplace/$id',
        data: request.toJson(),
      );
      return CarListingResponseModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('updateListing failed', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('updateListing failed', error: e, stackTrace: stackTrace);
      throw CarListingException.unknown(e.toString());
    }
  }

  @override
  Future<CarListingResponseModel> getListing(String id) async {
    try {
      final response = await _dioClient.dio.get('/api/car-marketplace/$id');
      return CarListingResponseModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getListing failed', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('getListing failed', error: e, stackTrace: stackTrace);
      throw CarListingException.unknown(e.toString());
    }
  }

  @override
  Future<List<CarListingResponseModel>> getMyListings({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/car-marketplace/my-listings',
        queryParameters: {'page': page, 'limit': limit},
      );
      final List<dynamic> data = response.data;
      return CarListingResponseModel.fromJsonList(data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getMyListings failed', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('getMyListings failed', error: e, stackTrace: stackTrace);
      throw CarListingException.unknown(e.toString());
    }
  }

  @override
  Future<List<CarListingResponseModel>> getListings({
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
      final queryParams = <String, dynamic>{'page': page, 'limit': limit};
      if (conditionStatus != null) {
        queryParams['conditionStatus'] = conditionStatus;
      }
      if (listingStatus != null) {
        queryParams['listingStatus'] = listingStatus;
      }
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (make != null && make.isNotEmpty) {
        queryParams['make'] = make;
      }
      if (model != null && model.isNotEmpty) {
        queryParams['model'] = model;
      }
      if (trim != null && trim.isNotEmpty) {
        queryParams['trim'] = trim;
      }
      if (yearFrom != null) {
        queryParams['yearFrom'] = yearFrom;
      }
      if (yearTo != null) {
        queryParams['yearTo'] = yearTo;
      }
      if (mileageFrom != null) {
        queryParams['mileageFrom'] = mileageFrom;
      }
      if (mileageTo != null) {
        queryParams['mileageTo'] = mileageTo;
      }
      if (transmission != null && transmission.isNotEmpty) {
        queryParams['transmission'] = transmission;
      }
      final response = await _dioClient.dio.get(
        '/api/car-marketplace',
        queryParameters: queryParams,
      );
      final List<dynamic> data = response.data;
      return CarListingResponseModel.fromJsonList(data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getListings failed', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('getListings failed', error: e, stackTrace: stackTrace);
      throw CarListingException.unknown(e.toString());
    }
  }

  @override
  Future<FilterOptionsModel> getFilterOptions() async {
    try {
      final response = await _dioClient.dio.get(
        '/api/car-marketplace/filter-options',
      );
      return FilterOptionsModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getFilterOptions failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'getFilterOptions failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw CarListingException.unknown(e.toString());
    }
  }

  @override
  Future<FastTrackSettingsModel> getFastTrackSettings() async {
    try {
      final response = await _dioClient.dio.get(
        '/api/car-marketplace/fast-track/settings',
      );
      return FastTrackSettingsModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getFastTrackSettings failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'getFastTrackSettings failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw CarListingException.unknown(e.toString());
    }
  }

  @override
  Future<ListingPlansResponse> getListingPlans() async {
    try {
      final response = await _dioClient.dio.get('/api/car-marketplace/listing-plans');
      return ListingPlansResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getListingPlans failed', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('getListingPlans failed', error: e, stackTrace: stackTrace);
      throw CarListingException.unknown(e.toString());
    }
  }

  @override
  Future<CarListingResponseModel> publishListing(String id) async {
    try {
      final response = await _dioClient.dio.post(
        '/api/car-marketplace/$id/publish',
      );
      return CarListingResponseModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'publishListing failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'publishListing failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw CarListingException.unknown(e.toString());
    }
  }

  @override
  Future<void> deleteListing(String id) async {
    try {
      await _dioClient.dio.delete('/api/car-marketplace/$id');
    } on DioException catch (e, stackTrace) {
      AppLogger.error('deleteListing failed', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('deleteListing failed', error: e, stackTrace: stackTrace);
      throw CarListingException.unknown(e.toString());
    }
  }

  CarListingException _handleDioError(DioException e) {
    final errorInfo = DioErrorHandler.handle(e);
    final message = errorInfo.message;

    switch (errorInfo.statusCode) {
      case 401:
        return CarListingException.unauthorized(message);
      case 403:
        return CarListingException.unauthorized(message);
      case 404:
        return CarListingException.notFound(message);
      case 400:
        return CarListingException.validation(message);
      case 500:
        return CarListingException.serverError(message);
      default:
        return CarListingException.unknown(message);
    }
  }
}
