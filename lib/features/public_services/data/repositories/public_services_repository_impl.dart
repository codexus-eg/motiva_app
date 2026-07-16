import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/public_services/data/datasources/public_services_remote_data_source.dart';
import 'package:app/features/public_services/domain/entities/entities.dart';
import 'package:app/features/public_services/domain/failures/public_services_failure.dart';
import 'package:app/features/public_services/domain/repositories/public_services_repository.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';

class PublicServicesRepositoryImpl implements PublicServicesRepository {
  final PublicServicesRemoteDataSource _remoteDataSource;

  PublicServicesRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<ServiceCategory>> getServiceCategories() async {
    try {
      return await _remoteDataSource.getServiceCategories();
    } on PublicServicesFailure {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error(
        'getServiceCategories failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw PublicServicesFailure.unknown(e.toString());
    }
  }

  @override
  Future<ServiceCategoryWithSchema> getCategoryDetails(
    String categoryId,
  ) async {
    try {
      return await _remoteDataSource.getCategoryDetails(categoryId);
    } on PublicServicesFailure {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error(
        'getCategoryDetails failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw PublicServicesFailure.unknown(e.toString());
    }
  }

  @override
  Future<List<PublicVendor>> getVendorsByCategory(String categoryId) async {
    try {
      return await _remoteDataSource.getVendorsByCategory(categoryId);
    } on PublicServicesFailure {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error(
        'getVendorsByCategory failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw PublicServicesFailure.unknown(e.toString());
    }
  }

  @override
  Future<PublicVendor> getVendorProfile(String vendorId) async {
    try {
      return await _remoteDataSource.getVendorProfile(vendorId);
    } on PublicServicesFailure {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error(
        'getVendorProfile failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw PublicServicesFailure.unknown(e.toString());
    }
  }

  @override
  Future<List<PublicVendorService>> getVendorServices({
    String? categoryId,
    String? vendorId,
  }) async {
    try {
      return await _remoteDataSource.getVendorServices(
        categoryId: categoryId,
        vendorId: vendorId,
      );
    } on PublicServicesFailure {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error(
        'getVendorServices failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw PublicServicesFailure.unknown(e.toString());
    }
  }

  @override
  Future<PublicVendorService> getServiceDetails(String serviceId) async {
    try {
      return await _remoteDataSource.getServiceDetails(serviceId);
    } on PublicServicesFailure {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error(
        'getServiceDetails failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw PublicServicesFailure.unknown(e.toString());
    }
  }
}
