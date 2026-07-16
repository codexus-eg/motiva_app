import '../../data/datasources/customer_orders_remote_data_source.dart';
import '../../data/models/customer_order_model.dart';

abstract class CustomerOrdersRepository {
  Future<CustomerOrderModel> createOrder(CreateOrderDto dto);
  Future<List<CustomerOrderModel>> getCustomerOrders();
  Future<CustomerOrderModel> getOrderById(String orderId);
}
