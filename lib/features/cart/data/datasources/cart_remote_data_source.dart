import 'package:app/core/network/dio_client.dart';
import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/cart/domain/entities/cart.dart';
import 'package:app/features/cart/domain/failures/cart_failure.dart';
import 'package:dio/dio.dart';

abstract class CartRemoteDataSource {
  Future<Cart> getCart();
  Future<Cart> addItem(String productId, int quantity);
  Future<Cart> updateItem(String itemId, int quantity);
  Future<Cart> removeItem(String itemId);
  Future<Cart> clearCart();
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final DioClient _dioClient;

  CartRemoteDataSourceImpl(this._dioClient);

  @override
  Future<Cart> getCart() async {
    try {
      final response = await _dioClient.dio.get('/api/cart');
      return Cart.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getCart failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<Cart> addItem(String productId, int quantity) async {
    try {
      final response = await _dioClient.dio.post(
        '/api/cart/items',
        data: {'productId': productId, 'quantity': quantity},
      );
      return Cart.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('addItem failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<Cart> updateItem(String itemId, int quantity) async {
    try {
      final response = await _dioClient.dio.put(
        '/api/cart/items/$itemId',
        data: {'quantity': quantity},
      );
      return Cart.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('updateItem failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<Cart> removeItem(String itemId) async {
    try {
      final response = await _dioClient.dio.delete('/api/cart/items/$itemId');
      return Cart.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('removeItem failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  @override
  Future<Cart> clearCart() async {
    try {
      final response = await _dioClient.dio.delete('/api/cart/clear');
      return Cart.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('clearCart failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  CartFailure _handleError(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = DioErrorHandler.handle(e).message;

    switch (statusCode) {
      case 401:
        return CartFailure.unauthorized();
      case 404:
        return CartFailure.notFound();
      case 400:
        return CartFailure.validation(message);
      case 500:
        return CartFailure.serverError();
      default:
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          return CartFailure.networkError();
        }
        return CartFailure.unknown(message);
    }
  }
}
