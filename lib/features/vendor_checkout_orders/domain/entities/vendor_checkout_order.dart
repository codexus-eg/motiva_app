class VendorCheckoutOrderItem {
  final String productName;
  final int quantity;
  final String unitPrice;

  const VendorCheckoutOrderItem({
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  });
}

class VendorCheckoutOrder {
  final String id;
  final String orderNumber;
  final String status;
  final String totalAmount;
  final int itemsCount;
  final DateTime createdAt;

  const VendorCheckoutOrder({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.totalAmount,
    required this.itemsCount,
    required this.createdAt,
  });

  factory VendorCheckoutOrder.fromJson(Map<String, dynamic> json) {
    return VendorCheckoutOrder(
      id: json['id'] as String,
      orderNumber: json['orderNumber'] as String,
      status: json['status'] as String,
      totalAmount: json['totalAmount'].toString(),
      itemsCount:
          (json['itemsCount'] as int?) ?? (json['items'] as List?)?.length ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  static List<VendorCheckoutOrder> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map(
          (json) => VendorCheckoutOrder.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  bool get isPending => status == 'pending';
  bool get isProcessing => status == 'processing';
  bool get isConfirmed => status == 'confirmed';
  bool get isShipped => status == 'shipped';
  bool get isDelivered => status == 'delivered';
  bool get isCancelled => status == 'cancelled';

  bool get canShip =>
      status == 'pending' || status == 'processing' || status == 'confirmed';
  bool get canDeliver => status == 'shipped';


  String get displayStatus {
    switch (status) {
      case 'pending':
        return 'Pending';
      case 'processing':
        return 'Processing';
      case 'confirmed':
        return 'Confirmed';
      case 'shipped':
        return 'Shipped';
      case 'delivered':
        return 'Delivered';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }

  String get displayPrice => 'KD $totalAmount';
}
