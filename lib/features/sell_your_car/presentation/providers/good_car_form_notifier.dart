import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/sell_your_car/data/data.dart';
import 'package:app/features/sell_your_car/domain/domain.dart';
import 'package:app/core/utils/app_logger.dart';
import 'good_car_form_state.dart';
import 'create_listing_state.dart';

class GoodCarFormNotifier extends StateNotifier<GoodCarFormState> {
  GoodCarFormNotifier() : super(const GoodCarFormState());

  void setMake(String id, String name) {
    AppLogger.debug('Setting make: $name ($id)');
    state = state.copyWith(
      selectedMakeId: id,
      selectedMakeName: name,
      selectedModelId: null,
      selectedModelName: null,
      selectedTrimId: null,
      selectedTrimName: null,
      selectedYear: null,
    );
    _validateForm();
  }

  void setModel(String id, String name) {
    AppLogger.debug('Setting model: $name ($id)');
    state = state.copyWith(
      selectedModelId: id,
      selectedModelName: name,
      selectedTrimId: null,
      selectedTrimName: null,
      selectedYear: null,
    );
    _validateForm();
  }

  void setTrim(String id, String name) {
    AppLogger.debug('Setting trim: $name ($id)');
    state = state.copyWith(selectedTrimId: id, selectedTrimName: name);
    _validateForm();
  }

  void setYear(int year) {
    AppLogger.debug('Setting year: $year');
    state = state.copyWith(selectedYear: year);
    _validateForm();
  }

  void setMileage(int mileage) {
    AppLogger.debug('Setting mileage: $mileage');
    state = state.copyWith(mileage: mileage);
    _validateForm();
  }

  void setSellingPrice(double price) {
    AppLogger.debug('Setting selling price: $price');
    state = state.copyWith(sellingPrice: price);
    _validateForm();
  }

  void setTransmission(String transmission) {
    AppLogger.debug('Setting transmission: $transmission');
    state = state.copyWith(transmission: transmission);
    _validateForm();
  }

  void setEngineSize(String engineSize) {
    AppLogger.debug('Setting engine size: $engineSize');
    state = state.copyWith(engineSize: engineSize);
    _validateForm();
  }

  void setColor(String color) {
    AppLogger.debug('Setting color: $color');
    state = state.copyWith(color: color);
    _validateForm();
  }

  void addImage(String imageUrl) {
    AppLogger.debug('Adding image to form state: $imageUrl');
    final images = List<String>.from(state.images)..add(imageUrl);
    AppLogger.debug('Images after adding: $images');
    state = state.copyWith(images: images);
    _validateForm();
  }

  void removeImage(int index) {
    final images = List<String>.from(state.images)..removeAt(index);
    state = state.copyWith(images: images);
    _validateForm();
  }

  void setDescription(String description) {
    state = state.copyWith(description: description);
  }

  /// Set the selected listing plan ID (the plan the user picked for visibility).
  /// Pass null to clear the selection.
  void setSelectedPlanId(String? value) {
    state = state.copyWith(selectedPlanId: value);
  }

  void reset() {
    state = const GoodCarFormState();
  }

  void _validateForm() {
    final isValid =
        state.selectedMakeId != null &&
        state.selectedModelId != null &&
        state.selectedYear != null &&
        state.mileage != null &&
        state.sellingPrice != null &&
        state.transmission != null &&
        state.engineSize != null &&
        state.color != null;

    AppLogger.debug('Form validation:');
    AppLogger.debug('  make: ${state.selectedMakeName} (${state.selectedMakeId})');
    AppLogger.debug('  model: ${state.selectedModelName} (${state.selectedModelId})');
    AppLogger.debug('  year: ${state.selectedYear}');
    AppLogger.debug('  mileage: ${state.mileage}');
    AppLogger.debug('  sellingPrice: ${state.sellingPrice}');
    AppLogger.debug('  transmission: ${state.transmission}');
    AppLogger.debug('  engineSize: ${state.engineSize}');
    AppLogger.debug('  color: ${state.color}');
    AppLogger.debug('  isValid: $isValid');

    state = state.copyWith(isValid: isValid);
  }
}

final goodCarFormNotifierProvider =
    StateNotifierProvider<GoodCarFormNotifier, GoodCarFormState>(
      (ref) => GoodCarFormNotifier(),
    );

class CreateListingNotifier extends AsyncNotifier<CreateListingState> {
  @override
  CreateListingState build() {
    return const CreateListingInitial();
  }

  Future<void> submitDraft(GoodCarFormState form) async {
    AppLogger.debug('=== SUBMIT DRAFT CALLED ===');
    AppLogger.debug('Form valid: ${form.isValid}');
    AppLogger.debug('Missing fields: ${form.getMissingFields()}');

    if (!form.isValid) {
      final missingFields = form.getMissingFields();
      AppLogger.debug('Form is NOT valid. Missing: ${missingFields.join(', ')}');
      state = AsyncData(
        CreateListingError(
          'Please complete the following fields: ${missingFields.join(', ')}',
        ),
      );
      return;
    }

    state = const AsyncLoading();

    try {
      final repository = ref.read(carMarketplaceRepositoryProvider);

      final request = CreateListingRequest(
        make: form.selectedMakeName!,
        model: form.selectedModelName!,
        year: form.selectedYear!,
        mileage: form.mileage!,
        askingPrice: form.sellingPrice,
        transmission: form.transmission,
        engineSize: form.engineSize,
        color: form.color,
        images: form.images,
        description: form.description,
        conditionStatus: 'GOOD',
        listingType: 'REGULAR',
        selectedPlanId: form.selectedPlanId,
      );

      final listing = await repository.createDraftListing(request);
      state = AsyncData(CreateListingSuccess(listing.id));
    } catch (e, stackTrace) {
      AppLogger.error('submitDraft failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> publishDraft(String listingId) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(carMarketplaceRepositoryProvider);
      await repository.publishListing(listingId);
      state = AsyncData(CreateListingSuccess(listingId));
    } catch (e, stackTrace) {
      AppLogger.error('publishDraft failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
    }
  }

  void reset() {
    state = const AsyncData(CreateListingInitial());
  }
}

final createListingNotifierProvider =
    AsyncNotifierProvider<CreateListingNotifier, CreateListingState>(
      CreateListingNotifier.new,
    );

final carMarketplaceRemoteDataSourceProvider =
    Provider<CarMarketplaceRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return CarMarketplaceRemoteDataSourceImpl(dioClient);
    });

final carMarketplaceRepositoryProvider = Provider<CarMarketplaceRepository>((
  ref,
) {
  final remoteDataSource = ref.watch(carMarketplaceRemoteDataSourceProvider);
  return CarMarketplaceRepositoryImpl(remoteDataSource);
});
