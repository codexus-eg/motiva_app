import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import 'package:image_picker/image_picker.dart';
import '../../../vendor-services/data/models/vendor_service_model.dart';
import '../../../vendor-services/domain/entities/vendor_service.dart';
import '../../data/datasources/vendor_orders_remote_data_source.dart';
import '../../data/datasources/vendor_schedule_data_source.dart';
import '../../data/dtos/vendor_order_actions_dto.dart';
import '../../data/repositories/vendor_orders_repository_impl.dart';
import '../../domain/entities/vendor_order.dart';
import '../../domain/repositories/vendor_orders_repository.dart';

final vendorServiceApiProvider =
    FutureProvider.family<VendorService?, String>((ref, vendorServiceId) async {
  if (vendorServiceId.isEmpty) return null;
  try {
    final dioClient = ref.watch(dioClientProvider);
    final response =
        await dioClient.dio.get('/api/vendor-services/$vendorServiceId');
    return VendorServiceModel.fromJson(response.data).vendorService;
  } catch (e) {
    debugPrint('vendorServiceApiProvider failed: $e');
    return null;
  }
});

final vendorOrdersRemoteDataSourceProvider =
    Provider<VendorOrdersRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return VendorOrdersRemoteDataSourceImpl(dioClient);
    });

final vendorOrdersRepositoryProvider = Provider<VendorOrdersRepository>((ref) {
  final remoteDataSource = ref.watch(vendorOrdersRemoteDataSourceProvider);
  return VendorOrdersRepositoryImpl(remoteDataSource);
});

final vendorOrdersProvider = FutureProvider<List<VendorOrder>>((ref) async {
  final repository = ref.watch(vendorOrdersRepositoryProvider);
  final orders = await repository.getVendorOrders();
  debugPrint('VendorOrders: Fetched ${orders.length} orders');
  for (final order in orders) {
    debugPrint(
      '  Order: ${order.orderRef} - status: ${order.status} - serviceName: ${order.serviceName} - customerName: ${order.customerName}',
    );
  }
  return orders;
});

final vendorIncomingRequestsProvider = FutureProvider<List<VendorOrder>>((
  ref,
) async {
  final orders = await ref.watch(vendorOrdersProvider.future);
  final incoming = orders.where((o) => o.isIncoming).toList();
  debugPrint(
    'VendorIncoming: ${incoming.length} incoming requests from ${orders.length} total orders',
  );
  return incoming;
});

final vendorActiveOrdersProvider = FutureProvider<List<VendorOrder>>((
  ref,
) async {
  final orders = await ref.watch(vendorOrdersProvider.future);
  final active = orders.where((o) => o.isPending).toList();
  debugPrint(
    'VendorActive: ${active.length} active orders from ${orders.length} total orders',
  );
  return active;
});

final vendorCompletedOrdersProvider = FutureProvider<List<VendorOrder>>((
  ref,
) async {
  final orders = await ref.watch(vendorOrdersProvider.future);
  final completed = orders.where((o) => o.isCompleted).toList();
  debugPrint(
    'VendorCompleted: ${completed.length} completed orders from ${orders.length} total orders',
  );
  return completed;
});

final vendorCancelledOrdersProvider = FutureProvider<List<VendorOrder>>((
  ref,
) async {
  final orders = await ref.watch(vendorOrdersProvider.future);
  return orders.where((o) => o.isCancelled || o.isRejected).toList();
});

final vendorPendingAcceptanceProvider = FutureProvider<List<VendorOrder>>((
  ref,
) async {
  final orders = await ref.watch(vendorOrdersProvider.future);
  final pendingAcceptance = orders.where((o) => o.isIncoming).toList();
  pendingAcceptance.sort((a, b) {
    final aScheduled = a.scheduledAt;
    final bScheduled = b.scheduledAt;
    if (aScheduled == null && bScheduled == null) {
      return b.createdAt.compareTo(a.createdAt);
    }
    if (aScheduled == null) return -1;
    if (bScheduled == null) return 1;
    return aScheduled.compareTo(bScheduled);
  });
  return pendingAcceptance;
});

final vendorTodayScheduleProvider = FutureProvider<List<VendorOrder>>((
  ref,
) async {
  final orders = await ref.watch(vendorOrdersProvider.future);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final tomorrow = today.add(const Duration(days: 1));

  final todayOrders = orders.where((o) {
    if (o.scheduledAt == null) return false;
    final localScheduled = o.scheduledAt!.toLocal();
    return localScheduled.isAfter(today) && localScheduled.isBefore(tomorrow);
  }).toList();

  todayOrders.sort((a, b) => a.scheduledAt!.compareTo(b.scheduledAt!));
  return todayOrders;
});

final vendorActiveOrdersGroupedProvider =
    FutureProvider<Map<String, List<VendorOrder>>>((ref) async {
      final orders = await ref.watch(vendorOrdersProvider.future);
      final accepted = orders.where((o) => o.status == 'accepted').toList();
      final enRoute = orders.where((o) => o.status == 'en_route').toList();
      final arrived = orders.where((o) => o.status == 'arrived').toList();
      final inProgress = orders
          .where((o) => o.status == 'in_progress')
          .toList();

      return {
        'all': [...accepted, ...enRoute, ...arrived, ...inProgress],
        'en_route': enRoute,
        'arrived': arrived,
        'in_progress': inProgress,
      };
    });

final vendorOrderByIdProvider = FutureProvider.family<VendorOrder, String>((
  ref,
  orderId,
) async {
  final repository = ref.watch(vendorOrdersRepositoryProvider);
  return repository.getOrderById(orderId);
});

