import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/public_marketplace/data/datasources/public_marketplace_remote_data_source.dart';
import 'package:app/features/public_marketplace/data/repositories/public_marketplace_repository_impl.dart';
import 'package:app/features/public_marketplace/domain/repositories/public_marketplace_repository.dart';
import 'package:app/features/public_services/domain/entities/entities.dart';
import 'package:app/features/vendor-products/domain/entities/vendor_product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export '../../domain/repositories/public_marketplace_repository.dart'
    show PublicProductFilter, PublicProductFilterNotifier, publicProductFilterProvider;

final publicMarketplaceRemoteDataSourceProvider =
    Provider<PublicMarketplaceRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return PublicMarketplaceRemoteDataSourceImpl(dioClient);
    });

final publicMarketplaceRepositoryProvider =
    Provider<PublicMarketplaceRepository>((ref) {
      final remoteDataSource = ref.watch(
        publicMarketplaceRemoteDataSourceProvider,
      );
      return PublicMarketplaceRepositoryImpl(remoteDataSource);
    });

final publicProductDetailsProvider =
    FutureProvider.family<VendorProduct?, String>((ref, productId) async {
      final repository = ref.read(publicMarketplaceRepositoryProvider);
      return await repository.getProduct(productId);
    });

final marketplaceVendorsProvider =
    FutureProvider.family<List<PublicVendor>, String?>((
      ref,
      productType,
    ) async {
      final repository = ref.read(publicMarketplaceRepositoryProvider);
      return await repository.getVendorsByProductType(productType);
    });

final vendorProductsProvider =
    FutureProvider.family<List<VendorProduct>, String>((ref, vendorId) async {
      final filter = ref.watch(publicProductFilterProvider);
      final repository = ref.read(publicMarketplaceRepositoryProvider);
      return await repository.getVendorProducts(vendorId, filter: filter);
    });
