import 'package:app/features/sell_your_car/data/datasources/datasources.dart';
import 'package:app/features/sell_your_car/data/exceptions/exceptions.dart';
import 'package:app/features/sell_your_car/domain/entities/entities.dart';
import 'package:app/features/sell_your_car/domain/repositories/repositories.dart';
import 'package:app/core/utils/app_logger.dart';

class CarDataRepositoryImpl implements CarDataRepository {
  final CarDataRemoteDataSource _remoteDataSource;

  CarDataRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<CarMake>> getMakes() async {
    try {
      return await _remoteDataSource.getMakes();
    } on CarListingException {
      rethrow;
    } on Exception catch (e, stackTrace) {
      AppLogger.error('getMakes failed', error: e, stackTrace: stackTrace);
      throw CarListingException.network();
    }
  }

  @override
  Future<List<CarMake>> searchMakes(String query) async {
    try {
      return await _remoteDataSource.searchMakes(query);
    } on CarListingException {
      rethrow;
    } on Exception catch (e, stackTrace) {
      AppLogger.error('searchMakes failed', error: e, stackTrace: stackTrace);
      throw CarListingException.network();
    }
  }

  @override
  Future<List<CarModel>> getModelsByMake(String makeId) async {
    try {
      return await _remoteDataSource.getModelsByMake(makeId);
    } on CarListingException {
      rethrow;
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'getModelsByMake failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw CarListingException.network();
    }
  }

  @override
  Future<List<CarTrim>> getTrimsByModel(String modelId) async {
    try {
      return await _remoteDataSource.getTrimsByModel(modelId);
    } on CarListingException {
      rethrow;
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'getTrimsByModel failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw CarListingException.network();
    }
  }

  @override
  Future<List<int>> getYearsForModel(String modelId) async {
    try {
      return await _remoteDataSource.getYearsForModel(modelId);
    } on CarListingException {
      rethrow;
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'getYearsForModel failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw CarListingException.network();
    }
  }
}
