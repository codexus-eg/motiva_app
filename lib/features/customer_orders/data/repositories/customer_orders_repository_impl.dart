import '../../data/datasources/customer_orders_remote_data_source.dart';
import '../../data/models/customer_order_model.dart';
import '../../domain/repositories/customer_orders_repository.dart';

class CustomerOrdersRepositoryImpl implements CustomerOrdersRepository {
  final CustomerOrdersRemoteDataSource _remoteDataSource;

  CustomerOrdersRepositoryImpl(this._remoteDataSource);

  @override
  Future<CustomerOrderModel> createOrder(CreateOrderDto dto) {
    return _remoteDataSource.createOrder(dto);
  }

  @override
  Future<List<CustomerOrderModel>> getCustomerOrders() {
    return _remoteDataSource.getCustomerOrders();
  }

  @override
  Future<CustomerOrderModel> getOrderById(String orderId) {
    return _remoteDataSource.getOrderById(orderId);
  }

}
