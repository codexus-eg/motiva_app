import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/address_local_data_source.dart';
import '../../data/datasources/checkout_remote_data_source.dart';
import '../../data/repositories/checkout_repository_impl.dart';
import '../../domain/entities/checkout_result.dart';
import '../../domain/entities/delivery_address.dart';
import '../../domain/repositories/checkout_repository.dart';

final checkoutRemoteDataSourceProvider = Provider<CheckoutRemoteDataSource>((
  ref,
) {
  final dioClient = ref.watch(dioClientProvider);
  return CheckoutRemoteDataSourceImpl(dioClient);
});

final checkoutRepositoryProvider = Provider<CheckoutRepository>((ref) {
  final remoteDataSource = ref.watch(checkoutRemoteDataSourceProvider);
  return CheckoutRepositoryImpl(remoteDataSource);
});

final addressLocalDataSourceProvider = Provider<AddressLocalDataSource>((ref) {
  return AddressLocalDataSourceImpl();
});

final savedAddressesProvider = FutureProvider<List<DeliveryAddress>>((
  ref,
) async {
  final localDataSource = ref.watch(addressLocalDataSourceProvider);
  return localDataSource.getSavedAddresses();
});

final walletBalanceProvider = Provider<String>((ref) {
  return 'KWD 2.50';
});

class CheckoutNotifier extends AsyncNotifier<CheckoutResult> {
  @override
  CheckoutResult build() {
    throw UnimplementedError();
  }

  Future<CheckoutResult> checkout({DeliveryAddress? address}) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(checkoutRepositoryProvider);
    state = await AsyncValue.guard(() => repository.checkout(address: address));
    return state.value!;
  }
}

final checkoutNotifierProvider =
    AsyncNotifierProvider<CheckoutNotifier, CheckoutResult>(
      () => CheckoutNotifier(),
    );
