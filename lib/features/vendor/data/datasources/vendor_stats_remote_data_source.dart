import 'package:app/core/network/dio_client.dart';
import 'package:app/features/vendor/domain/entities/vendor_stats.dart';

abstract class VendorStatsRemoteDataSource {
  Future<VendorStats> getVendorStats(String vendorId);
}

class VendorStatsRemoteDataSourceImpl implements VendorStatsRemoteDataSource {
  final DioClient _dioClient;

  VendorStatsRemoteDataSourceImpl(this._dioClient);

  @override
  Future<VendorStats> getVendorStats(String vendorId) async {
    final response = await _dioClient.dio.get(
      '/api/public/vendors/$vendorId/stats',
    );
    return VendorStats.fromJson(response.data);
  }
}
