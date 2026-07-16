import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/vendor/data/datasources/vendor_stats_remote_data_source.dart';
import 'package:app/features/vendor/domain/entities/vendor_stats.dart';
import 'package:app/features/vendor/domain/repositories/vendor_stats_repository.dart';
import 'package:dio/dio.dart';

class VendorStatsRepositoryImpl implements VendorStatsRepository {
  final VendorStatsRemoteDataSource _remoteDataSource;

  VendorStatsRepositoryImpl(this._remoteDataSource);

  @override
  Future<VendorStats> getVendorStats(String vendorId) async {
    try {
      return await _remoteDataSource.getVendorStats(vendorId);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'Failed to get vendor stats',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
