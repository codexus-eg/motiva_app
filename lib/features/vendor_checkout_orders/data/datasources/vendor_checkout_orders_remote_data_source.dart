import 'package:app/core/network/dio_client.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/vendor_checkout_order.dart';
import '../../domain/entities/vendor_checkout_order_detail.dart';
import '../dtos/vendor_checkout_order_actions_dto.dart';

abstract class VendorCheckoutOrdersRemoteDataSource {
  Future<List<VendorCheckoutOrder>> getVendorOrders();
  Future<VendorCheckoutOrder> getOrderById(String orderId);
  Future<VendorCheckoutOrderDetail> getOrderDetail(String orderId);
  Future<VendorCheckoutOrder> updateOrderStatus(
    String orderId,
    UpdateCheckoutOrderStatusDto dto,
  );
}

class VendorCheckoutOrdersRemoteDataSourceImpl
    implements VendorCheckoutOrdersRemoteDataSource {
  final DioClient _dioClient;

  VendorCheckoutOrdersRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<VendorCheckoutOrder>> getVendorOrders() async {
    try {
      final response = await _dioClient.dio.get('/api/checkout/vendor-orders');

      final responseData = response.data as Map<String, dynamic>;
      final ordersData = responseData['data'] as List<dynamic>? ?? [];

      AppLogger.debug(
        'VendorCheckoutOrders: Fetched ${ordersData.length} orders',
      );

      return VendorCheckoutOrder.fromJsonList(ordersData);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getVendorOrders failed',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error(
        'getVendorOrders unexpected error',
        error: e,
        stackTrace: stackTrace,
      );
      throw Exception('Failed to fetch orders: $e');
    }
  }

  @override
  Future<VendorCheckoutOrder> getOrderById(String orderId) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/checkout/vendor/$orderId',
      );

      AppLogger.debug('VendorCheckoutOrderDetail: Fetched order $orderId');

      return VendorCheckoutOrder.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getOrderById failed for $orderId',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error(
        'getOrderById unexpected error for $orderId',
        error: e,
        stackTrace: stackTrace,
      );
      throw Exception('Failed to fetch order detail: $e');
    }
  }

  @override
  Future<VendorCheckoutOrderDetail> getOrderDetail(String orderId) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/checkout/vendor/$orderId',
      );

      AppLogger.debug('VendorCheckoutOrderDetail: Fetched detail for order $orderId');

      return VendorCheckoutOrderDetail.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getOrderDetail failed for $orderId',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error(
        'getOrderDetail unexpected error for $orderId',
        error: e,
        stackTrace: stackTrace,
      );
      throw Exception('Failed to fetch order detail: $e');
    }
  }

  @override
  Future<VendorCheckoutOrder> updateOrderStatus(
    String orderId,
    UpdateCheckoutOrderStatusDto dto,
  ) async {
    try {
      await _dioClient.dio.patch(
        '/api/checkout/vendor/$orderId/status',
        data: dto.toJson(),
      );

      AppLogger.debug('VendorCheckoutOrder: Updated status for order $orderId');

      return getOrderById(orderId);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'updateOrderStatus failed for $orderId',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error(
        'updateOrderStatus unexpected error for $orderId',
        error: e,
        stackTrace: stackTrace,
      );
      throw Exception('Failed to update order status: $e');
    }
  }

}
