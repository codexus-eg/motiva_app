import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app/i18n/strings.g.dart';

import '../providers/vendor_product_analytics_state.dart';

class TimePeriodFilter extends StatelessWidget {
  final TimePeriod selectedPeriod;
  final ValueChanged<TimePeriod> onPeriodSelected;

  const TimePeriodFilter({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).vendor_product_analytics.time_period;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildChip(label: t.k7d, period: TimePeriod.sevenDays, theme: theme),
        const Gap(AppSpacing.sm),
        _buildChip(label: t.k30d, period: TimePeriod.thirtyDays, theme: theme),
        const Gap(AppSpacing.sm),
        _buildChip(label: t.k90d, period: TimePeriod.ninetyDays, theme: theme),
      ],
    );
  }

  Widget _buildChip({
    required String label,
    required TimePeriod period,
    required ColorScheme theme,
  }) {
    final isSelected = selectedPeriod == period;

    return GestureDetector(
      onTap: () => onPeriodSelected(period),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : theme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? null
              : Border.all(
                  color: AppColors.textSecondary.withValues(alpha: 0.2),
                ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.white : theme.onSurface,
          ),
        ),
      ),
    );
  }
}
