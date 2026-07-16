import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/vendor-products/data/datasources/vendor_product_remote_data_source.dart';
import 'package:app/features/vendor-products/domain/entities/vendor_product.dart';
import 'package:app/features/vendor-products/domain/failures/vendor_product_failure.dart';
import 'package:app/features/vendor-products/domain/repositories/vendor_product_repository.dart';

class VendorProductRepositoryImpl implements VendorProductRepository {
  final VendorProductRemoteDataSource _remoteDataSource;

  VendorProductRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<VendorProduct>> getProducts(String vendorId) async {
    try {
      return await _remoteDataSource.getProducts(vendorId);
    } catch (e, stackTrace) {
      if (e is VendorProductFailure) rethrow;
      AppLogger.error('getProducts failed', error: e, stackTrace: stackTrace);
      throw VendorProductFailure.unknown(e.toString());
    }
  }

  @override
  Future<VendorProduct> getProduct(String id) async {
    try {
      return await _remoteDataSource.getProduct(id);
    } catch (e, stackTrace) {
      if (e is VendorProductFailure) rethrow;
      AppLogger.error('getProduct failed', error: e, stackTrace: stackTrace);
      throw VendorProductFailure.unknown(e.toString());
    }
  }

  @override
  Future<VendorProduct> createProduct(CreateProductParams params) async {
    try {
      return await _remoteDataSource.createProduct(params.toJson());
    } catch (e, stackTrace) {
      if (e is VendorProductFailure) rethrow;
      AppLogger.error('createProduct failed', error: e, stackTrace: stackTrace);
      throw VendorProductFailure.unknown(e.toString());
    }
  }

  @override
  Future<VendorProduct> updateProduct(
    String id,
    UpdateProductParams params,
  ) async {
    try {
      return await _remoteDataSource.updateProduct(id, params.toJson());
    } catch (e, stackTrace) {
      if (e is VendorProductFailure) rethrow;
      AppLogger.error('updateProduct failed', error: e, stackTrace: stackTrace);
      throw VendorProductFailure.unknown(e.toString());
    }
  }

  @override
  Future<VendorProduct> deleteProduct(String id) async {
    try {
      return await _remoteDataSource.deleteProduct(id);
    } catch (e, stackTrace) {
      if (e is VendorProductFailure) rethrow;
      AppLogger.error('deleteProduct failed', error: e, stackTrace: stackTrace);
      throw VendorProductFailure.unknown(e.toString());
    }
  }

  @override
  Future<VendorProduct> toggleProductActive(String id) async {
    try {
      return await _remoteDataSource.toggleProductActive(id);
    } catch (e, stackTrace) {
      if (e is VendorProductFailure) rethrow;
      AppLogger.error(
        'toggleProductActive failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw VendorProductFailure.unknown(e.toString());
    }
  }
}
