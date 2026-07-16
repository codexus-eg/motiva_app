import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/vendor_checkout_order.dart';
import '../../domain/entities/vendor_checkout_order_detail.dart';
import '../../domain/failures/vendor_checkout_orders_failure.dart';
import '../../domain/repositories/vendor_checkout_orders_repository.dart';
import '../datasources/vendor_checkout_orders_remote_data_source.dart';
import '../dtos/vendor_checkout_order_actions_dto.dart';

class VendorCheckoutOrdersRepositoryImpl implements VendorCheckoutOrdersRepository {
  final VendorCheckoutOrdersRemoteDataSource _remoteDataSource;

  VendorCheckoutOrdersRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<VendorCheckoutOrder>> getVendorOrders() async {
    try {
      return await _remoteDataSource.getVendorOrders();
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getVendorOrders failed', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } catch (e, stackTrace) {
      AppLogger.error('getVendorOrders unexpected error', error: e, stackTrace: stackTrace);
      throw VendorCheckoutOrdersFailure.unknown(e.toString());
    }
  }

  @override
  Future<VendorCheckoutOrder> getOrderById(String orderId) async {
    try {
      return await _remoteDataSource.getOrderById(orderId);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getOrderById failed for $orderId', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } catch (e, stackTrace) {
      AppLogger.error('getOrderById unexpected error for $orderId', error: e, stackTrace: stackTrace);
      throw VendorCheckoutOrdersFailure.unknown(e.toString());
    }
  }

  @override
  Future<VendorCheckoutOrderDetail> getOrderDetail(String orderId) async {
    try {
      return await _remoteDataSource.getOrderDetail(orderId);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getOrderDetail failed for $orderId', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } catch (e, stackTrace) {
      AppLogger.error('getOrderDetail unexpected error for $orderId', error: e, stackTrace: stackTrace);
      throw VendorCheckoutOrdersFailure.unknown(e.toString());
    }
  }

  @override
  Future<VendorCheckoutOrder> updateOrderStatus(String orderId, String status) async {
    try {
      final dto = UpdateCheckoutOrderStatusDto(status: status);
      return await _remoteDataSource.updateOrderStatus(orderId, dto);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('updateOrderStatus failed for $orderId', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } catch (e, stackTrace) {
      AppLogger.error('updateOrderStatus unexpected error for $orderId', error: e, stackTrace: stackTrace);
      throw VendorCheckoutOrdersFailure.unknown(e.toString());
    }
  }

  VendorCheckoutOrdersFailure _handleDioError(DioException e) {
    final errorInfo = DioErrorHandler.handle(e);
    final message = errorInfo.message;

    switch (errorInfo.statusCode) {
      case 401:
        return VendorCheckoutOrdersFailure.unauthorized();
      case 404:
        return VendorCheckoutOrdersFailure.notFound();
      case 500:
        return VendorCheckoutOrdersFailure.serverError();
      default:
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          return VendorCheckoutOrdersFailure.networkError();
        }
        return VendorCheckoutOrdersFailure.unknown(message);
    }
  }
}
