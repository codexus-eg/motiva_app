import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/vendor-cars/data/datasources/vendor_car_remote_data_source.dart';
import 'package:app/features/vendor-cars/data/repositories/vendor_car_repository_impl.dart';
import 'package:app/features/vendor-cars/domain/entities/vendor_car.dart';
import 'package:app/features/vendor-cars/domain/repositories/vendor_car_repository.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'vendor_cars_state.dart';

final vendorCarRemoteDataSourceProvider = Provider<VendorCarRemoteDataSource>((
  ref,
) {
  final dioClient = ref.watch(dioClientProvider);
  return VendorCarRemoteDataSourceImpl(dioClient);
});

final vendorCarRepositoryProvider = Provider<VendorCarRepository>((ref) {
  final remoteDataSource = ref.watch(vendorCarRemoteDataSourceProvider);
  return VendorCarRepositoryImpl(remoteDataSource);
});

final vendorCarsNotifierProvider =
    AsyncNotifierProvider<VendorCarsNotifier, VendorCarsState>(() {
      return VendorCarsNotifier();
    });

class VendorCarsNotifier extends AsyncNotifier<VendorCarsState> {
  @override
  Future<VendorCarsState> build() async {
    return _fetchCars([]);
  }

  Future<VendorCarsState> _fetchCars(List<VendorCar> previousCars) async {
    final repository = ref.read(vendorCarRepositoryProvider);
    final cars = await repository.getCars();

    final existingMap = {for (var c in previousCars) c.id: c};
    final merged = cars.map((c) => _mergeCar(c, existingMap[c.id])).toList();

    return VendorCarsState(cars: merged, isLoading: false);
  }

  Future<void> refresh() async {
    final previousCars = state.valueOrNull?.cars ?? [];
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return _fetchCars(previousCars);
    });
  }

  VendorCar _mergeCar(VendorCar fetched, VendorCar? existing) {
    if (existing == null) return fetched;
    return fetched.copyWith(
      images: fetched.images.isNotEmpty ? fetched.images : existing.images,
    );
  }

  Future<bool> createCar(CreateCarParams params) async {
    try {
      final repository = ref.read(vendorCarRepositoryProvider);
      final newCar = await repository.createCar(params);

      // Optimistically append to current list
      state = state.whenData(
        (current) =>
            VendorCarsState(cars: [...current.cars, newCar], isLoading: false),
      );

      return true;
    } catch (e, stackTrace) {
      AppLogger.error('createCar failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
      return false;
    }
  }

  Future<bool> updateCar(String id, UpdateCarParams params) async {
    try {
      final repository = ref.read(vendorCarRepositoryProvider);
      final updatedCar = await repository.updateCar(id, params);

      // Optimistically replace in current list
      state = state.whenData((current) {
        final existing = current.cars.where((c) => c.id == id).firstOrNull;
        return VendorCarsState(
          cars: current.cars.map((c) {
            return c.id == id ? _mergeCar(updatedCar, existing) : c;
          }).toList(),
          isLoading: false,
        );
      });

      return true;
    } catch (e, stackTrace) {
      AppLogger.error('updateCar failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
      return false;
    }
  }

  Future<bool> deleteCar(String id) async {
    try {
      final repository = ref.read(vendorCarRepositoryProvider);
      await repository.deleteCar(id);

      // Optimistically remove from current list
      state = state.whenData(
        (current) => VendorCarsState(
          cars: current.cars.where((c) => c.id != id).toList(),
          isLoading: false,
        ),
      );

      return true;
    } catch (e, stackTrace) {
      AppLogger.error('deleteCar failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
      return false;
    }
  }
}

final vendorCarByIdProvider = FutureProvider.family<VendorCar?, String>((
  ref,
  id,
) async {
  final state = ref.watch(vendorCarsNotifierProvider);
  return state.whenOrNull(
    data: (data) => data.cars.where((c) => c.id == id).firstOrNull,
  );
});
