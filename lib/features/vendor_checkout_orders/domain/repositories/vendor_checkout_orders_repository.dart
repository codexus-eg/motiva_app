import '../entities/vendor_checkout_order.dart';
import '../entities/vendor_checkout_order_detail.dart';

abstract class VendorCheckoutOrdersRepository {
  Future<List<VendorCheckoutOrder>> getVendorOrders();
  Future<VendorCheckoutOrder> getOrderById(String orderId);
  Future<VendorCheckoutOrderDetail> getOrderDetail(String orderId);
  Future<VendorCheckoutOrder> updateOrderStatus(String orderId, String status);
}
