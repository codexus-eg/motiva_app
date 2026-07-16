import 'checkout_order.dart';

class DeliveryAddress {
  final String? street;
  final String? area;
  final String? block;
  final String? building;
  final String? floor;
  final String? apartment;
  final String? notes;

  const DeliveryAddress({
    this.street,
    this.area,
    this.block,
    this.building,
    this.floor,
    this.apartment,
    this.notes,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
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
    if (street != null) parts.add(street!);
    if (area != null) parts.add(area!);
    if (block != null) parts.add(block!);
    if (building != null) parts.add(building!);
    if (floor != null) parts.add(floor!);
    if (apartment != null) parts.add(apartment!);
    if (notes != null) parts.add('Notes: ${notes!}');
    return parts.join(', ');
  }
}

class CheckoutOrderDetail {
  final String id;
  final String orderNumber;
  final String status;
  final String totalAmount;
  final String? currency;
  final List<CheckoutOrderItem> items;
  final DeliveryAddress deliveryAddress;
  final String? paymentMethod;
  final String? vendorName;
  final String? vendorId;
  final String? estimatedDelivery;
  final String? cancelReason;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const CheckoutOrderDetail({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.totalAmount,
    this.currency,
    required this.items,
    required this.deliveryAddress,
    this.paymentMethod,
    this.vendorName,
    this.vendorId,
    this.estimatedDelivery,
    this.cancelReason,
    required this.createdAt,
    this.updatedAt,
  });

  factory CheckoutOrderDetail.fromJson(Map<String, dynamic> json) {
    final itemsList = json['items'] as List<dynamic>? ?? [];
    final vendorJson = json['vendor'] as Map<String, dynamic>?;
    return CheckoutOrderDetail(
      id: json['id'] as String,
      orderNumber: json['orderNumber'] as String,
      status: json['status'] as String,
      totalAmount: json['totalAmount'].toString(),
      currency: json['currency'] as String?,
      items: itemsList
          .map(
            (e) => CheckoutOrderItem(
              productName: (e as Map<String, dynamic>)['productName'] as String,
              quantity: e['quantity'] as int,
              unitPrice: e['unitPrice'].toString(),
            ),
          )
          .toList(),
      deliveryAddress: DeliveryAddress.fromJson(
        json['deliveryAddress'] as Map<String, dynamic>? ?? {},
      ),
      paymentMethod: json['paymentMethod'] as String?,
      vendorName: vendorJson?['businessName'] as String?,
      vendorId: vendorJson?['id'] as String?,
      estimatedDelivery: json['estimatedDelivery'] as String?,
      cancelReason: json['cancelReason'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }
}
