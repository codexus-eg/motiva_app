import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/vendor/data/datasources/vendor_remote_data_source.dart';
import 'package:app/features/vendor/data/repositories/vendor_repository_impl.dart';
import 'package:app/features/vendor/domain/entities/schedule_exception.dart';
import 'package:app/features/vendor/domain/entities/vendor_profile.dart';
import 'package:app/features/vendor/domain/entities/vendor_status.dart';
import 'package:app/features/vendor/domain/entities/working_hours.dart';
import 'package:app/features/vendor/domain/repositories/vendor_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final vendorRemoteDataSourceProvider = Provider<VendorRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return VendorRemoteDataSourceImpl(dioClient);
});

final vendorRepositoryProvider = Provider<VendorRepository>((ref) {
  final remoteDataSource = ref.watch(vendorRemoteDataSourceProvider);
  return VendorRepositoryImpl(remoteDataSource);
});

final vendorProfileProvider =
    AsyncNotifierProvider<VendorProfileNotifier, VendorProfile?>(() {
      return VendorProfileNotifier();
    });

class VendorProfileNotifier extends AsyncNotifier<VendorProfile?> {
  @override
  Future<VendorProfile?> build() async {
    return _fetchProfile();
  }

  Future<VendorProfile?> _fetchProfile() async {
    final repository = ref.read(vendorRepositoryProvider);
    return repository.getProfile();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchProfile());
  }

  Future<bool> updateProfile(UpdateVendorParams params) async {
    try {
      final repository = ref.read(vendorRepositoryProvider);
      final updatedProfile = await repository.updateProfile(params);
      state = AsyncValue.data(updatedProfile);
      return true;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to update profile',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<bool> updateLogo(String logoUrl) async {
    return updateProfile(UpdateVendorParams(logoUrl: logoUrl));
  }

  Future<bool> updateCoverImage(String coverImageUrl) async {
    return updateProfile(UpdateVendorParams(coverImageUrl: coverImageUrl));
  }

  Future<bool> updateAvailability(bool isAvailable) async {
    try {
      final repository = ref.read(vendorRepositoryProvider);
      final updatedProfile = await repository.updateAvailability(isAvailable);
      state = AsyncValue.data(updatedProfile);
      return true;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to update availability',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<bool> updateStatus(VendorStatus status) async {
    try {
      final repository = ref.read(vendorRepositoryProvider);
      final updatedProfile = await repository.updateStatus(status);

      final effectiveProfile = updatedProfile.status != status
          ? updatedProfile.copyWith(status: status)
          : updatedProfile;

      state = AsyncValue.data(effectiveProfile);
      return true;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to update status',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<bool> updateCapacity(int orderCapacity) async {
    try {
      final repository = ref.read(vendorRepositoryProvider);
      final updatedProfile = await repository.updateCapacity(orderCapacity);
      state = AsyncValue.data(updatedProfile);
      return true;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to update capacity',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<bool> updateWorkingHours(WorkingHours workingHours) async {
    try {
      final repository = ref.read(vendorRepositoryProvider);
      final updatedProfile = await repository.updateWorkingHours(workingHours);
      state = AsyncValue.data(updatedProfile);
      return true;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to update working hours',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }
}

final scheduleExceptionsProvider =
    AsyncNotifierProvider<ScheduleExceptionsNotifier, List<ScheduleException>>(
      () {
        return ScheduleExceptionsNotifier();
      },
    );

class ScheduleExceptionsNotifier
    extends AsyncNotifier<List<ScheduleException>> {
  @override
  Future<List<ScheduleException>> build() async {
    return _fetchScheduleExceptions();
  }

  Future<List<ScheduleException>> _fetchScheduleExceptions() async {
    final repository = ref.read(vendorRepositoryProvider);
    return repository.getScheduleExceptions();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchScheduleExceptions());
  }

  Future<bool> createScheduleException(
    CreateScheduleExceptionParams params,
  ) async {
    try {
      final repository = ref.read(vendorRepositoryProvider);
      final newException = await repository.createScheduleException(params);
      final currentList = state.value ?? [];
      state = AsyncValue.data([...currentList, newException]);
      return true;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to create schedule exception',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<bool> deleteScheduleException(String id) async {
    try {
      final repository = ref.read(vendorRepositoryProvider);
      await repository.deleteScheduleException(id);
      final currentList = state.value ?? [];
      state = AsyncValue.data(currentList.where((e) => e.id != id).toList());
      return true;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to delete schedule exception',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }
}
