import 'package:app/features/operator_orders/data/datasources/operator_orders_remote_data_source.dart';
import 'package:app/features/operator_orders/domain/repositories/operator_orders_repository.dart';
import 'package:app/features/vendor_orders/domain/entities/vendor_order.dart';

class OperatorOrdersRepositoryImpl implements OperatorOrdersRepository {
  final OperatorOrdersRemoteDataSource _remoteDataSource;

  OperatorOrdersRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<VendorOrder>> getMyOrders() {
    return _remoteDataSource.getMyOrders();
  }

  @override
  Future<VendorOrder> getOrderById(String orderId) {
    return _remoteDataSource.getOrderById(orderId);
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
  Future<VendorOrder> completeOrder(String orderId, double finalPrice) {
    return _remoteDataSource.completeOrder(orderId, finalPrice);
  }
}
