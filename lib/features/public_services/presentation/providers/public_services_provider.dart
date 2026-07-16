import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/public_services/data/data.dart';
import 'package:app/features/public_services/domain/entities/entities.dart';
import 'package:app/features/public_services/domain/repositories/public_services_repository.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final publicServicesRemoteDataSourceProvider =
    Provider<PublicServicesRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return PublicServicesRemoteDataSourceImpl(dioClient);
    });

final publicServicesRepositoryProvider = Provider<PublicServicesRepository>((
  ref,
) {
  final remoteDataSource = ref.watch(publicServicesRemoteDataSourceProvider);
  return PublicServicesRepositoryImpl(remoteDataSource);
});

final publicServiceCategoriesProvider =
    AsyncNotifierProvider<
      PublicServiceCategoriesNotifier,
      List<ServiceCategory>
    >(() {
      return PublicServiceCategoriesNotifier();
    });

class PublicServiceCategoriesNotifier
    extends AsyncNotifier<List<ServiceCategory>> {
  @override
  Future<List<ServiceCategory>> build() async {
    return _fetchCategories();
  }

  Future<List<ServiceCategory>> _fetchCategories() async {
    final repository = ref.read(publicServicesRepositoryProvider);
    return await repository.getServiceCategories();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchCategories());
  }
}

final categoryDetailsProvider =
    FutureProvider.family<ServiceCategoryWithSchema?, String>((
      ref,
      categoryId,
    ) async {
      final repository = ref.read(publicServicesRepositoryProvider);
      return await repository.getCategoryDetails(categoryId);
    });

final vendorsByCategoryProvider =
    FutureProvider.family<List<PublicVendor>, String>((ref, categoryId) async {
      final repository = ref.read(publicServicesRepositoryProvider);
      return await repository.getVendorsByCategory(categoryId);
    });

final vendorProfileProvider = FutureProvider.family<PublicVendor?, String>((
  ref,
  vendorId,
) async {
  final repository = ref.read(publicServicesRepositoryProvider);
  return await repository.getVendorProfile(vendorId);
});

class VendorServicesParams {
  final String? categoryId;
  final String? vendorId;

  const VendorServicesParams({this.categoryId, this.vendorId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VendorServicesParams &&
          runtimeType == other.runtimeType &&
          categoryId == other.categoryId &&
          vendorId == other.vendorId;

  @override
  int get hashCode => Object.hash(categoryId, vendorId);
}

final vendorServicesByParamsProvider =
    FutureProvider.family<List<PublicVendorService>, VendorServicesParams>((
      ref,
      params,
    ) async {
      final repository = ref.read(publicServicesRepositoryProvider);
      return await repository.getVendorServices(
        categoryId: params.categoryId,
        vendorId: params.vendorId,
      );
    });

final serviceDetailsProvider =
    FutureProvider.family<PublicVendorService?, String>((ref, serviceId) async {
      final repository = ref.read(publicServicesRepositoryProvider);
      return await repository.getServiceDetails(serviceId);
    });
