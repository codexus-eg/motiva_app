import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/customer_checkout_orders/data/datasources/checkout_orders_remote_data_source.dart';
import 'package:app/features/customer_checkout_orders/domain/entities/checkout_order.dart';
import 'package:app/features/customer_checkout_orders/domain/entities/checkout_order_detail.dart';
import 'package:app/features/customer_checkout_orders/domain/failures/checkout_orders_failure.dart';
import 'package:app/features/customer_checkout_orders/domain/repositories/checkout_orders_repository.dart';
import 'package:dio/dio.dart';

class CheckoutOrdersRepositoryImpl implements CheckoutOrdersRepository {
  final CheckoutOrdersRemoteDataSource _remoteDataSource;

  CheckoutOrdersRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<CheckoutOrder>> getMyOrders() async {
    try {
      return await _remoteDataSource.getMyOrders();
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getMyOrders failed', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } catch (e, stackTrace) {
      AppLogger.error('getMyOrders unexpected error', error: e, stackTrace: stackTrace);
      throw CheckoutOrdersFailure.unknown(e.toString());
    }
  }

  @override
  Future<CheckoutOrderDetail> getOrderById(String orderId) async {
    try {
      return await _remoteDataSource.getOrderById(orderId);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getOrderById failed for $orderId',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleDioError(e);
    } catch (e, stackTrace) {
      AppLogger.error(
        'getOrderById unexpected error for $orderId',
        error: e,
        stackTrace: stackTrace,
      );
      throw CheckoutOrdersFailure.unknown(e.toString());
    }
  }

  CheckoutOrdersFailure _handleDioError(DioException e) {
    final errorInfo = DioErrorHandler.handle(e);
    final message = errorInfo.message;

    switch (errorInfo.statusCode) {
      case 401:
        return CheckoutOrdersFailure.unauthorized();
      case 404:
        return CheckoutOrdersFailure.notFound();
      case 500:
        return CheckoutOrdersFailure.serverError();
      default:
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          return CheckoutOrdersFailure.networkError();
        }
        return CheckoutOrdersFailure.unknown(message);
    }
  }
}
