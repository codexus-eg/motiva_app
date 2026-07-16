import '../datasources/vendor_orders_remote_data_source.dart';
import '../dtos/vendor_order_actions_dto.dart';
import '../../domain/entities/vendor_order.dart';
import '../../domain/repositories/vendor_orders_repository.dart';
import 'package:image_picker/image_picker.dart';

class VendorOrdersRepositoryImpl implements VendorOrdersRepository {
  final VendorOrdersRemoteDataSource _remoteDataSource;

  VendorOrdersRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<VendorOrder>> getVendorOrders() {
    return _remoteDataSource.getVendorOrders();
  }

  @override
  Future<VendorOrder> getOrderById(String orderId) {
    return _remoteDataSource.getOrderById(orderId);
  }

  @override
  Future<VendorOrder> acceptOrder(String orderId) {
    return _remoteDataSource.acceptOrder(orderId);
  }

  @override
  Future<VendorOrder> rejectOrder(String orderId, RejectOrderDto dto) {
    return _remoteDataSource.rejectOrder(orderId, dto);
  }

  @override
  Future<VendorOrder> startTravel(String orderId) {
    return _remoteDataSource.startTravel(orderId);
  }

  @override
  Future<VendorOrder> arrive(String orderId) {
    return _remoteDataSource.arrive(orderId);
  }

  @override
  Future<VendorOrder> startService(String orderId) {
    return _remoteDataSource.startService(orderId);
  }

  @override
  Future<VendorOrder> completeOrder(String orderId, CompleteOrderDto dto) {
    return _remoteDataSource.completeOrder(orderId, dto);
  }

  @override
  Future<VendorOrder> completeOrderWithDocuments(String orderId, CompleteOrderDto dto, List<XFile> documents) {
    return _remoteDataSource.completeOrderWithDocuments(orderId, dto, documents);
  }

  @override
  Future<VendorOrder> assignOperator(String orderId, AssignOperatorDto dto) {
    return _remoteDataSource.assignOperator(orderId, dto);
  }
}
