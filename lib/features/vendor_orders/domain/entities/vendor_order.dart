import 'package:flutter/foundation.dart';

import 'vendor_order_status.dart';

class VendorOrder {
  final String id;
  final String orderRef;
  final String vendorServiceId;
  final String customerId;
  final String vendorId;
  final String status;
  final String baseAmount;
  final String totalAmount;
  final double? locationLat;
  final double? locationLng;
  final String? locationAddress;
  final double? pickupLat;
  final double? pickupLng;
  final String? pickupAddress;
  final double? dropoffLat;
  final double? dropoffLng;
  final String? dropoffAddress;
  final DateTime? scheduledAt;
  @Deprecated('Use orderCustomerAttributes')
  final Map<String, dynamic>? orderAttributes;
  final Map<String, dynamic>? orderVendorAttributes;
  final Map<String, dynamic>? orderCustomerAttributes;
  final String? rejectionReason;
  final String? cancellationReason;
  final String? cancellationFee;
  final DateTime? acceptedAt;
  final DateTime? completedAt;
  final DateTime? cancelledAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? serviceName;
  final String? customerName;

  const VendorOrder({
    required this.id,
    required this.orderRef,
    required this.vendorServiceId,
    required this.customerId,
    required this.vendorId,
    required this.status,
    required this.baseAmount,
    required this.totalAmount,
    this.locationLat,
    this.locationLng,
    this.locationAddress,
    this.pickupLat,
    this.pickupLng,
    this.pickupAddress,
    this.dropoffLat,
    this.dropoffLng,
    this.dropoffAddress,
    this.scheduledAt,
    this.orderAttributes,
    this.orderVendorAttributes,
    this.orderCustomerAttributes,
    this.rejectionReason,
    this.cancellationReason,
    this.cancellationFee,
    this.acceptedAt,
    this.completedAt,
    this.cancelledAt,
    required this.createdAt,
    required this.updatedAt,
    this.serviceName,
    this.customerName,
  });

