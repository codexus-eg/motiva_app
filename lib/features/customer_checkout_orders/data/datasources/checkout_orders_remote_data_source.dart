import 'package:app/core/network/dio_client.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/checkout_order.dart';
import '../../domain/entities/checkout_order_detail.dart';

abstract class CheckoutOrdersRemoteDataSource {
  Future<List<CheckoutOrder>> getMyOrders();
  Future<CheckoutOrderDetail> getOrderById(String orderId);
}

class CheckoutOrdersRemoteDataSourceImpl
    implements CheckoutOrdersRemoteDataSource {
  final DioClient _dioClient;

  CheckoutOrdersRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<CheckoutOrder>> getMyOrders() async {
    try {
      final response = await _dioClient.dio.get('/api/checkout/my-orders');

      final responseData = response.data as Map<String, dynamic>;
      final ordersData = responseData['data'] as List<dynamic>? ?? [];

      AppLogger.debug('CheckoutOrders: Fetched ${ordersData.length} orders');

      return CheckoutOrder.fromJsonList(ordersData);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getMyOrders failed',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('getMyOrders unexpected error', error: e, stackTrace: stackTrace);
      throw Exception('Failed to fetch orders: $e');
    }
  }

  @override
  Future<CheckoutOrderDetail> getOrderById(String orderId) async {
    try {
      final response = await _dioClient.dio.get('/api/checkout/$orderId');

      AppLogger.debug('CheckoutOrderDetail: Fetched order $orderId');

      return CheckoutOrderDetail.fromJson(response.data as Map<String, dynamic>);
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
}
