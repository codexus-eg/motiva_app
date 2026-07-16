enum CustomerOrderStatus {
  pendingAcceptance,
  accepted,
  enRoute,
  arrived,
  inProgress,
  completed,
  rejected,
  cancelled,
}

class CustomerOrder {
  final String id;
  final String orderRef;
  final String vendorServiceId;
  final String customerId;
  final String vendorId;
  final CustomerOrderStatus status;
  final String baseAmount;
  final String totalAmount;
  final double? locationLat;
  final double? locationLng;
  final String? locationAddress;
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
  final String? vendorName;
  final String? vendorLogoUrl;
  final String? serviceImageUrl;
  final String? vendorPhone;
  final bool reviewSubmitted;

  const CustomerOrder({
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
    this.vendorName,
    this.vendorLogoUrl,
    this.serviceImageUrl,
    this.vendorPhone,
    this.reviewSubmitted = false,
  });

  bool get isPending => status == CustomerOrderStatus.pendingAcceptance;
  bool get isActive =>
      status == CustomerOrderStatus.accepted ||
      status == CustomerOrderStatus.enRoute ||
      status == CustomerOrderStatus.arrived ||
      status == CustomerOrderStatus.inProgress;
  bool get isCompleted => status == CustomerOrderStatus.completed;
  bool get isCancelled => status == CustomerOrderStatus.cancelled;
  bool get isRejected => status == CustomerOrderStatus.rejected;

  String get statusDisplay {
    switch (status) {
      case CustomerOrderStatus.pendingAcceptance:
        return 'Pending Acceptance';
      case CustomerOrderStatus.accepted:
        return 'Accepted';
      case CustomerOrderStatus.enRoute:
        return 'En Route';
      case CustomerOrderStatus.arrived:
        return 'Arrived';
      case CustomerOrderStatus.inProgress:
        return 'In Progress';
      case CustomerOrderStatus.completed:
        return 'Completed';
      case CustomerOrderStatus.rejected:
        return 'Rejected';
      case CustomerOrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  CustomerOrder copyWith({
    String? id,
    String? orderRef,
    String? vendorServiceId,
    String? customerId,
    String? vendorId,
    CustomerOrderStatus? status,
    String? baseAmount,
    String? totalAmount,
    double? locationLat,
    double? locationLng,
    String? locationAddress,
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
    String? vendorName,
    String? vendorLogoUrl,
    String? serviceImageUrl,
    String? vendorPhone,
    bool? reviewSubmitted,
  }) {
    return CustomerOrder(
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
      vendorName: vendorName ?? this.vendorName,
      vendorLogoUrl: vendorLogoUrl ?? this.vendorLogoUrl,
      serviceImageUrl: serviceImageUrl ?? this.serviceImageUrl,
      vendorPhone: vendorPhone ?? this.vendorPhone,
      reviewSubmitted: reviewSubmitted ?? this.reviewSubmitted,
    );
  }
}
