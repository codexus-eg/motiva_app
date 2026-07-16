import '../../domain/entities/vendor_product_analytics.dart';

enum TimePeriod { sevenDays, thirtyDays, ninetyDays }

class VendorProductAnalyticsState {
  final VendorProductAnalytics analytics;
  final TimePeriod timePeriod;

  const VendorProductAnalyticsState({
    required this.analytics,
    required this.timePeriod,
  });
}
