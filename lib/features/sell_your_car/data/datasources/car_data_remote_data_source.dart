import 'package:app/core/network/dio_client.dart';
import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/sell_your_car/data/models/models.dart';
import 'package:app/features/sell_your_car/data/exceptions/exceptions.dart';
import 'package:dio/dio.dart';

abstract class CarDataRemoteDataSource {
  Future<List<CarMakeModel>> getMakes();
  Future<List<CarMakeModel>> searchMakes(String query);
  Future<List<CarModelModel>> getModelsByMake(String makeId);
  Future<List<CarTrimModel>> getTrimsByModel(String modelId);
  Future<List<int>> getYearsForModel(String modelId);
}

class CarDataRemoteDataSourceImpl implements CarDataRemoteDataSource {
  final DioClient _dioClient;

  CarDataRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<CarMakeModel>> getMakes() async {
    try {
      final response = await _dioClient.dio.get('/api/car-data/makes');
      final List<dynamic> data = response.data;
      return CarMakeModel.fromJsonList(data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getMakes failed', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('getMakes failed', error: e, stackTrace: stackTrace);
      throw CarListingException.unknown(e.toString());
    }
  }

  @override
  Future<List<CarMakeModel>> searchMakes(String query) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/car-data/makes/search',
        queryParameters: {'q': query},
      );
      final List<dynamic> data = response.data;
      return CarMakeModel.fromJsonList(data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('searchMakes failed', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('searchMakes failed', error: e, stackTrace: stackTrace);
      throw CarListingException.unknown(e.toString());
    }
  }

  @override
  Future<List<CarModelModel>> getModelsByMake(String makeId) async {
    try {
      final response = await _dioClient.dio.get('/api/car-data/models/$makeId');
      final List<dynamic> data = response.data;
      return CarModelModel.fromJsonList(data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getModelsByMake failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'getModelsByMake failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw CarListingException.unknown(e.toString());
    }
  }

  @override
  Future<List<CarTrimModel>> getTrimsByModel(String modelId) async {
    try {
      final response = await _dioClient.dio.get('/api/car-data/trims/$modelId');
      final List<dynamic> data = response.data;
      return CarTrimModel.fromJsonList(data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getTrimsByModel failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'getTrimsByModel failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw CarListingException.unknown(e.toString());
    }
  }

  @override
  Future<List<int>> getYearsForModel(String modelId) async {
    try {
      final response = await _dioClient.dio.get('/api/car-data/years/$modelId');
      final List<dynamic> data = response.data;
      return data.map((e) => e as int).toList();
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getYearsForModel failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'getYearsForModel failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw CarListingException.unknown(e.toString());
    }
  }

  CarListingException _handleDioError(DioException e) {
    final errorInfo = DioErrorHandler.handle(e);
    final message = errorInfo.message;

    switch (errorInfo.statusCode) {
      case 401:
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
