import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/sell_your_car/domain/entities/entities.dart';
import 'package:app/features/sell_your_car/domain/repositories/car_marketplace_repository.dart';
import 'package:app/features/sell_your_car/presentation/providers/providers.dart';

class EditSpecsState {
  final String? selectedMakeId;
  final String? selectedMakeName;
  final String? selectedModelId;
  final String? selectedModelName;
  final String? selectedTrimId;
  final String? selectedTrimName;
  final int? selectedYear;
  final int? mileage;
  final String? transmission;
  final String? color;
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  const EditSpecsState({
    this.selectedMakeId,
    this.selectedMakeName,
    this.selectedModelId,
    this.selectedModelName,
    this.selectedTrimId,
    this.selectedTrimName,
    this.selectedYear,
    this.mileage,
    this.transmission,
    this.color,
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  EditSpecsState copyWith({
    String? selectedMakeId,
    String? selectedMakeName,
    String? selectedModelId,
    String? selectedModelName,
    String? selectedTrimId,
    String? selectedTrimName,
    int? selectedYear,
    int? mileage,
    String? transmission,
    String? color,
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return EditSpecsState(
      selectedMakeId: selectedMakeId ?? this.selectedMakeId,
      selectedMakeName: selectedMakeName ?? this.selectedMakeName,
      selectedModelId: selectedModelId ?? this.selectedModelId,
      selectedModelName: selectedModelName ?? this.selectedModelName,
      selectedTrimId: selectedTrimId ?? this.selectedTrimId,
      selectedTrimName: selectedTrimName ?? this.selectedTrimName,
      selectedYear: selectedYear ?? this.selectedYear,
      mileage: mileage ?? this.mileage,
      transmission: transmission ?? this.transmission,
      color: color ?? this.color,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  bool get isValid {
    return selectedMakeId != null &&
        selectedModelId != null &&
        selectedYear != null &&
        mileage != null &&
        transmission != null &&
        color != null;
  }
}

class EditSpecsNotifier extends StateNotifier<EditSpecsState> {
  final Ref _ref;

  EditSpecsNotifier(this._ref) : super(const EditSpecsState());

  void initializeFromListing(CarListing listing) {
    AppLogger.debug('Initializing EditSpecsState from listing: ${listing.id}');
    state = EditSpecsState(
      selectedMakeName: listing.make,
      selectedModelName: listing.model,
      selectedTrimName: listing.trim,
      selectedYear: listing.year,
      mileage: listing.mileage,
      transmission: listing.transmission?.name.toUpperCase(),
      color: listing.color,
    );
  }

  void setMake(String id, String name) {
    AppLogger.debug('Setting make: $name ($id)');
    state = state.copyWith(
      selectedMakeId: id,
      selectedMakeName: name,
      selectedModelId: null,
      selectedModelName: null,
      selectedTrimId: null,
      selectedTrimName: null,
    );
  }

  void setModel(String id, String name) {
    AppLogger.debug('Setting model: $name ($id)');
    state = state.copyWith(
      selectedModelId: id,
      selectedModelName: name,
      selectedTrimId: null,
      selectedTrimName: null,
    );
  }

  void setTrim(String id, String name) {
    AppLogger.debug('Setting trim: $name ($id)');
    state = state.copyWith(selectedTrimId: id, selectedTrimName: name);
  }

  void setYear(int year) {
    AppLogger.debug('Setting year: $year');
    state = state.copyWith(selectedYear: year);
  }

  void setMileage(int mileage) {
    AppLogger.debug('Setting mileage: $mileage');
    state = state.copyWith(mileage: mileage);
  }

  void setTransmission(String transmission) {
    AppLogger.debug('Setting transmission: $transmission');
    state = state.copyWith(transmission: transmission);
  }

  void setColor(String color) {
    AppLogger.debug('Setting color: $color');
    state = state.copyWith(color: color);
  }

  Future<void> updateSpecs(String listingId) async {
    if (!state.isValid) {
      AppLogger.debug('Form is not valid, cannot update specs');
      state = state.copyWith(error: 'Please complete all fields');
      return;
    }

    AppLogger.debug('Updating specs for listing: $listingId');
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

    try {
      final repository = _ref.read(carMarketplaceRepositoryProvider);

      final request = UpdateListingRequest(
        make: state.selectedMakeName,
        model: state.selectedModelName,
        year: state.selectedYear,
        mileage: state.mileage,
        transmission: state.transmission,
        trim: state.selectedTrimName,
        color: state.color,
      );

      await repository.updateListing(listingId, request);

      AppLogger.debug('Specs updated successfully for listing: $listingId');
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e, stackTrace) {
      AppLogger.error('updateSpecs failed', error: e, stackTrace: stackTrace);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        isSuccess: false,
      );
    }
  }

  void reset() {
    state = const EditSpecsState();
  }
}

final editSpecsNotifierProvider =
    StateNotifierProvider<EditSpecsNotifier, EditSpecsState>((ref) {
      return EditSpecsNotifier(ref);
    });
