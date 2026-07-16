// ignore_for_file: avoid_print

import '../../domain/entities/customer_order.dart';

class CustomerOrderModel extends CustomerOrder {
  const CustomerOrderModel({
    required super.id,
    required super.orderRef,
    required super.vendorServiceId,
    required super.customerId,
    required super.vendorId,
    required super.status,
    required super.baseAmount,
    required super.totalAmount,
    super.locationLat,
    super.locationLng,
    super.locationAddress,
    super.scheduledAt,
    super.orderAttributes,
    super.orderVendorAttributes,
    super.orderCustomerAttributes,
    super.rejectionReason,
    super.cancellationReason,
    super.cancellationFee,
    super.acceptedAt,
    super.completedAt,
    super.cancelledAt,
    required super.createdAt,
    required super.updatedAt,
    super.serviceName,
    super.vendorName,
    super.vendorLogoUrl,
    super.serviceImageUrl,
    super.vendorPhone,
    super.reviewSubmitted = false,
  });

  factory CustomerOrderModel.fromJson(Map<String, dynamic> json) {
    try {
      return CustomerOrderModel(
        id: json['id'] as String,
        orderRef: json['orderRef'] as String,
        vendorServiceId: json['vendorServiceId'] as String,
        customerId: json['customerId'] as String,
        vendorId: json['vendorId'] as String,
        status: _parseStatus(json['status'] as String),
        baseAmount: json['baseAmount'] as String? ?? '0',
        totalAmount: json['totalAmount'] as String? ?? '0',
        locationLat: (json['locationLat'] as num?)?.toDouble(),
        locationLng: (json['locationLng'] as num?)?.toDouble(),
        locationAddress: json['locationAddress'] as String?,
        scheduledAt: json['scheduledAt'] != null
            ? DateTime.parse(json['scheduledAt'] as String)
            : null,
        orderAttributes: json['orderAttributes'] != null
            ? Map<String, dynamic>.from(json['orderAttributes'] as Map)
            : null,
        orderVendorAttributes: json['orderVendorAttributes'] != null
            ? Map<String, dynamic>.from(json['orderVendorAttributes'] as Map)
            : null,
        orderCustomerAttributes: json['orderCustomerAttributes'] != null
            ? Map<String, dynamic>.from(json['orderCustomerAttributes'] as Map)
            : null,
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
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'] as String)
            : DateTime.now(),
        serviceName: json['serviceName'] as String?,
        vendorName: json['vendorName'] as String?,
        vendorLogoUrl: json['vendorLogoUrl'] as String?,
        serviceImageUrl: json['serviceImageUrl'] as String?,
        vendorPhone: json['vendorPhone'] as String?,
        reviewSubmitted: json['reviewSubmitted'] as bool? ?? false,
      );
    } catch (e, stackTrace) {
      print('❌ CustomerOrderModel.fromJson failed for: $json');
      print('📊 Error: $e');
      print('📊 StackTrace: $stackTrace');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderRef': orderRef,
      'vendorServiceId': vendorServiceId,
      'customerId': customerId,
      'vendorId': vendorId,
      'status': status.name,
      'baseAmount': baseAmount,
      'totalAmount': totalAmount,
      'locationLat': locationLat,
      'locationLng': locationLng,
      'locationAddress': locationAddress,
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
      'vendorName': vendorName,
      'vendorLogoUrl': vendorLogoUrl,
      'serviceImageUrl': serviceImageUrl,
      'vendorPhone': vendorPhone,
      'reviewSubmitted': reviewSubmitted,
    };
  }

  static CustomerOrderStatus _parseStatus(String status) {
    switch (status) {
      case 'pending_acceptance':
        return CustomerOrderStatus.pendingAcceptance;
      case 'accepted':
        return CustomerOrderStatus.accepted;
      case 'en_route':
        return CustomerOrderStatus.enRoute;
      case 'arrived':
        return CustomerOrderStatus.arrived;
      case 'in_progress':
        return CustomerOrderStatus.inProgress;
      case 'completed':
        return CustomerOrderStatus.completed;
      case 'rejected':
        return CustomerOrderStatus.rejected;
      case 'cancelled':
        return CustomerOrderStatus.cancelled;
      default:
        return CustomerOrderStatus.pendingAcceptance;
    }
  }

  static List<CustomerOrderModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map(
          (json) => CustomerOrderModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }
}
