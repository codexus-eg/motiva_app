import 'package:app/core/theme/spacing.dart';
import 'package:app/features/buy_a_car/presentation/providers/car_filter_state.dart';
import 'package:app/features/buy_a_car/presentation/widgets/filter_dialog_base.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class YearFilterDialog extends ConsumerStatefulWidget {
  final int? yearFrom;
  final int? yearTo;
  final Function(int?, int?) onApply;

  const YearFilterDialog({
    super.key,
    this.yearFrom,
    this.yearTo,
    required this.onApply,
  });

  @override
  ConsumerState<YearFilterDialog> createState() => _YearFilterDialogState();
}

class _YearFilterDialogState extends ConsumerState<YearFilterDialog> {
  int? _yearFrom;
  int? _yearTo;
  List<int> _years = [];

  @override
  void initState() {
    super.initState();
    _yearFrom = widget.yearFrom;
    _yearTo = widget.yearTo;
  }

  @override
  Widget build(BuildContext context) {
    final filterOptions = ref.watch(filterOptionsProvider);
    final theme = Theme.of(context);

    return FilterDialogBase(
      title: t.buy_a_car.filters.year,
      content: filterOptions.when(
        data: (options) {
          final minYear = options.years.min;
          final maxYear = options.years.max;
          _years = List.generate(maxYear - minYear + 1, (i) => maxYear - i);

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDropdown(
                  label: t.buy_a_car.filters.from_year,
                  value: _yearFrom,
                  items: _years,
                  onChanged: (val) => setState(() => _yearFrom = val),
                ),
                const Gap(AppSpacing.lg),
                _buildDropdown(
                  label: t.buy_a_car.filters.to_year,
                  value: _yearTo,
                  items: _yearFrom != null
                      ? _years.where((y) => y >= (_yearFrom ?? 0)).toList()
                      : _years,
                  onChanged: (val) => setState(() => _yearTo = val),
                ),
              ],
            ),
          );
        },
        loading: () => ShimmerSkeletons.cardSkeleton(),
        error: (_, _) => Center(
          child: Text(
            t.buy_a_car.filters.failed_to_load_years,
            style: GoogleFonts.poppins(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.54),
            ),
          ),
        ),
      ),
      onApply: () {
        Navigator.of(context).pop();
        widget.onApply(_yearFrom, _yearTo);
      },
      onClear: (widget.yearFrom != null || widget.yearTo != null)
          ? () {
              Navigator.of(context).pop();
              widget.onApply(null, null);
            }
          : null,
    );
  }

  Widget _buildDropdown({
    required String label,
    required int? value,
    required List<int> items,
    required Function(int?) onChanged,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Gap(AppSpacing.sm),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<int>(
            value: value,
            isExpanded: true,
            hint: Text(
              t.buy_a_car.filters.select_year,
              style: GoogleFonts.poppins(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.54),
                fontSize: 14,
              ),
            ),
            dropdownColor: theme.colorScheme.primaryContainer,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.54),
            ),
            underline: const SizedBox(),
            items: [
              DropdownMenuItem<int>(
                value: null,
                child: Text(
                  t.buy_a_car.filters.any,
                  style: GoogleFonts.poppins(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.54),
                    fontSize: 14,
                  ),
                ),
              ),
              ...items.map(
                (year) => DropdownMenuItem<int>(
                  value: year,
                  child: Text(
                    year.toString(),
                    style: GoogleFonts.poppins(
                      color: value == year
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
