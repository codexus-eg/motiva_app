import 'package:app/core/network/dio_client.dart';
import 'package:app/features/vendor_orders/domain/entities/vendor_order.dart';
import 'package:flutter/foundation.dart';

abstract class OperatorOrdersRemoteDataSource {
  Future<List<VendorOrder>> getMyOrders();
  Future<VendorOrder> getOrderById(String orderId);
  Future<VendorOrder> startTravel(String orderId);
  Future<VendorOrder> arrive(String orderId);
  Future<VendorOrder> startService(String orderId);
  Future<VendorOrder> completeOrder(String orderId, double finalPrice);
}

class OperatorOrdersRemoteDataSourceImpl
    implements OperatorOrdersRemoteDataSource {
  final DioClient _dioClient;

  OperatorOrdersRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<VendorOrder>> getMyOrders() async {
    final response = await _dioClient.dio.get('/api/operators/my-orders');

    debugPrint(
      'OperatorOrdersRemoteDataSource: Response data: ${response.data}',
    );

    final orders = response.data as List<dynamic>;

    final parsedOrders = VendorOrder.fromJsonList(orders);

    debugPrint(
      'OperatorOrdersRemoteDataSource: Successfully parsed ${parsedOrders.length} orders',
    );
    return parsedOrders;
  }

  @override
  Future<VendorOrder> getOrderById(String orderId) async {
    final allOrders = await getMyOrders();
    final order = allOrders.firstWhere(
      (o) => o.id == orderId,
      orElse: () => throw Exception('Order with ID $orderId not found'),
    );
    return order;
  }

  @override
  Future<VendorOrder> startTravel(String orderId) async {
    final response = await _dioClient.dio.patch(
      '/api/service-orders/start-travel',
      data: {'orderId': orderId},
    );
    return VendorOrder.fromJson(response.data);
  }

  @override
  Future<VendorOrder> arrive(String orderId) async {
    final response = await _dioClient.dio.patch(
      '/api/service-orders/arrive',
      data: {'orderId': orderId},
    );
    return VendorOrder.fromJson(response.data);
  }

  @override
  Future<VendorOrder> startService(String orderId) async {
    final response = await _dioClient.dio.patch(
      '/api/service-orders/start-service',
      data: {'orderId': orderId},
    );
    return VendorOrder.fromJson(response.data);
  }

  @override
  Future<VendorOrder> completeOrder(String orderId, double finalPrice) async {
    final response = await _dioClient.dio.patch(
      '/api/service-orders/complete',
      data: {'orderId': orderId, 'finalPrice': finalPrice},
    );
    return VendorOrder.fromJson(response.data);
  }
}
