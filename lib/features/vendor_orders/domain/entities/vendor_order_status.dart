import 'package:flutter/material.dart';

enum VendorOrderStatus {
  pendingAcceptance('pending_acceptance', 'Pending Acceptance'),
  accepted('accepted', 'Accepted'),
  enRoute('en_route', 'On the Way'),
  arrived('arrived', 'Arrived'),
  inProgress('in_progress', 'In Progress'),
  completed('completed', 'Completed'),
  cancelled('cancelled', 'Cancelled'),
  rejected('rejected', 'Rejected');

  final String value;
  final String displayName;

  const VendorOrderStatus(this.value, this.displayName);

  static VendorOrderStatus fromString(String status) {
    return VendorOrderStatus.values.firstWhere(
      (e) => e.value == status,
      orElse: () => VendorOrderStatus.pendingAcceptance,
    );
  }

  Color getColor() {
    switch (this) {
      case VendorOrderStatus.pendingAcceptance:
        return Colors.orange;
      case VendorOrderStatus.accepted:
        return Colors.blue;
      case VendorOrderStatus.enRoute:
        return Colors.lightBlue;
      case VendorOrderStatus.arrived:
        return Colors.teal;
      case VendorOrderStatus.inProgress:
        return Colors.indigo;
      case VendorOrderStatus.completed:
        return Colors.green;
      case VendorOrderStatus.cancelled:
        return Colors.red;
      case VendorOrderStatus.rejected:
        return Colors.grey;
    }
  }

  bool get isPendingAcceptance => this == VendorOrderStatus.pendingAcceptance;
  bool get isAccepted => this == VendorOrderStatus.accepted;
  bool get isEnRoute => this == VendorOrderStatus.enRoute;
  bool get isArrived => this == VendorOrderStatus.arrived;
  bool get isInProgress => this == VendorOrderStatus.inProgress;
  bool get isCompleted => this == VendorOrderStatus.completed;
  bool get isCancelled => this == VendorOrderStatus.cancelled;
  bool get isRejected => this == VendorOrderStatus.rejected;

  bool get isActive =>
      this == VendorOrderStatus.accepted ||
      this == VendorOrderStatus.enRoute ||
      this == VendorOrderStatus.arrived ||
      this == VendorOrderStatus.inProgress;

  bool get canAccept => this == VendorOrderStatus.pendingAcceptance;
  bool get canReject => this == VendorOrderStatus.pendingAcceptance;
  bool get canStartTravel => this == VendorOrderStatus.accepted;
  bool get canArrive => this == VendorOrderStatus.enRoute;
  bool get canStartService => this == VendorOrderStatus.arrived;
  bool get canComplete =>
      this == VendorOrderStatus.accepted ||
      this == VendorOrderStatus.enRoute ||
      this == VendorOrderStatus.arrived ||
      this == VendorOrderStatus.inProgress;

  bool get canAssignOperator => this == VendorOrderStatus.accepted;
}
