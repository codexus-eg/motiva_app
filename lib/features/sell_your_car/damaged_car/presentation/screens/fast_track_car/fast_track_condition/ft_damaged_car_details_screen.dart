import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_additional_info_dc_tab/ft_colors_dc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_additional_info_dc_tab/ft_details_dc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_car_condition_dc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_car_speces_dc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_duration_dc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_images_dc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_location_dc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_make_dc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_mileage_dc.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_model_dc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_selling_price_dc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_trim_dc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/fast_track_car/ft_damaged_car_details/ft_year_dc_tab.dart';
import 'package:app/features/sell_your_car/domain/entities/entities.dart';
import 'package:app/features/sell_your_car/presentation/providers/providers.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class FtDamagedCarDetailsScreen extends ConsumerStatefulWidget {
  const FtDamagedCarDetailsScreen({super.key});

  @override
  ConsumerState<FtDamagedCarDetailsScreen> createState() =>
      _FtDamagedCarDetailsScreenState();
}

class _FtDamagedCarDetailsScreenState
    extends ConsumerState<FtDamagedCarDetailsScreen> {
  int selectedIndex = 0;
  bool _isSubmitting = false;
  bool _hasShownResult = false;

  void goToNextStack() {
    setState(() {
      selectedIndex++;
    });
  }

  void _onMakeSelected(CarMake make) {
    ref
        .read(damagedCarFormNotifierProvider.notifier)
        .setMake(make.id, make.name);
    ref.read(carDataNotifierProvider.notifier).selectMake(make);
    ref.read(carDataNotifierProvider.notifier).loadModels(make.id);
    goToNextStack();
  }

  void _onModelSelected(CarModel model) {
    ref
        .read(damagedCarFormNotifierProvider.notifier)
        .setModel(model.id, model.name);
    ref.read(carDataNotifierProvider.notifier).selectModel(model);
    ref.read(carDataNotifierProvider.notifier).loadTrims(model.id);
    goToNextStack();
  }

  void _onTrimSelected(CarTrim trim) {
    ref
        .read(damagedCarFormNotifierProvider.notifier)
        .setTrim(trim.id, trim.name);
    ref.read(carDataNotifierProvider.notifier).selectTrim(trim);
    goToNextStack();
  }

  void _onYearSelected(int year) {
    ref.read(damagedCarFormNotifierProvider.notifier).setYear(year);
    ref.read(carDataNotifierProvider.notifier).selectYear(year);
    goToNextStack();
  }

  void _onMileageEntered(int mileage) {
    ref.read(damagedCarFormNotifierProvider.notifier).setMileage(mileage);
    goToNextStack();
  }

  void _onSellingPriceEntered(double price) {
    ref.read(damagedCarFormNotifierProvider.notifier).setSellingPrice(price);
    goToNextStack();
  }

  void _onTransmissionSelected(String transmission) {
    ref
        .read(damagedCarFormNotifierProvider.notifier)
        .setTransmission(transmission);
  }

  void _onEngineSelected(String engineSize) {
    ref.read(damagedCarFormNotifierProvider.notifier).setEngineSize(engineSize);
  }

  void _onPaintConditionSelected(String condition) {
    ref
        .read(damagedCarFormNotifierProvider.notifier)
        .setPaintCondition(condition);
  }

  void _onBodyPanelDamageSelected(String damage) {
    ref
        .read(damagedCarFormNotifierProvider.notifier)
        .setBodyPanelDamage(damage);
    goToNextStack();
  }

  void _onChassisIssuesSelected(String value) {
    ref.read(damagedCarFormNotifierProvider.notifier).setChassisIssues(value);
  }

  void _onMechanicalIssuesSelected(String value) {
    ref
        .read(damagedCarFormNotifierProvider.notifier)
        .setMechanicalIssues(value);
  }

  void _onWarningLightsSelected(String value) {
    ref.read(damagedCarFormNotifierProvider.notifier).setWarningLights(value);
  }

  void _onTiresConditionSelected(String condition) {
    ref
        .read(damagedCarFormNotifierProvider.notifier)
        .setTiresCondition(condition);
  }

  void _onRunsAndDrivesSelected(bool value) {
    ref.read(damagedCarFormNotifierProvider.notifier).setRunsAndDrives(value);
    goToNextStack();
  }

  void _onInspectionReportUploaded(String? url) {
    if (url != null) {
      ref
          .read(damagedCarFormNotifierProvider.notifier)
          .setInspectionReportUrl(url);
    }
  }

  void _onColorSelected(String color) {
    ref.read(damagedCarFormNotifierProvider.notifier).setColor(color);
  }

  void _onDescriptionChanged(String description) {
    ref
        .read(damagedCarFormNotifierProvider.notifier)
        .setDescription(description);
  }

  void _onImagesUploaded(List<String> urls) {
    for (final url in urls) {
      ref.read(damagedCarFormNotifierProvider.notifier).addImage(url);
    }
  }

  void _onDamageImagesUploaded(List<String> urls) {
    for (final url in urls) {
      ref.read(damagedCarFormNotifierProvider.notifier).addDamageImage(url);
    }
  }

  void _onSubmit() {
    final formState = ref.read(damagedCarFormNotifierProvider);
    ref
        .read(fastTrackDamagedCreateListingNotifierProvider.notifier)
        .submitDraft(formState);
  }

  void _showSuccessDialog(String listingId) {
    final theme = Theme.of(context);
    final t = Translations.of(context).sell_your_car;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 64),
            const Gap(AppSpacing.md),
            Text(
              t.screens.request_received_dialog.title,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(AppSpacing.sm),
            Text(
              t.screens.request_received_dialog.message,
              style: TextStyle(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC8735),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text(
                  t.screens.success_dialog.done,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    final theme = Theme.of(context);
    final t = Translations.of(context).sell_your_car;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          t.screens.error_dialog.title,
          style: TextStyle(color: Colors.red),
        ),
        content: Text(
          message,
          style: TextStyle(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              t.screens.success_dialog.ok,
              style: TextStyle(color: Color(0xFFDC8735)),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getFilters() {
    final t = Translations.of(context).sell_your_car.steps;
    return [
      t.make,
      t.model,
      t.trim,
      t.year,
      t.mileage,
      t.selling_price,
      t.car_specs,
      t.car_condition,
      t.color,
      t.images,
      t.location,
      t.additional_info,
      t.duration,
    ];
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(carDataNotifierProvider.notifier).loadMakes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(fastTrackDamagedCreateListingNotifierProvider);

    if (asyncState.isLoading && !_isSubmitting) {
      _isSubmitting = true;
      _hasShownResult = false;
    }

    if (asyncState.hasValue && !_hasShownResult) {
      final state = asyncState.value;
      if (state is CreateListingSuccess) {
        _hasShownResult = true;
        _isSubmitting = false;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showSuccessDialog(state.listingId);
        });
      } else if (state is CreateListingError) {
        _hasShownResult = true;
        _isSubmitting = false;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showErrorDialog(state.message);
        });
      }
    }

    if (asyncState.hasError && !_hasShownResult) {
      _hasShownResult = true;
      _isSubmitting = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showErrorDialog(asyncState.error.toString());
      });
    }

    final theme = Theme.of(context);
    final t = Translations.of(context).sell_your_car.screens.car_details;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios, color: theme.colorScheme.onSurface),
        ),
        title: Text(
          t.title,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                _buildSteps(),
                const Gap(AppSpacing.lg),
                Expanded(
                  child: IndexedStack(
                    index: selectedIndex,
                    children: [
                      FtMakeDCTab(onMakeSelected: _onMakeSelected),
                      FtModelDCTab(onModelSelected: _onModelSelected),
                      FtTrimDCTab(onTrimSelected: _onTrimSelected),
                      FtYearDCTab(onYearSelected: _onYearSelected),
                      FtMileageDCTab(onMileageEntered: _onMileageEntered),
                      FtSellingPriceDCTab(
                        onPriceEntered: _onSellingPriceEntered,
                      ),
                      FtCarSpecsDcTab(
                        onTransmissionSelected: _onTransmissionSelected,
                        onEngineSelected: _onEngineSelected,
                        onPaintConditionSelected: _onPaintConditionSelected,
                        onBodyPanelDamageSelected: _onBodyPanelDamageSelected,
                        onInspectionReportUploaded: _onInspectionReportUploaded,
                      ),
                      FtCarConditionDCTab(
                        onChassisIssuesSelected: _onChassisIssuesSelected,
                        onMechanicalIssuesSelected: _onMechanicalIssuesSelected,
                        onWarningLightsSelected: _onWarningLightsSelected,
                        onTiresConditionSelected: _onTiresConditionSelected,
                        onRunsAndDrivesSelected: _onRunsAndDrivesSelected,
                      ),
                      FtColorsDCTab(
                        onContinue: goToNextStack,
                        onColorSelected: _onColorSelected,
                      ),
                      FtImagesDCTab(
                        onContinue: goToNextStack,
                        onImagesUploaded: _onImagesUploaded,
                        onDamageImagesUploaded: _onDamageImagesUploaded,
                      ),
                      FtLocationDcTab(onContinue: goToNextStack),
                      FtDetailsDCTab(
                        onDescriptionChanged: _onDescriptionChanged,
                      ),
                      FtDurationDcTab(onSubmit: _onSubmit),
                    ],
                  ),
                ),
              ],
            ),
            if (_isSubmitting)
              Container(
                color: Colors.black.withValues(alpha: 0.7),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShimmerSkeletons.cardSkeleton(),
                      Gap(AppSpacing.md),
                      Text(
                        t.submitting_request,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSteps() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _getFilters().length,
          separatorBuilder: (_, _) => const Gap(AppSpacing.md),
          itemBuilder: (context, index) {
            final bool isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 1,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFDC8735).withValues(alpha: 0.8)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFFDC8735)
                        : Colors.grey.shade500,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    _getFilters()[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Color(0xff9C9C9C),
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
