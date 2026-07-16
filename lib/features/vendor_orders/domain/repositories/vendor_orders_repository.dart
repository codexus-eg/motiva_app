import '../entities/vendor_order.dart';
import '../../data/dtos/vendor_order_actions_dto.dart';
import 'package:image_picker/image_picker.dart';

abstract class VendorOrdersRepository {
  Future<List<VendorOrder>> getVendorOrders();
  Future<VendorOrder> getOrderById(String orderId);
  Future<VendorOrder> acceptOrder(String orderId);
  Future<VendorOrder> rejectOrder(String orderId, RejectOrderDto dto);
  Future<VendorOrder> startTravel(String orderId);
  Future<VendorOrder> arrive(String orderId);
  Future<VendorOrder> startService(String orderId);
  Future<VendorOrder> completeOrder(String orderId, CompleteOrderDto dto);
  Future<VendorOrder> completeOrderWithDocuments(String orderId, CompleteOrderDto dto, List<XFile> documents);
  Future<VendorOrder> assignOperator(String orderId, AssignOperatorDto dto);
}
