import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/vendor-products/data/datasources/vendor_product_remote_data_source.dart';
import 'package:app/features/vendor-products/data/repositories/vendor_product_repository_impl.dart';
import 'package:app/features/vendor-products/domain/entities/vendor_product.dart';
import 'package:app/features/vendor-products/domain/repositories/vendor_product_repository.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/vendor/presentation/providers/vendor_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'vendor_products_state.dart';

final vendorProductRemoteDataSourceProvider =
    Provider<VendorProductRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return VendorProductRemoteDataSourceImpl(dioClient);
    });

final vendorProductRepositoryProvider = Provider<VendorProductRepository>((
  ref,
) {
  final remoteDataSource = ref.watch(vendorProductRemoteDataSourceProvider);
  return VendorProductRepositoryImpl(remoteDataSource);
});

final vendorProductsNotifierProvider =
    AsyncNotifierProvider<VendorProductsNotifier, VendorProductsState>(() {
      return VendorProductsNotifier();
    });

class VendorProductsNotifier extends AsyncNotifier<VendorProductsState> {
  @override
  Future<VendorProductsState> build() async {
    final profile = await ref.watch(vendorProfileProvider.future);
    final vendorId = profile?.userId ?? '';
    if (vendorId.isEmpty) {
      return const VendorProductsState(products: [], isLoading: false);
    }
    return _fetchProducts(vendorId, []);
  }

  Future<VendorProductsState> _fetchProducts(
    String vendorId,
    List<VendorProduct> previousProducts,
  ) async {
    final repository = ref.read(vendorProductRepositoryProvider);
    final products = await repository.getProducts(vendorId);

    final existingMap = {for (var p in previousProducts) p.id: p};
    final merged = products
        .map((p) => _mergeProduct(p, existingMap[p.id]))
        .toList();

    return VendorProductsState(products: merged, isLoading: false);
  }

  Future<void> refresh() async {
    final previousProducts = state.valueOrNull?.products ?? [];
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final profile = await ref.read(vendorProfileProvider.future);
      final vendorId = profile?.userId ?? '';
      if (vendorId.isEmpty) {
        return const VendorProductsState(products: []);
      }
      return _fetchProducts(vendorId, previousProducts);
    });
  }

  VendorProduct _mergeProduct(VendorProduct fetched, VendorProduct? existing) {
    if (existing == null) return fetched;
    return fetched.copyWith(
      images: fetched.images.isNotEmpty ? fetched.images : existing.images,
      description: fetched.description?.isNotEmpty == true
          ? fetched.description
          : existing.description,
      categoryId: fetched.categoryId ?? existing.categoryId,
    );
  }

  Future<bool> createProduct(CreateProductParams params) async {
    try {
      final repository = ref.read(vendorProductRepositoryProvider);
      final newProduct = await repository.createProduct(params);

      // Optimistically append to current list
      state = state.whenData(
        (current) => VendorProductsState(
          products: [...current.products, newProduct],
          isLoading: false,
        ),
      );

      return true;
    } catch (e, stackTrace) {
      AppLogger.error('createProduct failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
      return false;
    }
  }

  Future<bool> updateProduct(String id, UpdateProductParams params) async {
    try {
      final repository = ref.read(vendorProductRepositoryProvider);
      final updatedProduct = await repository.updateProduct(id, params);

      // Optimistically replace in current list
      state = state.whenData((current) {
        final existing = current.products.where((p) => p.id == id).firstOrNull;
        return VendorProductsState(
          products: current.products.map((p) {
            return p.id == id ? _mergeProduct(updatedProduct, existing) : p;
          }).toList(),
          isLoading: false,
        );
      });

      return true;
    } catch (e, stackTrace) {
      AppLogger.error('updateProduct failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      final repository = ref.read(vendorProductRepositoryProvider);
      await repository.deleteProduct(id);

      // Optimistically remove from current list
      state = state.whenData(
        (current) => VendorProductsState(
          products: current.products.where((p) => p.id != id).toList(),
          isLoading: false,
        ),
      );

      return true;
    } catch (e, stackTrace) {
      AppLogger.error('deleteProduct failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
      return false;
    }
  }

  Future<bool> toggleProductActive(String id) async {
    try {
      final repository = ref.read(vendorProductRepositoryProvider);
      final toggledProduct = await repository.toggleProductActive(id);

      // Optimistically update in current list
      state = state.whenData((current) {
        final existing = current.products.where((p) => p.id == id).firstOrNull;
        return VendorProductsState(
          products: current.products.map((p) {
            return p.id == id ? _mergeProduct(toggledProduct, existing) : p;
          }).toList(),
          isLoading: false,
        );
      });

      return true;
    } catch (e, stackTrace) {
      AppLogger.error(
        'toggleProductActive failed',
        error: e,
        stackTrace: stackTrace,
      );
      state = AsyncError(e, stackTrace);
      return false;
    }
  }
}

final vendorProductByIdProvider = FutureProvider.family<VendorProduct?, String>(
  (ref, id) async {
    final state = ref.watch(vendorProductsNotifierProvider);
    return state.whenOrNull(
      data: (data) => data.products.where((p) => p.id == id).firstOrNull,
    );
  },
);
