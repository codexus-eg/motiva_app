class TopProductSales {
  final String name;
  final int salesCount;
  final double revenue;

  const TopProductSales({
    required this.name,
    required this.salesCount,
    required this.revenue,
  });
}

class RevenuePoint {
  final DateTime date;
  final double revenue;

  const RevenuePoint({
    required this.date,
    required this.revenue,
  });
}

class VendorProductAnalytics {
  final List<TopProductSales> topProducts;
  final List<RevenuePoint> revenueOverTime;
  final int totalViews;
  final double conversionRate;
  final int totalOrders;

  const VendorProductAnalytics({
    required this.topProducts,
    required this.revenueOverTime,
    required this.totalViews,
    required this.conversionRate,
    required this.totalOrders,
  });
}
