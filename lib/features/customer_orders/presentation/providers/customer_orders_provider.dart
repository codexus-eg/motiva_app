import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/customer_orders_remote_data_source.dart';
import '../../data/models/customer_order_model.dart';
import '../../data/repositories/customer_orders_repository_impl.dart';
import '../../domain/entities/customer_order.dart';
import '../../domain/repositories/customer_orders_repository.dart';

final customerOrdersRemoteDataSourceProvider =
    Provider<CustomerOrdersRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return CustomerOrdersRemoteDataSourceImpl(dioClient);
    });

final customerOrdersRepositoryProvider = Provider<CustomerOrdersRepository>((
  ref,
) {
  final remoteDataSource = ref.watch(customerOrdersRemoteDataSourceProvider);
  return CustomerOrdersRepositoryImpl(remoteDataSource);
});

final customerOrdersProvider = FutureProvider<List<CustomerOrderModel>>((
  ref,
) async {
  final repository = ref.watch(customerOrdersRepositoryProvider);
  return repository.getCustomerOrders();
});

final pendingOrdersProvider = FutureProvider<List<CustomerOrder>>((ref) async {
  final orders = await ref.watch(customerOrdersProvider.future);
  return orders.where((o) => o.isPending).toList();
});

final activeOrdersProvider = FutureProvider<List<CustomerOrder>>((ref) async {
  final orders = await ref.watch(customerOrdersProvider.future);
  return orders.where((o) => o.isActive).toList();
});

final completedOrdersProvider = FutureProvider<List<CustomerOrder>>((
  ref,
) async {
  final orders = await ref.watch(customerOrdersProvider.future);
  return orders.where((o) => o.isCompleted).toList();
});

final cancelledOrdersProvider = FutureProvider<List<CustomerOrder>>((
  ref,
) async {
  final orders = await ref.watch(customerOrdersProvider.future);
  return orders.where((o) => o.isCancelled || o.isRejected).toList();
});

final activeOrdersPreviewProvider = FutureProvider<List<CustomerOrder>>((
  ref,
) async {
  final orders = await ref.watch(customerOrdersProvider.future);
  final activeOrders = orders.where((o) => o.isActive || o.isPending).toList();
  activeOrders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  return activeOrders.take(5).toList();
});

final customerOrderByIdProvider =
    FutureProvider.family<CustomerOrderModel, String>((ref, orderId) async {
      final repository = ref.watch(customerOrdersRepositoryProvider);
      return repository.getOrderById(orderId);
    });

class CreateOrderNotifier extends AsyncNotifier<CustomerOrderModel> {
  @override
  CustomerOrderModel build() {
    throw UnimplementedError();
  }

  Future<CustomerOrderModel> create(CreateOrderDto dto) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(customerOrdersRepositoryProvider);
    state = await AsyncValue.guard(() => repository.createOrder(dto));
    return state.value!;
  }
}

final createOrderNotifierProvider =
    AsyncNotifierProvider<CreateOrderNotifier, CustomerOrderModel>(
      () => CreateOrderNotifier(),
    );


