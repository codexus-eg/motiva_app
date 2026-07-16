import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/cart_remote_data_source.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../../domain/entities/cart.dart';
import '../../domain/repositories/cart_repository.dart';

final cartRemoteDataSourceProvider = Provider<CartRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return CartRemoteDataSourceImpl(dioClient);
});

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  final remoteDataSource = ref.watch(cartRemoteDataSourceProvider);
  return CartRepositoryImpl(remoteDataSource);
});

final cartProvider = FutureProvider<Cart>((ref) async {
  final repository = ref.watch(cartRepositoryProvider);
  final cart = await repository.getCart();
  debugPrint('Cart: Fetched ${cart.items.length} items');
  return cart;
});

class AddCartItemNotifier extends AsyncNotifier<Cart> {
  @override
  Cart build() {
    throw UnimplementedError();
  }

  Future<Cart> addItem(String productId, int quantity) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(cartRepositoryProvider);
    state = await AsyncValue.guard(
      () => repository.addItem(productId: productId, quantity: quantity),
    );
    ref.invalidate(cartProvider);
    return state.value!;
  }
}

final addCartItemNotifierProvider = AsyncNotifierProvider<AddCartItemNotifier, Cart>(
  () => AddCartItemNotifier(),
);

class UpdateCartItemNotifier extends AsyncNotifier<Cart> {
  @override
  Cart build() {
    throw UnimplementedError();
  }

  Future<Cart> updateItem(String itemId, int quantity) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(cartRepositoryProvider);
    state = await AsyncValue.guard(
      () => repository.updateItem(itemId: itemId, quantity: quantity),
    );
    ref.invalidate(cartProvider);
    return state.value!;
  }
}

final updateCartItemNotifierProvider = AsyncNotifierProvider<UpdateCartItemNotifier, Cart>(
  () => UpdateCartItemNotifier(),
);

class RemoveCartItemNotifier extends AsyncNotifier<Cart> {
  @override
  Cart build() {
    throw UnimplementedError();
  }

  Future<Cart> removeItem(String itemId) async {
    state = const AsyncValue.loading();
    final repository = ref.watch(cartRepositoryProvider);
    state = await AsyncValue.guard(() => repository.removeItem(itemId: itemId));
    ref.invalidate(cartProvider);
    return state.value!;
  }
}

final removeCartItemNotifierProvider = AsyncNotifierProvider<RemoveCartItemNotifier, Cart>(
  () => RemoveCartItemNotifier(),
);

class ClearCartNotifier extends AsyncNotifier<Cart> {
  @override
  Cart build() {
    throw UnimplementedError();
  }

  Future<Cart> clearCart() async {
    state = const AsyncValue.loading();
    final repository = ref.watch(cartRepositoryProvider);
    state = await AsyncValue.guard(() => repository.clearCart());
    ref.invalidate(cartProvider);
    return state.value!;
  }
}

final clearCartNotifierProvider = AsyncNotifierProvider<ClearCartNotifier, Cart>(
  () => ClearCartNotifier(),
);
