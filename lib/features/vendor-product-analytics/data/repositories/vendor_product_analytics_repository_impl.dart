import 'package:app/core/utils/app_logger.dart';

import '../../domain/entities/vendor_product_analytics.dart';
import '../../domain/failures/vendor_product_analytics_failure.dart';
import '../../domain/repositories/vendor_product_analytics_repository.dart';
import '../datasources/vendor_product_analytics_local_data_source.dart';
import '../datasources/vendor_product_analytics_remote_data_source.dart';

class VendorProductAnalyticsRepositoryImpl
    implements VendorProductAnalyticsRepository {
  final VendorProductAnalyticsRemoteDataSource _remoteDataSource;
  final VendorProductAnalyticsLocalDataSource _localDataSource;

  VendorProductAnalyticsRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  String _cacheKey(String? productId, String? fromDate, String? toDate) {
    return '${productId ?? 'all'}_${fromDate ?? 'none'}_${toDate ?? 'none'}';
  }

  @override
  Future<VendorProductAnalytics> getAnalytics({
    String? productId,
    String? fromDate,
    String? toDate,
  }) async {
    final cacheKey = _cacheKey(productId, fromDate, toDate);

    try {
      final model = await _remoteDataSource.getAnalytics(
        productId: productId,
        fromDate: fromDate,
        toDate: toDate,
      );

      await _localDataSource.cacheAnalytics(cacheKey, model);

      return model.analytics;
    } on VendorProductAnalyticsFailure catch (e) {
      if (e.code == 'network') {
        final cached = await _localDataSource.getCachedAnalytics(cacheKey);
        if (cached != null) {
          AppLogger.debug('Returning cached analytics for $cacheKey');
          return cached.analytics;
        }
      }
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('getAnalytics failed', error: e, stackTrace: stackTrace);
      final cached = await _localDataSource.getCachedAnalytics(cacheKey);
      if (cached != null) {
        return cached.analytics;
      }
      throw VendorProductAnalyticsFailure.unknown(e.toString());
    }
  }
}
