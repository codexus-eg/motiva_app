import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/sell_your_car/domain/domain.dart';
import 'create_listing_state.dart';
import 'damaged_car_form_state.dart';
import 'good_car_form_state.dart';
import 'good_car_form_notifier.dart';

class FastTrackCreateListingNotifier extends AsyncNotifier<CreateListingState> {
  @override
  CreateListingState build() {
    return const CreateListingInitial();
  }

  Future<void> submitDraft(GoodCarFormState form) async {
    AppLogger.debug('=== FAST TRACK SUBMIT DRAFT CALLED ===');
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

      final request = CreateFastTrackRequest(
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
      );

      final listing = await repository.createFastTrackListing(request);
      state = AsyncData(CreateListingSuccess(listing.id));
    } catch (e, stackTrace) {
      AppLogger.error('FastTrack submitDraft failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
    }
  }

  void reset() {
    state = const AsyncData(CreateListingInitial());
  }
}

class FastTrackDamagedCreateListingNotifier
    extends AsyncNotifier<CreateListingState> {
  @override
  CreateListingState build() {
    return const CreateListingInitial();
  }

  Future<void> submitDraft(DamagedCarFormState form) async {
    AppLogger.debug('=== FAST TRACK DAMAGED SUBMIT DRAFT CALLED ===');
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

      final request = CreateFastTrackRequest(
        make: form.selectedMakeName!,
        model: form.selectedModelName!,
        year: form.selectedYear!,
        mileage: form.mileage!,
        askingPrice: form.sellingPrice,
        transmission: form.transmission,
        engineSize: form.engineSize,
        color: form.color,
        images: form.images,
        damageImages: form.damageImages.isNotEmpty ? form.damageImages : null,
        description: form.description,
        conditionStatus: 'DAMAGED',
        conditionReport: form.toConditionReport(),
        inspectionReportUrl: form.inspectionReportUrl,
      );

      final listing = await repository.createFastTrackListing(request);
      state = AsyncData(CreateListingSuccess(listing.id));
    } catch (e, stackTrace) {
      AppLogger.error('FastTrackDamaged submitDraft failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
    }
  }

  void reset() {
    state = const AsyncData(CreateListingInitial());
  }
}

class FastTrackSettingsNotifier extends AsyncNotifier<FastTrackSettings> {
  @override
  FastTrackSettings build() {
    return const FastTrackSettings(options: []);
  }

  Future<void> fetchSettings() async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(carMarketplaceRepositoryProvider);
      final settings = await repository.getFastTrackSettings();
      state = AsyncData(settings);
    } catch (e, stackTrace) {
      AppLogger.error('FastTrackSettings fetchSettings failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
    }
  }
}

final fastTrackCreateListingNotifierProvider =
    AsyncNotifierProvider<FastTrackCreateListingNotifier, CreateListingState>(
      FastTrackCreateListingNotifier.new,
    );

final fastTrackDamagedCreateListingNotifierProvider =
    AsyncNotifierProvider<FastTrackDamagedCreateListingNotifier, CreateListingState>(
      FastTrackDamagedCreateListingNotifier.new,
    );

final fastTrackSettingsNotifierProvider =
    AsyncNotifierProvider<FastTrackSettingsNotifier, FastTrackSettings>(
      FastTrackSettingsNotifier.new,
    );

class ListingPlansNotifier extends AsyncNotifier<ListingPlansResponse> {
  @override
  Future<ListingPlansResponse> build() async {
    return _fetch();
  }

  Future<ListingPlansResponse> _fetch() async {
    try {
      final repository = ref.read(carMarketplaceRepositoryProvider);
      final response = await repository.getListingPlans();
      return response;
    } catch (e, stackTrace) {
      AppLogger.error('ListingPlans fetch failed', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(carMarketplaceRepositoryProvider);
      final response = await repository.getListingPlans();
      state = AsyncData(response);
    } catch (e, stackTrace) {
      AppLogger.error('ListingPlans refresh failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
    }
  }
}

final listingPlansNotifierProvider =
    AsyncNotifierProvider<ListingPlansNotifier, ListingPlansResponse>(
      ListingPlansNotifier.new,
    );