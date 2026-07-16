import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/vendor-services/data/datasources/vendor_service_remote_data_source.dart';
import 'package:app/features/vendor-services/data/repositories/vendor_service_repository_impl.dart';
import 'package:app/features/vendor-services/domain/entities/vendor_service.dart';
import 'package:app/features/vendor-services/domain/repositories/vendor_service_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'vendor_services_state.dart';

final vendorServiceRemoteDataSourceProvider =
    Provider<VendorServiceRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return VendorServiceRemoteDataSourceImpl(dioClient);
    });

final vendorServiceRepositoryProvider = Provider<VendorServiceRepository>((
  ref,
) {
  final remoteDataSource = ref.watch(vendorServiceRemoteDataSourceProvider);
  return VendorServiceRepositoryImpl(remoteDataSource);
});

final vendorServicesNotifierProvider =
    AsyncNotifierProvider<VendorServicesNotifier, VendorServicesState>(() {
      return VendorServicesNotifier();
    });

class VendorServicesNotifier extends AsyncNotifier<VendorServicesState> {
  @override
  Future<VendorServicesState> build() async {
    return _fetchServices();
  }

  Future<VendorServicesState> _fetchServices() async {
    final repository = ref.read(vendorServiceRepositoryProvider);
    final services = await repository.getServices();
    final groupedServices = _groupByCategory(services);
    return VendorServicesState(
      services: services,
      groupedServices: groupedServices,
      isLoading: false,
    );
  }

  Map<String, List<VendorService>> _groupByCategory(
    List<VendorService> services,
  ) {
    final grouped = <String, List<VendorService>>{};
    for (final service in services) {
      grouped.putIfAbsent(service.categoryId, () => []).add(service);
    }
    return grouped;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchServices());
  }

  Future<bool> createService(CreateServiceParams params) async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(vendorServiceRepositoryProvider);
      await repository.createService(params);
      await refresh();
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('createService failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
      return false;
    }
  }

  Future<bool> updateService(String id, UpdateServiceParams params) async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(vendorServiceRepositoryProvider);
      await repository.updateService(id, params);
      await refresh();
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('updateService failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
      return false;
    }
  }

  Future<bool> archiveService(String id) async {
    try {
      final repository = ref.read(vendorServiceRepositoryProvider);
      await repository.archiveService(id);
      await refresh();
      return true;
    } catch (e, stackTrace) {
      AppLogger.error(
        'archiveService failed',
        error: e,
        stackTrace: stackTrace,
      );
      state = AsyncError(e, stackTrace);
      return false;
    }
  }

  Future<bool> restoreService(String id) async {
    try {
      final repository = ref.read(vendorServiceRepositoryProvider);
      await repository.restoreService(id);
      await refresh();
      return true;
    } catch (e, stackTrace) {
      AppLogger.error(
        'restoreService failed',
        error: e,
        stackTrace: stackTrace,
      );
      state = AsyncError(e, stackTrace);
      return false;
    }
  }
}

final vendorServiceByIdProvider = FutureProvider.family<VendorService?, String>(
  (ref, id) async {
    final state = ref.watch(vendorServicesNotifierProvider);
    return state.whenOrNull(
      data: (data) => data.services.where((s) => s.id == id).firstOrNull,
    );
  },
);
