enum OrderType { product, ride }

class OrderItem {
  final String name;
  final double price;
  const OrderItem({required this.name, required this.price});
}

class Order {
  final String id;
  final String date;
  final String providerName;
  final String? orderId;
  final String? subtitle;
  final double amount;
  final OrderType type;
  final List<OrderItem> items;
  final String? deliveryAddress;
  final String? paymentMethod;
  final double? deliveryFee;
  final String? status;

  const Order({
    required this.id,
    required this.date,
    required this.providerName,
    this.orderId,
    this.subtitle,
    required this.amount,
    required this.type,
    required this.items,
    this.deliveryAddress,
    this.paymentMethod,
    this.deliveryFee,
    this.status,
  });

  Order copyWith({
    String? id,
    String? date,
    String? providerName,
    String? orderId,
    String? subtitle,
    double? amount,
    OrderType? type,
    List<OrderItem>? items,
    String? deliveryAddress,
    String? paymentMethod,
    double? deliveryFee,
    String? status,
  }) {
    return Order(
      id: id ?? this.id,
      date: date ?? this.date,
      providerName: providerName ?? this.providerName,
      orderId: orderId ?? this.orderId,
      subtitle: subtitle ?? this.subtitle,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      items: items ?? this.items,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      status: status ?? this.status,
    );
  }
}
