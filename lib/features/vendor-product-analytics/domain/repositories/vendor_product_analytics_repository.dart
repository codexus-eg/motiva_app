import '../entities/vendor_product_analytics.dart';

abstract class VendorProductAnalyticsRepository {
  Future<VendorProductAnalytics> getAnalytics({
    String? productId,
    String? fromDate,
    String? toDate,
  });
}
