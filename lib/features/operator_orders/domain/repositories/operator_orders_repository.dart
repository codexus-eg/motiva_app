import 'package:app/features/vendor_orders/domain/entities/vendor_order.dart';

abstract class OperatorOrdersRepository {
  Future<List<VendorOrder>> getMyOrders();
  Future<VendorOrder> getOrderById(String orderId);
  Future<VendorOrder> startTravel(String orderId);
  Future<VendorOrder> arrive(String orderId);
  Future<VendorOrder> startService(String orderId);
  Future<VendorOrder> completeOrder(String orderId, double finalPrice);
}
