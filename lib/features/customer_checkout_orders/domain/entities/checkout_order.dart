class CheckoutOrderItem {
  final String productName;
  final int quantity;
  final String unitPrice;

  const CheckoutOrderItem({
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  });
}

class CheckoutOrder {
  final String id;
  final String orderNumber;
  final String status;
  final String totalAmount;
  final List<CheckoutOrderItem> itemsSummary;
  final DateTime createdAt;
  final bool reviewSubmitted;

  const CheckoutOrder({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.totalAmount,
    required this.itemsSummary,
    required this.createdAt,
    this.reviewSubmitted = false,
  });

  factory CheckoutOrder.fromJson(Map<String, dynamic> json) {
    final itemsList = json['itemsSummary'] as List<dynamic>? ?? [];
    return CheckoutOrder(
      id: json['id'] as String,
      orderNumber: json['orderNumber'] as String,
      status: json['status'] as String,
      totalAmount: json['totalAmount'].toString(),
      itemsSummary: itemsList
          .map(
            (e) => CheckoutOrderItem(
              productName: (e as Map<String, dynamic>)['productName'] as String,
              quantity: e['quantity'] as int,
              unitPrice: e['unitPrice'].toString(),
            ),
          )
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      reviewSubmitted: json['reviewSubmitted'] as bool? ?? false,
    );
  }

  static List<CheckoutOrder> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CheckoutOrder.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
