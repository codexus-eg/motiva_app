import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/vendor_checkout_orders_remote_data_source.dart';
import '../../data/repositories/vendor_checkout_orders_repository_impl.dart';
import '../../domain/entities/vendor_checkout_order.dart';
import '../../domain/entities/vendor_checkout_order_detail.dart';
import '../../domain/repositories/vendor_checkout_orders_repository.dart';

final vendorCheckoutOrdersRemoteDataSourceProvider =
    Provider<VendorCheckoutOrdersRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return VendorCheckoutOrdersRemoteDataSourceImpl(dioClient);
    });

final vendorCheckoutOrdersRepositoryProvider =
    Provider<VendorCheckoutOrdersRepository>((ref) {
      final remoteDataSource = ref.watch(vendorCheckoutOrdersRemoteDataSourceProvider);
      return VendorCheckoutOrdersRepositoryImpl(remoteDataSource);
    });

final vendorCheckoutOrdersProvider = FutureProvider<List<VendorCheckoutOrder>>(
  (ref) async {
    final repository = ref.watch(vendorCheckoutOrdersRepositoryProvider);
    final orders = await repository.getVendorOrders();
    debugPrint('VendorCheckoutOrders: Fetched ${orders.length} orders');
    for (final order in orders) {
      debugPrint(
        '  Order: ${order.orderNumber} - status: ${order.status} - amount: ${order.totalAmount}',
      );
    }
    return orders;
  },
);

final vendorCheckoutOrdersGroupedProvider =
    FutureProvider<Map<String, List<VendorCheckoutOrder>>>((ref) async {
      final orders = await ref.watch(vendorCheckoutOrdersProvider.future);
      final pending = orders.where((o) => o.status == 'pending').toList();
      final processing = orders.where((o) => o.status == 'processing').toList();
      final confirmed = orders.where((o) => o.status == 'confirmed').toList();
      final shipped = orders.where((o) => o.status == 'shipped').toList();

      return {
        'all': orders,
        'pending': pending,
        'processing': processing,
        'confirmed': confirmed,
        'shipped': shipped,
      };
    });

final vendorCheckoutOrderByIdProvider =
    FutureProvider.family<VendorCheckoutOrder, String>((ref, orderId) async {
      final repository = ref.watch(vendorCheckoutOrdersRepositoryProvider);
      return repository.getOrderById(orderId);
    });

final vendorCheckoutOrderDetailProvider =
    FutureProvider.family<VendorCheckoutOrderDetail, String>((ref, orderId) async {
      final repository = ref.watch(vendorCheckoutOrdersRepositoryProvider);
      return repository.getOrderDetail(orderId);
    });

void _invalidateAllCheckoutOrderProviders(Ref ref, String orderId) {
  ref.invalidate(vendorCheckoutOrdersProvider);
  ref.invalidate(vendorCheckoutOrdersGroupedProvider);
  ref.invalidate(vendorCheckoutOrderByIdProvider(orderId));
  ref.invalidate(vendorCheckoutOrderDetailProvider(orderId));
}

class UpdateCheckoutOrderStatusNotifier extends AsyncNotifier<VendorCheckoutOrder> {
  @override
  VendorCheckoutOrder build() {
    throw UnimplementedError();
  }

  Future<VendorCheckoutOrder> updateStatus(String orderId, String status) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(vendorCheckoutOrdersRepositoryProvider);
    state = await AsyncValue.guard(() => repository.updateOrderStatus(orderId, status));
    _invalidateAllCheckoutOrderProviders(ref, orderId);
    return state.value!;
  }
}

final updateCheckoutOrderStatusNotifierProvider =
    AsyncNotifierProvider<UpdateCheckoutOrderStatusNotifier, VendorCheckoutOrder>(
      () => UpdateCheckoutOrderStatusNotifier(),
    );


