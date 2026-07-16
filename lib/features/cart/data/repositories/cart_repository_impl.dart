import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:app/features/cart/domain/entities/cart.dart';
import 'package:app/features/cart/domain/failures/cart_failure.dart';
import 'package:app/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _remoteDataSource;

  CartRepositoryImpl(this._remoteDataSource);

  @override
  Future<Cart> getCart() async {
    try {
      return await _remoteDataSource.getCart();
    } catch (e, stackTrace) {
      if (e is CartFailure) rethrow;
      AppLogger.error('getCart failed', error: e, stackTrace: stackTrace);
      throw CartFailure.unknown(e.toString());
    }
  }

  @override
  Future<Cart> addItem({required String productId, required int quantity}) async {
    try {
      return await _remoteDataSource.addItem(productId, quantity);
    } catch (e, stackTrace) {
      if (e is CartFailure) rethrow;
      AppLogger.error('addItem failed', error: e, stackTrace: stackTrace);
      throw CartFailure.unknown(e.toString());
    }
  }

  @override
  Future<Cart> updateItem({required String itemId, required int quantity}) async {
    try {
      return await _remoteDataSource.updateItem(itemId, quantity);
    } catch (e, stackTrace) {
      if (e is CartFailure) rethrow;
      AppLogger.error('updateItem failed', error: e, stackTrace: stackTrace);
      throw CartFailure.unknown(e.toString());
    }
  }

  @override
  Future<Cart> removeItem({required String itemId}) async {
    try {
      return await _remoteDataSource.removeItem(itemId);
    } catch (e, stackTrace) {
      if (e is CartFailure) rethrow;
      AppLogger.error('removeItem failed', error: e, stackTrace: stackTrace);
      throw CartFailure.unknown(e.toString());
    }
  }

  @override
  Future<Cart> clearCart() async {
    try {
      return await _remoteDataSource.clearCart();
    } catch (e, stackTrace) {
      if (e is CartFailure) rethrow;
      AppLogger.error('clearCart failed', error: e, stackTrace: stackTrace);
      throw CartFailure.unknown(e.toString());
    }
  }
}
