import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/vendor-product-analytics/data/datasources/vendor_product_analytics_local_data_source.dart';
import 'package:app/features/vendor-product-analytics/data/datasources/vendor_product_analytics_remote_data_source.dart';
import 'package:app/features/vendor-product-analytics/data/repositories/vendor_product_analytics_repository_impl.dart';
import 'package:app/features/vendor-product-analytics/domain/repositories/vendor_product_analytics_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'vendor_product_analytics_state.dart';

final vendorProductAnalyticsRemoteDataSourceProvider =
    Provider<VendorProductAnalyticsRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return VendorProductAnalyticsRemoteDataSourceImpl(dioClient);
    });

final vendorProductAnalyticsLocalDataSourceProvider =
    Provider<VendorProductAnalyticsLocalDataSource>((ref) {
      return VendorProductAnalyticsLocalDataSourceImpl();
    });

final vendorProductAnalyticsRepositoryProvider =
    Provider<VendorProductAnalyticsRepository>((ref) {
      final remote = ref.watch(vendorProductAnalyticsRemoteDataSourceProvider);
      final local = ref.watch(vendorProductAnalyticsLocalDataSourceProvider);
      return VendorProductAnalyticsRepositoryImpl(remote, local);
    });

final vendorProductAnalyticsNotifierProvider =
    AsyncNotifierProviderFamily<
      VendorProductAnalyticsNotifier,
      VendorProductAnalyticsState,
      String?
    >(() {
      return VendorProductAnalyticsNotifier();
    });

class VendorProductAnalyticsNotifier
    extends FamilyAsyncNotifier<VendorProductAnalyticsState, String?> {
  TimePeriod _timePeriod = TimePeriod.sevenDays;

  @override
  Future<VendorProductAnalyticsState> build(String? arg) async {
    final productId = arg;
    return _fetchAnalytics(productId);
  }

  Future<VendorProductAnalyticsState> _fetchAnalytics(String? productId) async {
    final repository = ref.read(vendorProductAnalyticsRepositoryProvider);
    final now = DateTime.now();
    final toDate = now.toIso8601String().split('T').first;
    final fromDate = _computeFromDate(now, _timePeriod);

    final analytics = await repository.getAnalytics(
      productId: productId,
      fromDate: fromDate,
      toDate: toDate,
    );

    return VendorProductAnalyticsState(
      analytics: analytics,
      timePeriod: _timePeriod,
    );
  }

  String _computeFromDate(DateTime now, TimePeriod period) {
    switch (period) {
      case TimePeriod.sevenDays:
        return now
            .subtract(const Duration(days: 7))
            .toIso8601String()
            .split('T')
            .first;
      case TimePeriod.thirtyDays:
        return now
            .subtract(const Duration(days: 30))
            .toIso8601String()
            .split('T')
            .first;
      case TimePeriod.ninetyDays:
        return now
            .subtract(const Duration(days: 90))
            .toIso8601String()
            .split('T')
            .first;
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchAnalytics(arg));
  }

  Future<void> setTimePeriod(TimePeriod period) async {
    if (_timePeriod == period) return;
    _timePeriod = period;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchAnalytics(arg));
  }
}
