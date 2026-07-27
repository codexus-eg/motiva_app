import 'package:app/core/network/dio_client.dart';
import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/vendor-cars/data/models/vendor_car_model.dart';
import 'package:app/features/vendor-cars/domain/entities/vendor_car.dart';
import 'package:app/features/vendor-cars/domain/failures/vendor_car_failure.dart';
import 'package:dio/dio.dart';

abstract class VendorCarRemoteDataSource {
  Future<List<VendorCar>> getCars({int page, int limit});
  Future<VendorCar> getCar(String id);
  Future<VendorCar> createCar(Map<String, dynamic> request);
  Future<VendorCar> updateCar(String id, Map<String, dynamic> request);
  Future<VendorCar> deleteCar(String id);
}

class VendorCarRemoteDataSourceImpl implements VendorCarRemoteDataSource {
  final DioClient _dioClient;

  VendorCarRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<VendorCar>> getCars({int page = 1, int limit = 20}) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/car-marketplace/my-listings',
        queryParameters: {'page': page, 'limit': limit},
      );
      final List<dynamic> data = response.data;
      return VendorCarModel.fromJsonList(data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getCars failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('getCars failed', error: e, stackTrace: stackTrace);
      throw VendorCarFailure.unknown(e.toString());
    }
  }

  @override
  Future<VendorCar> getCar(String id) async {
    try {
      final response = await _dioClient.dio.get('/api/car-marketplace/$id');
      return VendorCarModel.fromJson(
        response.data as Map<String, dynamic>,
      ).vendorCar;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getCar failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<VendorCar> createCar(Map<String, dynamic> request) async {
    try {
      final response = await _dioClient.dio.post(
        '/api/car-marketplace',
        data: request,
      );
      return VendorCarModel.fromJson(
        response.data as Map<String, dynamic>,
      ).vendorCar;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('createCar failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<VendorCar> updateCar(String id, Map<String, dynamic> request) async {
    try {
      final response = await _dioClient.dio.patch(
        '/api/car-marketplace/$id',
        data: request,
      );
      return VendorCarModel.fromJson(
        response.data as Map<String, dynamic>,
      ).vendorCar;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('updateCar failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<VendorCar> deleteCar(String id) async {
    try {
      final response = await _dioClient.dio.delete('/api/car-marketplace/$id');
      return VendorCarModel.fromJson(
        response.data as Map<String, dynamic>,
      ).vendorCar;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('deleteCar failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }


  VendorCarFailure _handleError(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = DioErrorHandler.handle(e).message;

    switch (statusCode) {
      case 401:
        return VendorCarFailure.unauthorized();
      case 404:
        return VendorCarFailure.notFound();
      case 400:
        return VendorCarFailure.validation(message);
      case 500:
        return VendorCarFailure.serverError();
      default:
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          return VendorCarFailure.networkError();
        }
        return VendorCarFailure.unknown(message);
    }
  }
}
