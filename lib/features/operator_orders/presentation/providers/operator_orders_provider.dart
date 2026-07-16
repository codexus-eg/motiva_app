import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/operator_orders_remote_data_source.dart';
import '../../data/repositories/operator_orders_repository_impl.dart';
import '../../domain/repositories/operator_orders_repository.dart';
import '../../../vendor_orders/domain/entities/vendor_order.dart';

final operatorOrdersRemoteDataSourceProvider =
    Provider<OperatorOrdersRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return OperatorOrdersRemoteDataSourceImpl(dioClient);
    });

final operatorOrdersRepositoryProvider = Provider<OperatorOrdersRepository>((
  ref,
) {
  final remoteDataSource = ref.watch(operatorOrdersRemoteDataSourceProvider);
  return OperatorOrdersRepositoryImpl(remoteDataSource);
});

final operatorOrdersProvider = FutureProvider<List<VendorOrder>>((ref) async {
  final repository = ref.watch(operatorOrdersRepositoryProvider);
  final orders = await repository.getMyOrders();
  debugPrint('OperatorOrders: Fetched ${orders.length} orders');
  for (final order in orders) {
    debugPrint(
      '  Order: ${order.orderRef} - status: ${order.status} - serviceName: ${order.serviceName} - customerName: ${order.customerName}',
    );
  }
  return orders;
});

final operatorActiveOrdersProvider = FutureProvider<List<VendorOrder>>((
  ref,
) async {
  final orders = await ref.watch(operatorOrdersProvider.future);
  final active = orders.where((o) => o.isPending).toList();
  debugPrint(
    'OperatorActive: ${active.length} active orders from ${orders.length} total orders',
  );
  return active;
});

final operatorCompletedOrdersProvider = FutureProvider<List<VendorOrder>>((
  ref,
) async {
  final orders = await ref.watch(operatorOrdersProvider.future);
  final completed = orders.where((o) => o.isCompleted).toList();
  debugPrint(
    'OperatorCompleted: ${completed.length} completed orders from ${orders.length} total orders',
  );
  return completed;
});

final operatorCancelledOrdersProvider = FutureProvider<List<VendorOrder>>((
  ref,
) async {
  final orders = await ref.watch(operatorOrdersProvider.future);
  return orders.where((o) => o.isCancelled || o.isRejected).toList();
});

final operatorOrderByIdProvider = FutureProvider.family<VendorOrder, String>((
  ref,
  orderId,
) async {
  final repository = ref.watch(operatorOrdersRepositoryProvider);
  return repository.getOrderById(orderId);
});

void _invalidateAllOrderProviders(Ref ref, String orderId) {
  ref.invalidate(operatorOrdersProvider);
  ref.invalidate(operatorActiveOrdersProvider);
  ref.invalidate(operatorCompletedOrdersProvider);
  ref.invalidate(operatorCancelledOrdersProvider);
  ref.invalidate(operatorOrderByIdProvider(orderId));
}

// Action Notifiers
class OperatorStartTravelNotifier extends AsyncNotifier<VendorOrder> {
  @override
  VendorOrder build() {
    throw UnimplementedError();
  }

  Future<VendorOrder> startTravel(String orderId) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(operatorOrdersRepositoryProvider);
    state = await AsyncValue.guard(() => repository.startTravel(orderId));
    _invalidateAllOrderProviders(ref, orderId);
    return state.value!;
  }
}

final operatorStartTravelNotifierProvider =
    AsyncNotifierProvider<OperatorStartTravelNotifier, VendorOrder>(
      () => OperatorStartTravelNotifier(),
    );

class OperatorArriveNotifier extends AsyncNotifier<VendorOrder> {
  @override
  VendorOrder build() {
    throw UnimplementedError();
  }

  Future<VendorOrder> arrive(String orderId) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(operatorOrdersRepositoryProvider);
    state = await AsyncValue.guard(() => repository.arrive(orderId));
    _invalidateAllOrderProviders(ref, orderId);
    return state.value!;
  }
}

final operatorArriveNotifierProvider =
    AsyncNotifierProvider<OperatorArriveNotifier, VendorOrder>(
      () => OperatorArriveNotifier(),
    );

class OperatorStartServiceNotifier extends AsyncNotifier<VendorOrder> {
  @override
  VendorOrder build() {
    throw UnimplementedError();
  }

  Future<VendorOrder> startService(String orderId) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(operatorOrdersRepositoryProvider);
    state = await AsyncValue.guard(() => repository.startService(orderId));
    _invalidateAllOrderProviders(ref, orderId);
    return state.value!;
  }
}

final operatorStartServiceNotifierProvider =
    AsyncNotifierProvider<OperatorStartServiceNotifier, VendorOrder>(
      () => OperatorStartServiceNotifier(),
    );

class OperatorCompleteOrderNotifier extends AsyncNotifier<VendorOrder> {
  @override
  VendorOrder build() {
    throw UnimplementedError();
  }

  Future<VendorOrder> complete(String orderId, double finalPrice) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(operatorOrdersRepositoryProvider);
    state = await AsyncValue.guard(
      () => repository.completeOrder(orderId, finalPrice),
    );
    _invalidateAllOrderProviders(ref, orderId);
    return state.value!;
  }
}

final operatorCompleteOrderNotifierProvider =
    AsyncNotifierProvider<OperatorCompleteOrderNotifier, VendorOrder>(
      () => OperatorCompleteOrderNotifier(),
    );

// Legacy Actions (kept for backward compatibility)
final startTravelOperatorOrderProvider =
    FutureProvider.family<VendorOrder, String>((ref, orderId) async {
      final repository = ref.watch(operatorOrdersRepositoryProvider);
      final order = await repository.startTravel(orderId);
      ref.invalidate(operatorOrdersProvider);
      return order;
    });

final arriveOperatorOrderProvider = FutureProvider.family<VendorOrder, String>((
  ref,
  orderId,
) async {
  final repository = ref.watch(operatorOrdersRepositoryProvider);
  final order = await repository.arrive(orderId);
  ref.invalidate(operatorOrdersProvider);
  return order;
});

final startServiceOperatorOrderProvider =
    FutureProvider.family<VendorOrder, String>((ref, orderId) async {
      final repository = ref.watch(operatorOrdersRepositoryProvider);
      final order = await repository.startService(orderId);
      ref.invalidate(operatorOrdersProvider);
      return order;
    });

final completeOperatorOrderProvider =
    FutureProvider.family<VendorOrder, ({String orderId, double finalPrice})>((
      ref,
      params,
    ) async {
      final repository = ref.watch(operatorOrdersRepositoryProvider);
      final order = await repository.completeOrder(
        params.orderId,
        params.finalPrice,
      );
      ref.invalidate(operatorOrdersProvider);
      return order;
    });