void _invalidateAllOrderProviders(Ref ref, String orderId) {
  ref.invalidate(vendorOrdersProvider);
  ref.invalidate(vendorIncomingRequestsProvider);
  ref.invalidate(vendorActiveOrdersProvider);
  ref.invalidate(vendorCompletedOrdersProvider);
  ref.invalidate(vendorCancelledOrdersProvider);
  ref.invalidate(vendorOrderByIdProvider(orderId));
}

class AcceptOrderNotifier extends AsyncNotifier<VendorOrder> {
  @override
  VendorOrder build() {
    throw UnimplementedError();
  }

  Future<VendorOrder> accept(String orderId) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(vendorOrdersRepositoryProvider);
    state = await AsyncValue.guard(() => repository.acceptOrder(orderId));
    _invalidateAllOrderProviders(ref, orderId);
    return state.value!;
  }
}

final acceptOrderNotifierProvider =
    AsyncNotifierProvider<AcceptOrderNotifier, VendorOrder>(
      () => AcceptOrderNotifier(),
    );

class RejectOrderNotifier extends AsyncNotifier<VendorOrder> {
  @override
  VendorOrder build() {
    throw UnimplementedError();
  }

  Future<VendorOrder> reject(String orderId, RejectOrderDto dto) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(vendorOrdersRepositoryProvider);
    state = await AsyncValue.guard(() => repository.rejectOrder(orderId, dto));
    _invalidateAllOrderProviders(ref, orderId);
    return state.value!;
  }
}

final rejectOrderNotifierProvider =
    AsyncNotifierProvider<RejectOrderNotifier, VendorOrder>(
      () => RejectOrderNotifier(),
    );

class StartTravelNotifier extends AsyncNotifier<VendorOrder> {
  @override
  VendorOrder build() {
    throw UnimplementedError();
  }

  Future<VendorOrder> startTravel(String orderId) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(vendorOrdersRepositoryProvider);
    state = await AsyncValue.guard(() => repository.startTravel(orderId));
    _invalidateAllOrderProviders(ref, orderId);
    return state.value!;
  }
}

final startTravelNotifierProvider =
    AsyncNotifierProvider<StartTravelNotifier, VendorOrder>(
      () => StartTravelNotifier(),
    );

class ArriveNotifier extends AsyncNotifier<VendorOrder> {
  @override
  VendorOrder build() {
    throw UnimplementedError();
  }

  Future<VendorOrder> arrive(String orderId) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(vendorOrdersRepositoryProvider);
    state = await AsyncValue.guard(() => repository.arrive(orderId));
    _invalidateAllOrderProviders(ref, orderId);
    return state.value!;
  }
}

final arriveNotifierProvider =
    AsyncNotifierProvider<ArriveNotifier, VendorOrder>(() => ArriveNotifier());

class StartServiceNotifier extends AsyncNotifier<VendorOrder> {
  @override
  VendorOrder build() {
    throw UnimplementedError();
  }

  Future<VendorOrder> startService(String orderId) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(vendorOrdersRepositoryProvider);
    state = await AsyncValue.guard(() => repository.startService(orderId));
    _invalidateAllOrderProviders(ref, orderId);
    return state.value!;
  }
}

final startServiceNotifierProvider =
    AsyncNotifierProvider<StartServiceNotifier, VendorOrder>(
      () => StartServiceNotifier(),
    );

class CompleteOrderNotifier extends AsyncNotifier<VendorOrder> {
  @override
  VendorOrder build() {
    throw UnimplementedError();
  }

  Future<VendorOrder> complete(String orderId, CompleteOrderDto dto) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(vendorOrdersRepositoryProvider);
    state = await AsyncValue.guard(
      () => repository.completeOrder(orderId, dto),
    );
    _invalidateAllOrderProviders(ref, orderId);
    return state.value!;
  }

  Future<VendorOrder> completeWithDocuments(
      String orderId, CompleteOrderDto dto, List<XFile> documents) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(vendorOrdersRepositoryProvider);
    state = await AsyncValue.guard(
      () => repository.completeOrderWithDocuments(orderId, dto, documents),
    );
    _invalidateAllOrderProviders(ref, orderId);
    return state.value!;
  }
}

final completeOrderNotifierProvider =
    AsyncNotifierProvider<CompleteOrderNotifier, VendorOrder>(
      () => CompleteOrderNotifier(),
    );

class AssignOperatorNotifier extends AsyncNotifier<VendorOrder> {
  @override
  VendorOrder build() {
    throw UnimplementedError();
  }

  Future<VendorOrder> assignOperator(
    String orderId,
    AssignOperatorDto dto,
  ) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(vendorOrdersRepositoryProvider);
    state = await AsyncValue.guard(
      () => repository.assignOperator(orderId, dto),
    );
    _invalidateAllOrderProviders(ref, orderId);
    return state.value!;
  }
}

final assignOperatorNotifierProvider =
    AsyncNotifierProvider<AssignOperatorNotifier, VendorOrder>(
      () => AssignOperatorNotifier(),
    );

// Schedule-related providers
final vendorCalendarProvider =
    FutureProvider.family<CalendarData, ({int year, int month})>((
      ref,
      params,
    ) async {
      final dataSource = ref.watch(vendorScheduleRemoteDataSourceProvider);
      return dataSource.getCalendarData(params.year, params.month);
    });

final vendorScheduledOrdersProvider =
    FutureProvider.family<
      List<VendorOrder>,
      ({DateTime? startDate, DateTime? endDate, String? status})
    >((ref, params) async {
      final dataSource = ref.watch(vendorScheduleRemoteDataSourceProvider);
      return dataSource.getScheduledOrders(
        startDate: params.startDate,
        endDate: params.endDate,
        status: params.status,
      );
    });
