import '../../domain/entities/vendor_product_analytics.dart';

class VendorProductAnalyticsModel {
  final VendorProductAnalytics analytics;

  const VendorProductAnalyticsModel({required this.analytics});

  factory VendorProductAnalyticsModel.fromJson(Map<String, dynamic> json) {
    final topProductsJson = json['topProducts'] as List<dynamic>? ?? [];
    final revenueOverTimeJson = json['revenueOverTime'] as List<dynamic>? ?? [];

    return VendorProductAnalyticsModel(
      analytics: VendorProductAnalytics(
        topProducts: topProductsJson.map((e) {
          final map = e as Map<String, dynamic>;
          return TopProductSales(
            name: map['name'] as String? ?? '',
            salesCount: (map['salesCount'] as num?)?.toInt() ?? 0,
            revenue: (map['revenue'] as num?)?.toDouble() ?? 0.0,
          );
        }).toList(),
        revenueOverTime: revenueOverTimeJson.map((e) {
          final map = e as Map<String, dynamic>;
          return RevenuePoint(
            date: DateTime.tryParse(map['date'] as String? ?? '') ?? DateTime.now(),
            revenue: (map['revenue'] as num?)?.toDouble() ?? 0.0,
          );
        }).toList(),
        totalViews: (json['totalViews'] as num?)?.toInt() ?? 0,
        conversionRate: (json['conversionRate'] as num?)?.toDouble() ?? 0.0,
        totalOrders: (json['totalOrders'] as num?)?.toInt() ?? 0,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topProducts': analytics.topProducts.map((p) => {
        'name': p.name,
        'salesCount': p.salesCount,
        'revenue': p.revenue,
      }).toList(),
      'revenueOverTime': analytics.revenueOverTime.map((r) => {
        'date': r.date.toIso8601String(),
        'revenue': r.revenue,
      }).toList(),
      'totalViews': analytics.totalViews,
      'conversionRate': analytics.conversionRate,
      'totalOrders': analytics.totalOrders,
    };
  }
}
