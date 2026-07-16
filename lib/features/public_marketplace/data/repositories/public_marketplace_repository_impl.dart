import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/public_marketplace/data/datasources/public_marketplace_remote_data_source.dart';
import 'package:app/features/public_marketplace/domain/failures/public_marketplace_failure.dart';
import 'package:app/features/public_marketplace/domain/repositories/public_marketplace_repository.dart';
import 'package:app/features/public_services/domain/entities/entities.dart';
import 'package:app/features/vendor-products/domain/entities/vendor_product.dart';

class PublicMarketplaceRepositoryImpl implements PublicMarketplaceRepository {
  final PublicMarketplaceRemoteDataSource _remoteDataSource;

  PublicMarketplaceRepositoryImpl(this._remoteDataSource);

  @override
  Future<VendorProduct> getProduct(String id) async {
    try {
      return await _remoteDataSource.getProduct(id);
    } catch (e, stackTrace) {
      if (e is PublicMarketplaceFailure) rethrow;
      AppLogger.error('getProduct failed', error: e, stackTrace: stackTrace);
      throw PublicMarketplaceFailure.unknown(e.toString());
    }
  }

  @override
  Future<List<PublicVendor>> getVendorsByProductType(
    String? productType,
  ) async {
    try {
      return await _remoteDataSource.getVendorsByProductType(productType);
    } catch (e, stackTrace) {
      if (e is PublicMarketplaceFailure) rethrow;
      AppLogger.error(
        'getVendorsByProductType failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw PublicMarketplaceFailure.unknown(e.toString());
    }
  }

  @override
  Future<List<VendorProduct>> getVendorProducts(
    String vendorId, {
    PublicProductFilter? filter,
  }) async {
    try {
      return await _remoteDataSource.getVendorProducts(
        vendorId,
        filter: filter,
      );
    } catch (e, stackTrace) {
      if (e is PublicMarketplaceFailure) rethrow;
      AppLogger.error(
        'getVendorProducts failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw PublicMarketplaceFailure.unknown(e.toString());
    }
  }
}
