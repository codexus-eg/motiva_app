import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/vendor-services/data/datasources/vendor_service_remote_data_source.dart';
import 'package:app/features/vendor-services/domain/entities/vendor_service.dart';
import 'package:app/features/vendor-services/domain/failures/vendor_service_failure.dart';
import 'package:app/features/vendor-services/domain/repositories/vendor_service_repository.dart';

class VendorServiceRepositoryImpl implements VendorServiceRepository {
  final VendorServiceRemoteDataSource _remoteDataSource;

  VendorServiceRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<VendorService>> getServices() async {
    try {
      return await _remoteDataSource.getServices();
    } catch (e, stackTrace) {
      if (e is VendorServiceFailure) rethrow;
      AppLogger.error('getServices failed', error: e, stackTrace: stackTrace);
      throw VendorServiceFailure.unknown(e.toString());
    }
  }

  @override
  Future<VendorService> getService(String id) async {
    try {
      return await _remoteDataSource.getService(id);
    } catch (e, stackTrace) {
      if (e is VendorServiceFailure) rethrow;
      AppLogger.error('getService failed', error: e, stackTrace: stackTrace);
      throw VendorServiceFailure.unknown(e.toString());
    }
  }

  @override
  Future<VendorService> createService(CreateServiceParams params) async {
    try {
      return await _remoteDataSource.createService(params.toJson());
    } catch (e, stackTrace) {
      if (e is VendorServiceFailure) rethrow;
      AppLogger.error('createService failed', error: e, stackTrace: stackTrace);
      throw VendorServiceFailure.unknown(e.toString());
    }
  }

  @override
  Future<VendorService> updateService(
    String id,
    UpdateServiceParams params,
  ) async {
    try {
      return await _remoteDataSource.updateService(id, params.toJson());
    } catch (e, stackTrace) {
      if (e is VendorServiceFailure) rethrow;
      AppLogger.error('updateService failed', error: e, stackTrace: stackTrace);
      throw VendorServiceFailure.unknown(e.toString());
    }
  }

  @override
  Future<VendorService> archiveService(String id) async {
    try {
      return await _remoteDataSource.archiveService(id);
    } catch (e, stackTrace) {
      if (e is VendorServiceFailure) rethrow;
      AppLogger.error(
        'archiveService failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw VendorServiceFailure.unknown(e.toString());
    }
  }

  @override
  Future<VendorService> restoreService(String id) async {
    try {
      return await _remoteDataSource.restoreService(id);
    } catch (e, stackTrace) {
      if (e is VendorServiceFailure) rethrow;
      AppLogger.error(
        'restoreService failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw VendorServiceFailure.unknown(e.toString());
    }
  }
}
