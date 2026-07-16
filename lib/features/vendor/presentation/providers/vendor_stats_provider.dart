import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/vendor/data/datasources/vendor_stats_remote_data_source.dart';
import 'package:app/features/vendor/data/repositories/vendor_stats_repository_impl.dart';
import 'package:app/features/vendor/domain/entities/vendor_stats.dart';
import 'package:app/features/vendor/domain/repositories/vendor_stats_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final vendorStatsRemoteDataSourceProvider =
    Provider<VendorStatsRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return VendorStatsRemoteDataSourceImpl(dioClient);
    });

final vendorStatsRepositoryProvider = Provider<VendorStatsRepository>((ref) {
  final remoteDataSource = ref.watch(vendorStatsRemoteDataSourceProvider);
  return VendorStatsRepositoryImpl(remoteDataSource);
});

final vendorStatsProvider = FutureProvider.family<VendorStats, String>((
  ref,
  vendorId,
) async {
  final repository = ref.watch(vendorStatsRepositoryProvider);
  return repository.getVendorStats(vendorId);
});
