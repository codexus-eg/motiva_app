import '../../domain/entities/loyalty_config.dart';

class LoyaltyConfigModel {
  final LoyaltyConfig config;

  const LoyaltyConfigModel(this.config);

  factory LoyaltyConfigModel.fromJson(Map<String, dynamic> json) {
    return LoyaltyConfigModel(
      LoyaltyConfig(
        balance: json['balance'] != null ? (json['balance'] as num).toInt() : 0,
        lifetimeEarned: json['lifetimeEarned'] != null
            ? (json['lifetimeEarned'] as num).toInt()
            : 0,
        minRedeemPoints: json['minRedeemPoints'] != null
            ? (json['minRedeemPoints'] as num).toInt()
            : 0,
        earnRatePerKwd: json['earnRatePerKwd'] != null
            ? _parseToDouble(json['earnRatePerKwd'])
            : 0.0,
        redeemRate: json['redeemRate'] != null
            ? _parseToDouble(json['redeemRate'])
            : 0.0,
        maxRedeemPercent: json['maxRedeemPercent'] != null
            ? (json['maxRedeemPercent'] as num).toDouble()
            : 100.0,
        isActive: json['isActive'] as bool? ?? true,
      ),
    );
  }

  static double _parseToDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }

  Map<String, dynamic> toJson() => {
    'minRedeemPoints': config.minRedeemPoints,
    'earnRatePerKwd': config.earnRatePerKwd,
    'redeemRate': config.redeemRate,
    'maxRedeemPercent': config.maxRedeemPercent,
    'isActive': config.isActive,
  };
}
