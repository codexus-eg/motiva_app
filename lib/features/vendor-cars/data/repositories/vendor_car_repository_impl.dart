import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/vendor-cars/data/datasources/vendor_car_remote_data_source.dart';
import 'package:app/features/vendor-cars/domain/entities/vendor_car.dart';
import 'package:app/features/vendor-cars/domain/failures/vendor_car_failure.dart';
import 'package:app/features/vendor-cars/domain/repositories/vendor_car_repository.dart';

class VendorCarRepositoryImpl implements VendorCarRepository {
  final VendorCarRemoteDataSource _remoteDataSource;

  VendorCarRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<VendorCar>> getCars({int page = 1, int limit = 20}) async {
    try {
      return await _remoteDataSource.getCars(page: page, limit: limit);
    } catch (e, stackTrace) {
      if (e is VendorCarFailure) rethrow;
      AppLogger.error('getCars failed', error: e, stackTrace: stackTrace);
      throw VendorCarFailure.unknown(e.toString());
    }
  }

  @override
  Future<VendorCar> getCar(String id) async {
    try {
      return await _remoteDataSource.getCar(id);
    } catch (e, stackTrace) {
      if (e is VendorCarFailure) rethrow;
      AppLogger.error('getCar failed', error: e, stackTrace: stackTrace);
      throw VendorCarFailure.unknown(e.toString());
    }
  }

  @override
  Future<VendorCar> createCar(CreateCarParams params) async {
    try {
      return await _remoteDataSource.createCar(params.toJson());
    } catch (e, stackTrace) {
      if (e is VendorCarFailure) rethrow;
      AppLogger.error('createCar failed', error: e, stackTrace: stackTrace);
      throw VendorCarFailure.unknown(e.toString());
    }
  }

  @override
  Future<VendorCar> updateCar(String id, UpdateCarParams params) async {
    try {
      return await _remoteDataSource.updateCar(id, params.toJson());
    } catch (e, stackTrace) {
      if (e is VendorCarFailure) rethrow;
      AppLogger.error('updateCar failed', error: e, stackTrace: stackTrace);
      throw VendorCarFailure.unknown(e.toString());
    }
  }

  @override
  Future<VendorCar> deleteCar(String id) async {
    try {
      return await _remoteDataSource.deleteCar(id);
    } catch (e, stackTrace) {
      if (e is VendorCarFailure) rethrow;
      AppLogger.error('deleteCar failed', error: e, stackTrace: stackTrace);
      throw VendorCarFailure.unknown(e.toString());
    }
  }
}
