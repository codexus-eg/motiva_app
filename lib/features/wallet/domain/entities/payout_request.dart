import 'package:flutter/foundation.dart';

@immutable
class PayoutRequest {
  final String id;
  final String userId;
  final String amount;
  final String status;
  final String? bankName;
  final String? accountNumber;
  final String? accountHolderName;
  final String? kuwaitCode;
  final String? adminNotes;
  final String? reviewedBy;
  final DateTime? reviewedAt;
  final DateTime? processedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PayoutRequest({
    required this.id,
    required this.userId,
    required this.amount,
    required this.status,
    this.bankName,
    this.accountNumber,
    this.accountHolderName,
    this.kuwaitCode,
    this.adminNotes,
    this.reviewedBy,
    this.reviewedAt,
    this.processedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  PayoutRequest copyWith({
    String? id,
    String? userId,
    String? amount,
    String? status,
    String? bankName,
    String? accountNumber,
    String? accountHolderName,
    String? kuwaitCode,
    String? adminNotes,
    String? reviewedBy,
    DateTime? reviewedAt,
    DateTime? processedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PayoutRequest(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      kuwaitCode: kuwaitCode ?? this.kuwaitCode,
      adminNotes: adminNotes ?? this.adminNotes,
      reviewedBy: reviewedBy ?? this.reviewedBy,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      processedAt: processedAt ?? this.processedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PayoutRequest &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          amount == other.amount &&
          status == other.status &&
          bankName == other.bankName &&
          accountNumber == other.accountNumber &&
          accountHolderName == other.accountHolderName &&
          kuwaitCode == other.kuwaitCode &&
          adminNotes == other.adminNotes &&
          reviewedBy == other.reviewedBy &&
          reviewedAt == other.reviewedAt &&
          processedAt == other.processedAt &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    amount,
    status,
    bankName,
    accountNumber,
    accountHolderName,
    kuwaitCode,
    adminNotes,
    reviewedBy,
    reviewedAt,
    processedAt,
    createdAt,
    updatedAt,
  );

  @override
  String toString() =>
      'PayoutRequest(id: $id, userId: $userId, amount: $amount, status: $status, bankName: $bankName, accountNumber: $accountNumber, accountHolderName: $accountHolderName, kuwaitCode: $kuwaitCode, adminNotes: $adminNotes, reviewedBy: $reviewedBy, reviewedAt: $reviewedAt, processedAt: $processedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}
