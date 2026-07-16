import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/checkout_orders_remote_data_source.dart';
import '../../data/repositories/checkout_orders_repository_impl.dart';
import '../../domain/entities/checkout_order.dart';
import '../../domain/entities/checkout_order_detail.dart';
import '../../domain/repositories/checkout_orders_repository.dart';

final checkoutOrdersRemoteDataSourceProvider =
    Provider<CheckoutOrdersRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return CheckoutOrdersRemoteDataSourceImpl(dioClient);
    });

final checkoutOrdersRepositoryProvider = Provider<CheckoutOrdersRepository>((ref) {
  final remoteDataSource = ref.watch(checkoutOrdersRemoteDataSourceProvider);
  return CheckoutOrdersRepositoryImpl(remoteDataSource);
});

final checkoutOrdersProvider = FutureProvider<List<CheckoutOrder>>((ref) async {
  final repository = ref.watch(checkoutOrdersRepositoryProvider);
  final orders = await repository.getMyOrders();
  debugPrint('CheckoutOrders: Fetched ${orders.length} orders');
  for (final order in orders) {
    debugPrint(
      '  Order: ${order.orderNumber} - status: ${order.status} - amount: ${order.totalAmount}',
    );
  }
  return orders;
});

final checkoutOrderDetailProvider =
    FutureProvider.family<CheckoutOrderDetail, String>((ref, orderId) async {
      final repository = ref.watch(checkoutOrdersRepositoryProvider);
      return repository.getOrderById(orderId);
    });
