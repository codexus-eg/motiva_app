import 'package:app/features/buy_a_car/presentation/providers/car_filter_state.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/features/buy_a_car/presentation/widgets/filters/make_filter_dialog.dart';
import 'package:app/features/buy_a_car/presentation/widgets/filters/model_filter_dialog.dart';
import 'package:app/features/buy_a_car/presentation/widgets/filters/trim_filter_dialog.dart';
import 'package:app/features/buy_a_car/presentation/widgets/filters/year_filter_dialog.dart';
import 'package:app/features/buy_a_car/presentation/widgets/filters/mileage_filter_dialog.dart';
import 'package:app/features/buy_a_car/presentation/widgets/filters/transmission_filter_dialog.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class FilterRow extends ConsumerWidget {
  final Function() onFiltersChanged;

  const FilterRow({super.key, required this.onFiltersChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(carFilterStateProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          if (filterState.hasActiveFilters)
            GestureDetector(
              onTap: () {
                ref.read(carFilterStateProvider.notifier).clearAll();
                onFiltersChanged();
              },
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFDC8735)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.close, color: const Color(0xFFDC8735), size: 16),
                    const Gap(AppSpacing.xs),
                    Text(
                      t.buy_a_car.filters.clear_all,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFDC8735),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (filterState.hasActiveFilters) const Gap(AppSpacing.sm),
          ..._buildFilterChips(context, ref, filterState),
        ],
      ),
    );
  }

  List<Widget> _buildFilterChips(
    BuildContext context,
    WidgetRef ref,
    CarFilterState filterState,
  ) {
    return [
      _FilterChip(
        label: t.buy_a_car.filters.make,
        displayValue: filterState.make,
        isActive: filterState.make != null,
        onTap: () => _showMakeDialog(context, ref, filterState.make),
      ),
      const Gap(AppSpacing.sm),
      _FilterChip(
        label: t.buy_a_car.filters.model,
        displayValue: filterState.model,
        isActive: filterState.model != null,
        isDisabled: filterState.make == null,
        onTap: filterState.make != null
            ? () => _showModelDialog(
                context,
                ref,
                filterState.make,
                filterState.model,
              )
            : null,
      ),
      const Gap(AppSpacing.sm),
      _FilterChip(
        label: t.buy_a_car.filters.trim,
        displayValue: filterState.trim,
        isActive: filterState.trim != null,
        isDisabled: filterState.model == null,
        onTap: filterState.model != null
            ? () => _showTrimDialog(
                context,
                ref,
                filterState.make,
                filterState.model,
                filterState.trim,
              )
            : null,
      ),
      const Gap(AppSpacing.sm),
      _FilterChip(
        label: t.buy_a_car.filters.year,
        displayValue: filterState.yearDisplay,
        isActive: filterState.yearFrom != null || filterState.yearTo != null,
        onTap: () => _showYearDialog(
          context,
          ref,
          filterState.yearFrom,
          filterState.yearTo,
        ),
      ),
      const Gap(AppSpacing.sm),
      _FilterChip(
        label: t.buy_a_car.filters.mileage,
        displayValue: filterState.mileageDisplay,
        isActive:
            filterState.mileageFrom != null || filterState.mileageTo != null,
        onTap: () => _showMileageDialog(
          context,
          ref,
          filterState.mileageFrom,
          filterState.mileageTo,
        ),
      ),
      const Gap(AppSpacing.sm),
      _FilterChip(
        label: t.buy_a_car.filters.transmission,
        displayValue: filterState.transmission != null
            ? filterState.transmission == 'AUTOMATIC'
                  ? t.buy_a_car.filters.automatic
                  : t.buy_a_car.filters.manual
            : null,
        isActive: filterState.transmission != null,
        onTap: () =>
            _showTransmissionDialog(context, ref, filterState.transmission),
      ),
    ];
  }

  void _showMakeDialog(
    BuildContext context,
    WidgetRef ref,
    String? selectedMake,
  ) {
    showDialog(
      context: context,
      builder: (context) => MakeFilterDialog(
        selectedMake: selectedMake,
        onApply: (make) {
          ref.read(carFilterStateProvider.notifier).setMake(make);
          if (make == null || make != selectedMake) {
            ref.read(carFilterStateProvider.notifier).clearModel();
            ref.read(carFilterStateProvider.notifier).clearTrim();
          }
          onFiltersChanged();
        },
      ),
    );
  }

  void _showModelDialog(
    BuildContext context,
    WidgetRef ref,
    String? selectedMake,
    String? selectedModel,
  ) {
    showDialog(
      context: context,
      builder: (context) => ModelFilterDialog(
        selectedMake: selectedMake,
        selectedModel: selectedModel,
        onApply: (model) {
          ref.read(carFilterStateProvider.notifier).setModel(model);
          if (model == null || model != selectedModel) {
            ref.read(carFilterStateProvider.notifier).clearTrim();
          }
          onFiltersChanged();
        },
      ),
    );
  }

  void _showTrimDialog(
    BuildContext context,
    WidgetRef ref,
    String? selectedMake,
    String? selectedModel,
    String? selectedTrim,
  ) {
    showDialog(
      context: context,
      builder: (context) => TrimFilterDialog(
        selectedMake: selectedMake,
        selectedModel: selectedModel,
        selectedTrim: selectedTrim,
        onApply: (trim) {
          ref.read(carFilterStateProvider.notifier).setTrim(trim);
          onFiltersChanged();
        },
      ),
    );
  }

  void _showYearDialog(
    BuildContext context,
    WidgetRef ref,
    int? yearFrom,
    int? yearTo,
  ) {
    showDialog(
      context: context,
      builder: (context) => YearFilterDialog(
        yearFrom: yearFrom,
        yearTo: yearTo,
        onApply: (from, to) {
          ref.read(carFilterStateProvider.notifier).setYearRange(from, to);
          onFiltersChanged();
        },
      ),
    );
  }

  void _showMileageDialog(
    BuildContext context,
    WidgetRef ref,
    int? mileageFrom,
    int? mileageTo,
  ) {
    showDialog(
      context: context,
      builder: (context) => MileageFilterDialog(
        mileageFrom: mileageFrom,
        mileageTo: mileageTo,
        onApply: (from, to) {
          ref.read(carFilterStateProvider.notifier).setMileageRange(from, to);
          onFiltersChanged();
        },
      ),
    );
  }

  void _showTransmissionDialog(
    BuildContext context,
    WidgetRef ref,
    String? transmission,
  ) {
    showDialog(
      context: context,
      builder: (context) => TransmissionFilterDialog(
        transmission: transmission,
        onApply: (trans) {
          ref.read(carFilterStateProvider.notifier).setTransmission(trans);
          onFiltersChanged();
        },
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final String? displayValue;
  final bool isActive;
  final bool isDisabled;
  final VoidCallback? onTap;

  const _FilterChip({
    required this.label,
    this.displayValue,
    required this.isActive,
    this.isDisabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFC17F3A) : Colors.transparent,
          border: Border.all(
            color: isDisabled
                ? const Color(0xFF3A3A3A).withValues(alpha: 0.5)
                : isActive
                ? const Color(0xFFC17F3A)
                : const Color(0xFF3A3A3A),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              displayValue ?? label,
              style: TextStyle(
                color: isDisabled
                    ? theme.colorScheme.onSurface.withValues(alpha: 0.24)
                    : isActive
                    ? theme.colorScheme.onSurface
                    : theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const Gap(AppSpacing.xs),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: isDisabled
                  ? theme.colorScheme.onSurface.withValues(alpha: 0.24)
                  : isActive
                  ? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurface.withValues(alpha: 0.54),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
