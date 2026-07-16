import 'package:flutter/foundation.dart';

@immutable
class WalletBalance {
  final String walletId;
  final String userId;
  final String balance;
  final String currency;

  const WalletBalance({
    required this.walletId,
    required this.userId,
    required this.balance,
    required this.currency,
  });

  WalletBalance copyWith({
    String? walletId,
    String? userId,
    String? balance,
    String? currency,
  }) {
    return WalletBalance(
      walletId: walletId ?? this.walletId,
      userId: userId ?? this.userId,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletBalance &&
          runtimeType == other.runtimeType &&
          walletId == other.walletId &&
          userId == other.userId &&
          balance == other.balance &&
          currency == other.currency;

  @override
  int get hashCode => Object.hash(walletId, userId, balance, currency);

  @override
  String toString() =>
      'WalletBalance(walletId: $walletId, userId: $userId, balance: $balance, currency: $currency)';
}
