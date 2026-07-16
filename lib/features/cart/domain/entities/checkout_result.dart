import 'cart_item.dart';
import 'delivery_address.dart';

class CheckoutResult {
  final String orderId;
  final String status;
  final String total;
  final String currency;
  final int itemCount;
  final String estimatedDelivery;
  final String paymentMethod;
  final DeliveryAddress? deliveryAddress;
  final List<CartItem> items;

  const CheckoutResult({
    required this.orderId,
    required this.status,
    required this.total,
    required this.currency,
    required this.itemCount,
    required this.estimatedDelivery,
    required this.paymentMethod,
    this.deliveryAddress,
    required this.items,
  });
}
