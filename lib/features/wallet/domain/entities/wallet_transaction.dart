import 'package:flutter/foundation.dart';

@immutable
class WalletTransaction {
  final String id;
  final String walletId;
  final String? userId;
  final String type;
  final String amount;
  final String balanceBefore;
  final String balanceAfter;
  final String referenceType;
  final String? referenceId;
  final String? description;
  final DateTime createdAt;

  const WalletTransaction({
    required this.id,
    required this.walletId,
    this.userId,
    required this.type,
    required this.amount,
    required this.balanceBefore,
    required this.balanceAfter,
    required this.referenceType,
    this.referenceId,
    this.description,
    required this.createdAt,
  });

  WalletTransaction copyWith({
    String? id,
    String? walletId,
    String? userId,
    String? type,
    String? amount,
    String? balanceBefore,
    String? balanceAfter,
    String? referenceType,
    String? referenceId,
    String? description,
    DateTime? createdAt,
  }) {
    return WalletTransaction(
      id: id ?? this.id,
      walletId: walletId ?? this.walletId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      balanceBefore: balanceBefore ?? this.balanceBefore,
      balanceAfter: balanceAfter ?? this.balanceAfter,
      referenceType: referenceType ?? this.referenceType,
      referenceId: referenceId ?? this.referenceId,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletTransaction &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          walletId == other.walletId &&
          userId == other.userId &&
          type == other.type &&
          amount == other.amount &&
          balanceBefore == other.balanceBefore &&
          balanceAfter == other.balanceAfter &&
          referenceType == other.referenceType &&
          referenceId == other.referenceId &&
          description == other.description &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(
    id,
    walletId,
    userId,
    type,
    amount,
    balanceBefore,
    balanceAfter,
    referenceType,
    referenceId,
    description,
    createdAt,
  );

  @override
  String toString() =>
      'WalletTransaction(id: $id, walletId: $walletId, userId: $userId, type: $type, amount: $amount, balanceBefore: $balanceBefore, balanceAfter: $balanceAfter, referenceType: $referenceType, referenceId: $referenceId, description: $description, createdAt: $createdAt)';
}
