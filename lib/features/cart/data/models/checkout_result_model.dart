import '../../domain/entities/cart_item.dart';
import '../../domain/entities/checkout_result.dart';
import '../../domain/entities/delivery_address.dart';
import 'delivery_address_model.dart';

class CheckoutResultModel extends CheckoutResult {
  const CheckoutResultModel({
    required super.orderId,
    required super.status,
    required super.total,
    required super.currency,
    required super.itemCount,
    required super.estimatedDelivery,
    required super.paymentMethod,
    super.deliveryAddress,
    required super.items,
  });

  factory CheckoutResultModel.fromJson(Map<String, dynamic> json) {
    final root = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    final addressJson = root['deliveryAddress'] as Map<String, dynamic>?;
    DeliveryAddress? address;
    if (addressJson != null) {
      address = DeliveryAddressModel.fromJson(addressJson);
    }

    final itemsJson = root['items'] as List<dynamic>? ?? [];
    final items = itemsJson
        .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
        .toList();

    return CheckoutResultModel(
      orderId: root['orderId'] as String? ?? '',
      status: root['status'] as String? ?? '',
      total: root['total']?.toString() ?? '0',
      currency: root['currency'] as String? ?? 'KWD',
      itemCount: (root['itemCount'] as num?)?.toInt() ?? 0,
      estimatedDelivery: root['estimatedDelivery'] as String? ?? '',
      paymentMethod: root['paymentMethod'] as String? ?? '',
      deliveryAddress: address,
      items: items,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'status': status,
      'total': total,
      'currency': currency,
      'itemCount': itemCount,
      'estimatedDelivery': estimatedDelivery,
      'paymentMethod': paymentMethod,
      'deliveryAddress': deliveryAddress is DeliveryAddressModel
          ? (deliveryAddress as DeliveryAddressModel).toJson()
          : null,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}
