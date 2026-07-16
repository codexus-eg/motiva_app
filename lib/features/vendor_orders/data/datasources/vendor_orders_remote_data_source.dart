import 'package:app/core/network/dio_client.dart';
import 'package:app/features/vendor_orders/domain/entities/vendor_order.dart';
import '../dtos/vendor_order_actions_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

abstract class VendorOrdersRemoteDataSource {
  Future<List<VendorOrder>> getVendorOrders();
  Future<VendorOrder> getOrderById(String orderId);
  Future<VendorOrder> acceptOrder(String orderId);
  Future<VendorOrder> rejectOrder(String orderId, RejectOrderDto dto);
  Future<VendorOrder> startTravel(String orderId);
  Future<VendorOrder> arrive(String orderId);
  Future<VendorOrder> startService(String orderId);
  Future<VendorOrder> completeOrder(String orderId, CompleteOrderDto dto);
  Future<VendorOrder> completeOrderWithDocuments(
    String orderId,
    CompleteOrderDto dto,
    List<XFile> documents,
  );
  Future<VendorOrder> assignOperator(String orderId, AssignOperatorDto dto);
}

class VendorOrdersRemoteDataSourceImpl implements VendorOrdersRemoteDataSource {
  final DioClient _dioClient;

  VendorOrdersRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<VendorOrder>> getVendorOrders() async {
    final response = await _dioClient.dio.get('/api/service-orders');

    debugPrint('VendorOrdersRemoteDataSource: Response data: ${response.data}');

    final responseData = response.data as Map<String, dynamic>;
    final ordersData = responseData['data'] as List<dynamic>? ?? [];

    final parsedOrders = VendorOrder.fromJsonList(ordersData);

    return parsedOrders;
  }

  @override
  Future<VendorOrder> getOrderById(String orderId) async {
    final response = await _dioClient.dio.get('/api/service-orders/$orderId');
    return VendorOrder.fromJson(response.data);
  }

  @override
  Future<VendorOrder> acceptOrder(String orderId) async {
    final response = await _dioClient.dio.patch(
      '/api/service-orders/accept',
      data: {'orderId': orderId},
    );
    return VendorOrder.fromJson(response.data);
  }

  @override
  Future<VendorOrder> rejectOrder(String orderId, RejectOrderDto dto) async {
    final response = await _dioClient.dio.patch(
      '/api/service-orders/reject',
      data: {'orderId': orderId, if (dto.reason != null) 'reason': dto.reason},
    );
    return VendorOrder.fromJson(response.data);
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
  Future<VendorOrder> completeOrder(
    String orderId,
    CompleteOrderDto dto,
  ) async {
    final response = await _dioClient.dio.patch(
      '/api/service-orders/complete',
      data: {'orderId': orderId, 'finalPrice': dto.finalPrice},
    );
    return VendorOrder.fromJson(response.data);
  }

  @override
  Future<VendorOrder> completeOrderWithDocuments(
    String orderId,
    CompleteOrderDto dto,
    List<XFile> documents,
  ) async {
    final formData = dto.toFormData(orderId, documents);
    final response = await _dioClient.dio.patch(
      '/api/service-orders/complete',
      data: formData,
    );
    return VendorOrder.fromJson(response.data);
  }

  @override
  Future<VendorOrder> assignOperator(
    String orderId,
    AssignOperatorDto dto,
  ) async {
    final response = await _dioClient.dio.patch(
      '/api/service-orders/assign-operator',
      data: dto.toJson(),
    );
    return VendorOrder.fromJson(response.data);
  }
}
