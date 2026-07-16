import 'vendor_checkout_order.dart';

class VendorDeliveryAddress {
  final String? street;
  final String? area;
  final String? block;
  final String? building;
  final String? floor;
  final String? apartment;
  final String? notes;

  const VendorDeliveryAddress({
    this.street,
    this.area,
    this.block,
    this.building,
    this.floor,
    this.apartment,
    this.notes,
  });

  factory VendorDeliveryAddress.fromJson(Map<String, dynamic> json) {
    return VendorDeliveryAddress(
      street: json['street'] as String?,
      area: json['area'] as String?,
      block: json['block'] as String?,
      building: json['building'] as String?,
      floor: json['floor'] as String?,
      apartment: json['apartment'] as String?,
      notes: json['notes'] as String?,
    );
  }

  String get formattedAddress {
    final parts = <String>[];
    if (street != null && street!.isNotEmpty) parts.add(street!);
    if (area != null && area!.isNotEmpty) parts.add(area!);
    if (block != null && block!.isNotEmpty) parts.add('Block $block');
    if (building != null && building!.isNotEmpty) parts.add('Bldg $building');
    if (floor != null && floor!.isNotEmpty) parts.add('Floor $floor');
    if (apartment != null && apartment!.isNotEmpty) parts.add('Apt $apartment');
    return parts.isEmpty ? 'No address provided' : parts.join(', ');
  }
}

class VendorCheckoutOrderCustomer {
  final String id;
  final String fullName;
  final String? phone;

  const VendorCheckoutOrderCustomer({
    required this.id,
    required this.fullName,
    this.phone,
  });

  factory VendorCheckoutOrderCustomer.fromJson(Map<String, dynamic> json) {
    return VendorCheckoutOrderCustomer(
      id: json['id'] as String,
      fullName: json['fullName'] as String? ?? 'Customer',
      phone: json['phone'] as String?,
    );
  }
}

class VendorCheckoutOrderDetail {
  final String id;
  final String orderNumber;
  final String status;
  final String totalAmount;
  final String? currency;
  final List<VendorCheckoutOrderItem> items;
  final VendorDeliveryAddress? deliveryAddress;
  final String? paymentMethod;
  final String? estimatedDelivery;
  final String? cancelReason;
  final VendorCheckoutOrderCustomer? customer;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const VendorCheckoutOrderDetail({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.totalAmount,
    this.currency,
    required this.items,
    this.deliveryAddress,
    this.paymentMethod,
    this.estimatedDelivery,
    this.cancelReason,
    this.customer,
    required this.createdAt,
    this.updatedAt,
  });

  factory VendorCheckoutOrderDetail.fromJson(Map<String, dynamic> json) {
    final itemsList = json['items'] as List<dynamic>? ?? [];

    return VendorCheckoutOrderDetail(
      id: json['id'] as String,
      orderNumber: json['orderNumber'] as String,
      status: json['status'] as String,
      totalAmount: json['totalAmount'].toString(),
      currency: json['currency'] as String?,
      items: itemsList
          .map(
            (e) => VendorCheckoutOrderItem(
              productName: (e as Map<String, dynamic>)['productName'] as String,
              quantity: e['quantity'] as int,
              unitPrice: e['unitPrice'].toString(),
            ),
          )
          .toList(),
      deliveryAddress: json['deliveryAddress'] != null
          ? VendorDeliveryAddress.fromJson(
              json['deliveryAddress'] as Map<String, dynamic>,
            )
          : null,
      paymentMethod: json['paymentMethod'] as String?,
      estimatedDelivery: json['estimatedDelivery'] as String?,
      cancelReason: json['cancelReason'] as String?,
      customer: json['customer'] != null
          ? VendorCheckoutOrderCustomer.fromJson(
              json['customer'] as Map<String, dynamic>,
            )
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
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

  String get displayPrice =>
      '${currency ?? 'KD'} $totalAmount';

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
}