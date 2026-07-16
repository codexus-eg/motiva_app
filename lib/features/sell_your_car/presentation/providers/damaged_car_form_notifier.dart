import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/sell_your_car/domain/domain.dart';
import 'package:app/core/utils/app_logger.dart';
import 'damaged_car_form_state.dart';
import 'create_listing_state.dart';
import 'good_car_form_notifier.dart';

class DamagedCarFormNotifier extends StateNotifier<DamagedCarFormState> {
  DamagedCarFormNotifier() : super(const DamagedCarFormState());

  void setMake(String id, String name) {
    AppLogger.debug('DamagedCar: Setting make: $name ($id)');
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
    AppLogger.debug('DamagedCar: Setting model: $name ($id)');
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
    AppLogger.debug('DamagedCar: Setting trim: $name ($id)');
    state = state.copyWith(selectedTrimId: id, selectedTrimName: name);
    _validateForm();
  }

  void setYear(int year) {
    AppLogger.debug('DamagedCar: Setting year: $year');
    state = state.copyWith(selectedYear: year);
    _validateForm();
  }

  void setMileage(int mileage) {
    AppLogger.debug('DamagedCar: Setting mileage: $mileage');
    state = state.copyWith(mileage: mileage);
    _validateForm();
  }

  void setSellingPrice(double price) {
    AppLogger.debug('DamagedCar: Setting selling price: $price');
    state = state.copyWith(sellingPrice: price);
    _validateForm();
  }

  void setTransmission(String transmission) {
    final upperTransmission = transmission.toUpperCase();
    AppLogger.debug('DamagedCar: Setting transmission: $upperTransmission');
    state = state.copyWith(transmission: upperTransmission);
    _validateForm();
  }

  void setEngineSize(String engineSize) {
    AppLogger.debug('DamagedCar: Setting engine size: $engineSize');
    state = state.copyWith(engineSize: engineSize);
    _validateForm();
  }

  void setPaintCondition(String condition) {
    AppLogger.debug('DamagedCar: Setting paint condition: $condition');
    state = state.copyWith(paintCondition: condition);
    _validateForm();
  }

  void setBodyPanelDamage(String damage) {
    AppLogger.debug('DamagedCar: Setting body panel damage: $damage');
    state = state.copyWith(bodyPanelDamage: damage);
    _validateForm();
  }

  void setInspectionReportUrl(String url) {
    AppLogger.debug('DamagedCar: Setting inspection report URL: $url');
    state = state.copyWith(inspectionReportUrl: url);
    _validateForm();
  }

  void setWantsInspection(bool value) {
    AppLogger.debug('DamagedCar: Setting wants inspection: $value');
    state = state.copyWith(wantsInspection: value);
  }

  void setChassisIssues(String value) {
    AppLogger.debug('DamagedCar: Setting chassis issues: $value');
    state = state.copyWith(chassisIssues: value);
    _validateForm();
  }

  void setMechanicalIssues(String value) {
    AppLogger.debug('DamagedCar: Setting mechanical issues: $value');
    state = state.copyWith(mechanicalIssues: value);
    _validateForm();
  }

  void setWarningLights(String value) {
    AppLogger.debug('DamagedCar: Setting warning lights: $value');
    state = state.copyWith(warningLights: value);
    _validateForm();
  }

  void setTiresCondition(String condition) {
    state = state.copyWith(tiresCondition: condition);
    _validateForm();
  }

  void setRunsAndDrives(bool value) {
    state = state.copyWith(runsAndDrives: value);
    _validateForm();
  }

  void setColor(String color) {
    AppLogger.debug('DamagedCar: Setting color: $color');
    state = state.copyWith(color: color);
    _validateForm();
  }

  void addImage(String imageUrl) {
    AppLogger.debug('DamagedCar: Adding image to form state: $imageUrl');
    final images = List<String>.from(state.images)..add(imageUrl);
    AppLogger.debug('DamagedCar: Images after adding: $images');
    state = state.copyWith(images: images);
    _validateForm();
  }

  void removeImage(int index) {
    final images = List<String>.from(state.images)..removeAt(index);
    state = state.copyWith(images: images);
    _validateForm();
  }

