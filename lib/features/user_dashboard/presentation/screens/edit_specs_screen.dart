import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/make_gc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/model_gc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/trim_gc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/year_gc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/mileage_gc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/car_specs_gc_tab/transmission_gc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/additional_info_gc_tab/colors_gc_tab.dart';
import 'package:app/features/sell_your_car/domain/entities/entities.dart';
import 'package:app/features/sell_your_car/presentation/providers/providers.dart';
import 'package:app/features/user_dashboard/presentation/providers/edit_specs_provider.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class EditSpecsScreen extends ConsumerStatefulWidget {
  final String listingId;
  final CarListing listing;

  const EditSpecsScreen({
    super.key,
    required this.listingId,
    required this.listing,
  });

  @override
  ConsumerState<EditSpecsScreen> createState() => _EditSpecsScreenState();
}

class _EditSpecsScreenState extends ConsumerState<EditSpecsScreen> {
  int currentIndex = 0;

  List<String> get filters {
    final t = Translations.of(context).user_dashboard.edit_specs.steps;
    return [
      t.make,
      t.model,
      t.trim,
      t.year,
      t.mileage,
      t.transmission,
      t.color,
    ];
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(editSpecsNotifierProvider.notifier)
          .initializeFromListing(widget.listing);
      ref.read(carDataNotifierProvider.notifier).loadMakes();
    });
  }

  void goToNextStack() {
    if (currentIndex < filters.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void goToPreviousStack() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  void _onMakeSelected(CarMake make) {
    ref.read(editSpecsNotifierProvider.notifier).setMake(make.id, make.name);
    ref.read(carDataNotifierProvider.notifier).selectMake(make);
    ref.read(carDataNotifierProvider.notifier).loadModels(make.id);
    goToNextStack();
  }

  void _onModelSelected(CarModel model) {
    ref.read(editSpecsNotifierProvider.notifier).setModel(model.id, model.name);
    ref.read(carDataNotifierProvider.notifier).selectModel(model);
    ref.read(carDataNotifierProvider.notifier).loadTrims(model.id);
    goToNextStack();
  }

  void _onTrimSelected(CarTrim trim) {
    ref.read(editSpecsNotifierProvider.notifier).setTrim(trim.id, trim.name);
    ref.read(carDataNotifierProvider.notifier).selectTrim(trim);
    goToNextStack();
  }

  void _onYearSelected(int year) {
    ref.read(editSpecsNotifierProvider.notifier).setYear(year);
    ref.read(carDataNotifierProvider.notifier).selectYear(year);
    goToNextStack();
  }

  void _onMileageEntered(int mileage) {
    ref.read(editSpecsNotifierProvider.notifier).setMileage(mileage);
    goToNextStack();
  }

  void _onTransmissionSelected(String transmission) {
    ref.read(editSpecsNotifierProvider.notifier).setTransmission(transmission);
    goToNextStack();
  }

  void _onColorSelected(String color) {
    ref.read(editSpecsNotifierProvider.notifier).setColor(color);
  }

  void _onSave() async {
    final notifier = ref.read(editSpecsNotifierProvider.notifier);
    await notifier.updateSpecs(widget.listingId);

    final state = ref.read(editSpecsNotifierProvider);
    if (state.isSuccess && mounted) {
      if (mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final editState = ref.watch(editSpecsNotifierProvider);

    ref.listen(editSpecsNotifierProvider, (previous, current) {
      if (current.error != null && current.error != previous?.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(current.error!), backgroundColor: Colors.red),
        );
      }
    });

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
          Translations.of(context).user_dashboard.edit_specs.screen_title,
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
        child: Column(
          children: [
            _buildSteps(),
            const Gap(AppSpacing.lg),
            Expanded(
              child: IndexedStack(
                index: currentIndex,
                children: [
                  MakeGCTab(onMakeSelected: _onMakeSelected),
                  ModelGCTab(onModelSelected: _onModelSelected),
                  TrimGCTab(onTrimSelected: _onTrimSelected),
                  YearGCTab(onYearSelected: _onYearSelected),
                  MileageGCTab(onMileageEntered: _onMileageEntered),
                  TransmissionGCTab(
                    onContinue: goToNextStack,
                    onTransmissionSelected: _onTransmissionSelected,
                  ),
                  ColorsGCTab(
                    onContinue: goToNextStack,
                    onColorSelected: _onColorSelected,
                  ),
                ],
              ),
            ),
            if (currentIndex == filters.length - 1)
              Padding(
                padding: const EdgeInsets.all(16),
                child: GradientButton(
                  text: editState.isLoading
                      ? Translations.of(
                          context,
                        ).user_dashboard.edit_specs.save_button_loading
                      : Translations.of(
                          context,
                        ).user_dashboard.edit_specs.save_button,
                  onTap: editState.isLoading ? null : _onSave,
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
          itemCount: filters.length,
          separatorBuilder: (_, _) => const Gap(AppSpacing.md),
          itemBuilder: (context, index) {
            final bool isSelected = currentIndex == index;
            final bool isCompleted = index < currentIndex;
            final editState = ref.watch(editSpecsNotifierProvider);
            final bool hasValue = _hasValueForIndex(index, editState);

            return GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = index;
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
                      : (hasValue || isCompleted)
                      ? const Color(0xFFDC8735).withValues(alpha: 0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFFDC8735)
                        : (hasValue || isCompleted)
                        ? const Color(0xFFDC8735)
                        : Colors.grey.shade500,
                    width: 1.1,
                  ),
                ),
                child: Center(
                  child: Text(
                    filters[index],
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : (hasValue || isCompleted)
                          ? const Color(0xFFDC8735)
                          : const Color(0xff9C9C9C),
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

  bool _hasValueForIndex(int index, EditSpecsState state) {
    switch (index) {
      case 0:
        return state.selectedMakeId != null;
      case 1:
        return state.selectedModelId != null;
      case 2:
        return state.selectedTrimId != null;
      case 3:
        return state.selectedYear != null;
      case 4:
        return state.mileage != null;
      case 5:
        return state.transmission != null;
      case 6:
        return state.color != null;
      default:
        return false;
    }
  }
}
