import '../entities/checkout_order.dart';
import '../entities/checkout_order_detail.dart';

abstract class CheckoutOrdersRepository {
  Future<List<CheckoutOrder>> getMyOrders();
  Future<CheckoutOrderDetail> getOrderById(String orderId);
}
