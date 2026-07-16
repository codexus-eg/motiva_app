import 'package:app/features/vendor/domain/entities/vendor_stats.dart';

abstract class VendorStatsRepository {
  Future<VendorStats> getVendorStats(String vendorId);
}
