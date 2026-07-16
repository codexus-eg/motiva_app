import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/additional_info_gc_tab/colors_gc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/additional_info_gc_tab/additional_info_gc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/additional_info_gc_tab/images_gc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/car_specs_gc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/location_gc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/make_gc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/mileage_gc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/model_gc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/selling_price_gc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/trim_gc_tab.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/good_car_details/year_gc_tab.dart';
import 'package:app/features/sell_your_car/presentation/providers/providers.dart';
import 'package:app/features/sell_your_car/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class GoodCarDetailsScreen extends ConsumerStatefulWidget {
  const GoodCarDetailsScreen({super.key});

  @override
  ConsumerState<GoodCarDetailsScreen> createState() =>
      _GoodCarDetailsScreenState();
}

class _GoodCarDetailsScreenState extends ConsumerState<GoodCarDetailsScreen> {
  int goodCarIndex = 0;

  void goToNextStack() {
    setState(() {
      goodCarIndex++;
    });
  }

  void _onMakeSelected(CarMake make) {
    ref.read(goodCarFormNotifierProvider.notifier).setMake(make.id, make.name);
    ref.read(carDataNotifierProvider.notifier).selectMake(make);
    ref.read(carDataNotifierProvider.notifier).loadModels(make.id);
    goToNextStack();
  }

  void _onModelSelected(CarModel model) {
    ref
        .read(goodCarFormNotifierProvider.notifier)
        .setModel(model.id, model.name);
    ref.read(carDataNotifierProvider.notifier).selectModel(model);
    ref.read(carDataNotifierProvider.notifier).loadTrims(model.id);
    goToNextStack();
  }

  void _onTrimSelected(CarTrim trim) {
    ref.read(goodCarFormNotifierProvider.notifier).setTrim(trim.id, trim.name);
    ref.read(carDataNotifierProvider.notifier).selectTrim(trim);
    goToNextStack();
  }

  void _onYearSelected(int year) {
    ref.read(goodCarFormNotifierProvider.notifier).setYear(year);
    ref.read(carDataNotifierProvider.notifier).selectYear(year);
    goToNextStack();
  }

  void _onMileageEntered(int mileage) {
    ref.read(goodCarFormNotifierProvider.notifier).setMileage(mileage);
    goToNextStack();
  }

  void _onSellingPriceEntered(double price) {
    ref.read(goodCarFormNotifierProvider.notifier).setSellingPrice(price);
    goToNextStack();
  }

  void _onTransmissionSelected(String transmission) {
    ref
        .read(goodCarFormNotifierProvider.notifier)
        .setTransmission(transmission);
  }

  void _onEngineSelected(String engineSize) {
    ref.read(goodCarFormNotifierProvider.notifier).setEngineSize(engineSize);
  }

  void _onColorSelected(String color) {
    ref.read(goodCarFormNotifierProvider.notifier).setColor(color);
  }

  void _onDescriptionChanged(String description) {
    ref.read(goodCarFormNotifierProvider.notifier).setDescription(description);
  }

  void _onImagesUploaded(List<String> imageUrls) {
    for (final url in imageUrls) {
      ref.read(goodCarFormNotifierProvider.notifier).addImage(url);
    }
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
      t.color,
      t.image,
      t.location,
      t.additional_info,
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
        child: Column(
          children: [
            _buildSteps(),
            const Gap(AppSpacing.lg),
            Expanded(
              child: IndexedStack(
                index: goodCarIndex,
                children: [
                  MakeGCTab(onMakeSelected: _onMakeSelected),
                  ModelGCTab(onModelSelected: _onModelSelected),
                  TrimGCTab(onTrimSelected: _onTrimSelected),
                  YearGCTab(onYearSelected: _onYearSelected),
                  MileageGCTab(onMileageEntered: _onMileageEntered),
                  SellingPriceGCTab(onPriceEntered: _onSellingPriceEntered),
                  CarSpecsGCTab(
                    onTransmissionSelected: _onTransmissionSelected,
                    onEngineSelected: _onEngineSelected,
                  ),
                  ColorsGCTab(
                    onContinue: goToNextStack,
                    onColorSelected: _onColorSelected,
                  ),
                  ImagesGCTab(
                    onContinue: goToNextStack,
                    onImagesUploaded: _onImagesUploaded,
                  ),
                  LocationGcTab(onContinue: goToNextStack),
                  AdditionalInfoGCTab(
                    onDescriptionChanged: _onDescriptionChanged,
                    onSubmit: () {
                      final formState = ref.read(goodCarFormNotifierProvider);
                      ref
                          .read(createListingNotifierProvider.notifier)
                          .submitDraft(formState);
                    },
                  ),
                ],
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
            final bool isSelected = goodCarIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  goodCarIndex = index;
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
                    width: 1.1,
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
