import 'package:dio/dio.dart';
import '../models/customer_order_model.dart';
import '../../../../core/network/dio_client.dart';
import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';

class CreateOrderDto {
  final String vendorServiceId;
  final Map<String, dynamic> orderCustomerAttributes;
  final String? locationAddress;
  final double? locationLat;
  final double? locationLng;
  final DateTime? scheduledAt;
  final String? pickupAddress;
  final double? pickupLat;
  final double? pickupLng;
  final String? dropoffAddress;
  final double? dropoffLat;
  final double? dropoffLng;

  const CreateOrderDto({
    required this.vendorServiceId,
    required this.orderCustomerAttributes,
    this.locationAddress,
    this.locationLat,
    this.locationLng,
    this.scheduledAt,
    this.pickupAddress,
    this.pickupLat,
    this.pickupLng,
    this.dropoffAddress,
    this.dropoffLat,
    this.dropoffLng,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'vendorServiceId': vendorServiceId,
      'orderCustomerAttributes': orderCustomerAttributes,
    };

    if (locationAddress != null) json['locationAddress'] = locationAddress;
    if (locationLat != null) json['locationLat'] = locationLat;
    if (locationLng != null) json['locationLng'] = locationLng;
    if (scheduledAt != null) {
      json['scheduledAt'] = scheduledAt!.toIso8601String();
    }
    if (pickupAddress != null) json['pickupAddress'] = pickupAddress;
    if (pickupLat != null) json['pickupLat'] = pickupLat;
    if (pickupLng != null) json['pickupLng'] = pickupLng;
    if (dropoffAddress != null) json['dropoffAddress'] = dropoffAddress;
    if (dropoffLat != null) json['dropoffLat'] = dropoffLat;
    if (dropoffLng != null) json['dropoffLng'] = dropoffLng;

    return json;
  }
}

abstract class CustomerOrdersRemoteDataSource {
  Future<CustomerOrderModel> createOrder(CreateOrderDto dto);
  Future<List<CustomerOrderModel>> getCustomerOrders();
  Future<CustomerOrderModel> getOrderById(String orderId);
}

class CustomerOrdersRemoteDataSourceImpl
    implements CustomerOrdersRemoteDataSource {
  final DioClient _dioClient;

  CustomerOrdersRemoteDataSourceImpl(this._dioClient);

  Exception _handleError(DioException e, String context) {
    final errorInfo = DioErrorHandler.handle(e);
    AppLogger.error('$context failed', error: e, stackTrace: e.stackTrace);
    return Exception(errorInfo.message);
  }

  @override
  Future<CustomerOrderModel> createOrder(CreateOrderDto dto) async {
    try {
      final response = await _dioClient.dio.post(
        '/api/service-orders',
        data: dto.toJson(),
      );
      return CustomerOrderModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e, 'Create order');
    }
  }

  @override
  Future<List<CustomerOrderModel>> getCustomerOrders() async {
    try {
      final response = await _dioClient.dio.get('/api/service-orders');
      final responseData = response.data as Map<String, dynamic>;
      return CustomerOrderModel.fromJsonList(
        responseData['data'] as List<dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e, 'Get customer orders');
    }
  }

  @override
  Future<CustomerOrderModel> getOrderById(String orderId) async {
    try {
      final response = await _dioClient.dio.get('/api/service-orders/$orderId');
      return CustomerOrderModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e, 'Get order');
    }
  }
}
