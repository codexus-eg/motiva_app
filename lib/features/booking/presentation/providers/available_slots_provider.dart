import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/available_slots_remote_data_source.dart';
import '../../data/repositories/available_slots_repository_impl.dart';
import '../../domain/failures/available_slots_failure.dart';
import '../../domain/repositories/available_slots_repository.dart';
import '../../../../features/auth/presentation/providers/auth_providers.dart';

final availableSlotsDataSourceProvider =
    Provider<AvailableSlotsRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return AvailableSlotsRemoteDataSource(dioClient);
    });

final availableSlotsRepositoryProvider = Provider<AvailableSlotsRepository>((
  ref,
) {
  final dataSource = ref.watch(availableSlotsDataSourceProvider);
  return AvailableSlotsRepositoryImpl(dataSource);
});

class AvailableSlotsState {
  final List<String> availableSlots;
  final bool isLoading;
  final String? error;
  final DateTime? selectedDate;
  final String? vendorServiceId;

  const AvailableSlotsState({
    this.availableSlots = const [],
    this.isLoading = false,
    this.error,
    this.selectedDate,
    this.vendorServiceId,
  });

  AvailableSlotsState copyWith({
    List<String>? availableSlots,
    bool? isLoading,
    String? error,
    DateTime? selectedDate,
    String? vendorServiceId,
    bool clearError = false,
  }) {
    return AvailableSlotsState(
      availableSlots: availableSlots ?? this.availableSlots,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      selectedDate: selectedDate ?? this.selectedDate,
      vendorServiceId: vendorServiceId ?? this.vendorServiceId,
    );
  }
}

class AvailableSlotsNotifier extends StateNotifier<AvailableSlotsState> {
  final Ref _ref;

  AvailableSlotsNotifier(this._ref) : super(const AvailableSlotsState());

  Future<void> fetchAvailableSlots({
    required String vendorServiceId,
    required DateTime date,
  }) async {
    // Don't refetch if same date and service
    if (state.selectedDate != null &&
        state.vendorServiceId == vendorServiceId &&
        _isSameDay(state.selectedDate!, date) &&
        state.availableSlots.isNotEmpty) {
      return;
    }

    state = state.copyWith(
      isLoading: true,
      clearError: true,
      selectedDate: date,
      vendorServiceId: vendorServiceId,
    );

    try {
      final repository = _ref.read(availableSlotsRepositoryProvider);
      final result = await repository.getAvailableSlots(
        vendorServiceId: vendorServiceId,
        date: date,
      );

      // Get available time slots from the entity
      final slots = result.availableTimes;

      debugPrint('Fetched ${slots.length} available slots for $date');

      state = state.copyWith(
        availableSlots: slots,
        isLoading: false,
        clearError: true,
      );
    } on AvailableSlotsFailure catch (e) {
      debugPrint('AvailableSlotsFailure: $e');
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      debugPrint('Error fetching slots: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load available time slots. Please try again.',
      );
    }
  }

  void clear() {
    state = const AvailableSlotsState();
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Check if a specific time slot is available
  bool isSlotAvailable(String timeSlot) {
    return state.availableSlots.contains(timeSlot);
  }
}

final availableSlotsProvider =
    StateNotifierProvider<AvailableSlotsNotifier, AvailableSlotsState>((ref) {
      return AvailableSlotsNotifier(ref);
    });
