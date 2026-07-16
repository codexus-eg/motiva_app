import 'package:flutter/foundation.dart';

@immutable
class LoyaltyConfig {
  final int balance;
  final int lifetimeEarned;
  final int minRedeemPoints;
  final double earnRatePerKwd;
  final double redeemRate;
  final double maxRedeemPercent;
  final bool isActive;

  const LoyaltyConfig({
    required this.balance,
    required this.lifetimeEarned,
    required this.minRedeemPoints,
    required this.earnRatePerKwd,
    required this.redeemRate,
    required this.maxRedeemPercent,
    required this.isActive,
  });

  LoyaltyConfig copyWith({
    int? balance,
    int? lifetimeEarned,
    int? minRedeemPoints,
    double? earnRatePerKwd,
    double? redeemRate,
    double? maxRedeemPercent,
    bool? isActive,
  }) {
    return LoyaltyConfig(
      balance: balance ?? this.balance,
      lifetimeEarned: lifetimeEarned ?? this.lifetimeEarned,
      minRedeemPoints: minRedeemPoints ?? this.minRedeemPoints,
      earnRatePerKwd: earnRatePerKwd ?? this.earnRatePerKwd,
      redeemRate: redeemRate ?? this.redeemRate,
      maxRedeemPercent: maxRedeemPercent ?? this.maxRedeemPercent,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoyaltyConfig &&
          runtimeType == other.runtimeType &&
          balance == other.balance &&
          lifetimeEarned == other.lifetimeEarned &&
          minRedeemPoints == other.minRedeemPoints &&
          earnRatePerKwd == other.earnRatePerKwd &&
          redeemRate == other.redeemRate &&
          maxRedeemPercent == other.maxRedeemPercent &&
          isActive == other.isActive;

  @override
  int get hashCode => Object.hash(
    balance,
    lifetimeEarned,
    minRedeemPoints,
    earnRatePerKwd,
    redeemRate,
    maxRedeemPercent,
    isActive,
  );

  @override
  String toString() =>
      'LoyaltyConfig(balance: $balance, lifetimeEarned: $lifetimeEarned, minRedeemPoints: $minRedeemPoints, earnRatePerKwd: $earnRatePerKwd, redeemRate: $redeemRate, maxRedeemPercent: $maxRedeemPercent, isActive: $isActive)';
}