  void addDamageImage(String imageUrl) {
    AppLogger.debug('DamagedCar: Adding damage image: $imageUrl');
    final damageImages = List<String>.from(state.damageImages)..add(imageUrl);
    AppLogger.debug('DamagedCar: Damage images after adding: $damageImages');
    state = state.copyWith(damageImages: damageImages);
    _validateForm();
  }

  void removeDamageImage(int index) {
    final damageImages = List<String>.from(state.damageImages)..removeAt(index);
    state = state.copyWith(damageImages: damageImages);
    _validateForm();
  }

  void setDescription(String description) {
    state = state.copyWith(description: description);
  }

  void toggleFeature(String feature) {
    final features = Set<String>.from(state.features);
    if (features.contains(feature)) {
      features.remove(feature);
    } else {
      features.add(feature);
    }
    state = state.copyWith(features: features);
  }

  void reset() {
    state = const DamagedCarFormState();
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
        state.paintCondition != null &&
        state.bodyPanelDamage != null &&
        state.chassisIssues != null &&
        state.mechanicalIssues != null &&
        state.warningLights != null &&
        state.tiresCondition != null &&
        state.runsAndDrives != null &&
        state.color != null &&
        state.images.isNotEmpty;

    AppLogger.debug('DamagedCar Form validation:');
    AppLogger.debug('  make: ${state.selectedMakeName} (${state.selectedMakeId})');
    AppLogger.debug('  model: ${state.selectedModelName} (${state.selectedModelId})');
    AppLogger.debug('  year: ${state.selectedYear}');
    AppLogger.debug('  mileage: ${state.mileage}');
    AppLogger.debug('  sellingPrice: ${state.sellingPrice}');
    AppLogger.debug('  transmission: ${state.transmission}');
    AppLogger.debug('  engineSize: ${state.engineSize}');
    AppLogger.debug('  paintCondition: ${state.paintCondition}');
    AppLogger.debug('  bodyPanelDamage: ${state.bodyPanelDamage}');
    AppLogger.debug('  chassisIssues: ${state.chassisIssues}');
    AppLogger.debug('  mechanicalIssues: ${state.mechanicalIssues}');
    AppLogger.debug('  warningLights: ${state.warningLights}');
    AppLogger.debug('  tiresCondition: ${state.tiresCondition}');
    AppLogger.debug('  color: ${state.color}');
    AppLogger.debug('  images: ${state.images.length}');
    AppLogger.debug('  damageImages: ${state.damageImages.length}');
    AppLogger.debug('  isValid: $isValid');

    state = state.copyWith(isValid: isValid);
  }
}

final damagedCarFormNotifierProvider =
    StateNotifierProvider<DamagedCarFormNotifier, DamagedCarFormState>(
      (ref) => DamagedCarFormNotifier(),
    );

class DamagedCarCreateListingNotifier
    extends AsyncNotifier<CreateListingState> {
  @override
  CreateListingState build() {
    return const CreateListingInitial();
  }

  Future<void> submitDraft(DamagedCarFormState form) async {
    AppLogger.debug('=== DamagedCar SUBMIT DRAFT CALLED ===');
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
        damageImages: form.damageImages.isNotEmpty ? form.damageImages : null,
        description: form.description,
        conditionStatus: 'DAMAGED',
        conditionReport: form.toConditionReport(),
        inspectionReportUrl: form.inspectionReportUrl,
        listingType: 'REGULAR',
      );

      final listing = await repository.createDraftListing(request);
      state = AsyncData(CreateListingSuccess(listing.id));
    } catch (e, stackTrace) {
      AppLogger.error('submitDraft failed', error: e, stackTrace: stackTrace);
      AppLogger.debug('DamagedCar: Error submitting draft: $e');
      state = AsyncError(e, StackTrace.current);
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
      state = AsyncError(e, StackTrace.current);
    }
  }

  void reset() {
    state = const AsyncData(CreateListingInitial());
  }
}

final damagedCarCreateListingNotifierProvider =
    AsyncNotifierProvider<DamagedCarCreateListingNotifier, CreateListingState>(
      DamagedCarCreateListingNotifier.new,
    );