  factory VendorOrder.fromJson(Map<String, dynamic> json) {
    try {
      final customer = json['customer'] as Map<String, dynamic>?;
      final service = json['service'] as Map<String, dynamic>?;

      return VendorOrder(
        id: json['id'] as String,
        orderRef: json['orderRef'] as String? ?? '',
        vendorServiceId:
            json['vendorServiceId'] as String? ??
            service?['id'] as String? ??
            '',
        customerId:
            json['customerId'] as String? ?? customer?['id'] as String? ?? '',
        vendorId: json['vendorId'] as String? ?? '',
        status: json['status'] as String,
        baseAmount:
            json['baseAmount'] as String? ??
            json['totalPrice']?.toString() ??
            '0',
        totalAmount:
            json['totalAmount'] as String? ??
            json['totalPrice']?.toString() ??
            '0',
        locationLat: (json['locationLat'] as num?)?.toDouble(),
        locationLng: (json['locationLng'] as num?)?.toDouble(),
        locationAddress: json['locationAddress'] as String?,
        pickupLat: (json['pickupLat'] as num?)?.toDouble(),
        pickupLng: (json['pickupLng'] as num?)?.toDouble(),
        pickupAddress: json['pickupAddress'] as String?,
        dropoffLat: (json['dropoffLat'] as num?)?.toDouble(),
        dropoffLng: (json['dropoffLng'] as num?)?.toDouble(),
        dropoffAddress: json['dropoffAddress'] as String?,
        scheduledAt: json['scheduledAt'] != null
            ? DateTime.parse(json['scheduledAt'] as String)
            : null,
        orderAttributes: json['orderAttributes'] as Map<String, dynamic>?,
        orderVendorAttributes:
            json['orderVendorAttributes'] as Map<String, dynamic>?,
        orderCustomerAttributes:
            json['orderCustomerAttributes'] as Map<String, dynamic>?,
        rejectionReason: json['rejectionReason'] as String?,
        cancellationReason: json['cancellationReason'] as String?,
        cancellationFee: json['cancellationFee'] as String?,
        acceptedAt: json['acceptedAt'] != null
            ? DateTime.parse(json['acceptedAt'] as String)
            : null,
        completedAt: json['completedAt'] != null
            ? DateTime.parse(json['completedAt'] as String)
            : null,
        cancelledAt: json['cancelledAt'] != null
            ? DateTime.parse(json['cancelledAt'] as String)
            : null,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'] as String)
            : DateTime.now(),
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'] as String)
            : DateTime.now(),
        serviceName:
            json['serviceName'] as String? ?? service?['name'] as String?,
        customerName:
            json['customerName'] as String? ?? customer?['name'] as String?,
      );
    } catch (e, stackTrace) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $stackTrace');
      rethrow;
    }
  }

  static List<VendorOrder> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => VendorOrder.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderRef': orderRef,
      'vendorServiceId': vendorServiceId,
      'customerId': customerId,
      'vendorId': vendorId,
      'status': status,
      'baseAmount': baseAmount,
      'totalAmount': totalAmount,
      'locationLat': locationLat,
      'locationLng': locationLng,
      'locationAddress': locationAddress,
      'pickupLat': pickupLat,
      'pickupLng': pickupLng,
      'pickupAddress': pickupAddress,
      'dropoffLat': dropoffLat,
      'dropoffLng': dropoffLng,
      'dropoffAddress': dropoffAddress,
      'scheduledAt': scheduledAt?.toIso8601String(),
      'orderAttributes': orderAttributes,
      'orderVendorAttributes': orderVendorAttributes,
      'orderCustomerAttributes': orderCustomerAttributes,
      'rejectionReason': rejectionReason,
      'cancellationReason': cancellationReason,
      'cancellationFee': cancellationFee,
      'acceptedAt': acceptedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'cancelledAt': cancelledAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'serviceName': serviceName,
      'customerName': customerName,
    };
  }

  VendorOrderStatus get statusEnum => VendorOrderStatus.fromString(status);

  bool get isIncoming => status == 'pending_acceptance';
  bool get isPending =>
      status == 'accepted' ||
      status == 'en_route' ||
      status == 'in_progress' ||
      status == 'arrived';
  bool get isCompleted => status == 'completed';
  bool get isCancelled => status == 'cancelled';
  bool get isRejected => status == 'rejected';

  bool get canAccept => statusEnum.canAccept;
  bool get canReject => statusEnum.canReject;
  bool get canStartTravel => statusEnum.canStartTravel;
  bool get canArrive => statusEnum.canArrive;
  bool get canStartService => statusEnum.canStartService;
  bool get canComplete => statusEnum.canComplete;
  bool get canAssignOperator => statusEnum.canAssignOperator;

  String get displayPrice => '$baseAmount KWD';

  String get statusDisplayName => statusEnum.displayName;

  VendorOrder copyWith({
    String? id,
    String? orderRef,
    String? vendorServiceId,
    String? customerId,
    String? vendorId,
    String? status,
    String? baseAmount,
    String? totalAmount,
    double? locationLat,
    double? locationLng,
    String? locationAddress,
    double? pickupLat,
    double? pickupLng,
    String? pickupAddress,
    double? dropoffLat,
    double? dropoffLng,
    String? dropoffAddress,
    DateTime? scheduledAt,
    Map<String, dynamic>? orderAttributes,
    Map<String, dynamic>? orderVendorAttributes,
    Map<String, dynamic>? orderCustomerAttributes,
    String? rejectionReason,
    String? cancellationReason,
    String? cancellationFee,
    DateTime? acceptedAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? serviceName,
    String? customerName,
  }) {
    return VendorOrder(
      id: id ?? this.id,
      orderRef: orderRef ?? this.orderRef,
      vendorServiceId: vendorServiceId ?? this.vendorServiceId,
      customerId: customerId ?? this.customerId,
      vendorId: vendorId ?? this.vendorId,
      status: status ?? this.status,
      baseAmount: baseAmount ?? this.baseAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      locationLat: locationLat ?? this.locationLat,
      locationLng: locationLng ?? this.locationLng,
      locationAddress: locationAddress ?? this.locationAddress,
      pickupLat: pickupLat ?? this.pickupLat,
      pickupLng: pickupLng ?? this.pickupLng,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      dropoffLat: dropoffLat ?? this.dropoffLat,
      dropoffLng: dropoffLng ?? this.dropoffLng,
      dropoffAddress: dropoffAddress ?? this.dropoffAddress,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      orderAttributes: orderAttributes ?? this.orderAttributes,
      orderVendorAttributes:
          orderVendorAttributes ?? this.orderVendorAttributes,
      orderCustomerAttributes:
          orderCustomerAttributes ?? this.orderCustomerAttributes,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      cancellationFee: cancellationFee ?? this.cancellationFee,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      completedAt: completedAt ?? this.completedAt,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      serviceName: serviceName ?? this.serviceName,
      customerName: customerName ?? this.customerName,
    );
  }
}
