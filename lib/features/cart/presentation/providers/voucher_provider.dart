import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/voucher_remote_data_source.dart';
import '../../data/repositories/voucher_repository_impl.dart';
import '../../domain/entities/voucher_response.dart';
import '../../domain/repositories/voucher_repository.dart';

final voucherRemoteDataSourceProvider = Provider<VoucherRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return VoucherRemoteDataSourceImpl(dioClient);
});

final voucherRepositoryProvider = Provider<VoucherRepository>((ref) {
  final remoteDataSource = ref.watch(voucherRemoteDataSourceProvider);
  return VoucherRepositoryImpl(remoteDataSource);
});

class VoucherNotifier extends AsyncNotifier<VoucherResponse> {
  @override
  VoucherResponse build() {
    throw UnimplementedError();
  }

  Future<VoucherResponse> redeem(String code) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(voucherRepositoryProvider);
    state = await AsyncValue.guard(() => repository.redeem(code));
    return state.value!;
  }
}

final voucherNotifierProvider =
    AsyncNotifierProvider<VoucherNotifier, VoucherResponse>(
      () => VoucherNotifier(),
    );
