import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class RatingFilterChips extends StatelessWidget {
  final int? selectedRating;
  final Function(int?) onRatingSelected;

  const RatingFilterChips({
    super.key,
    required this.selectedRating,
    required this.onRatingSelected,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).reviews.display;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildChip(context, null, t.filter_all),
          const Gap(AppSpacing.sm),
          _buildChip(context, 5, t.filter_5_stars),
          const Gap(AppSpacing.sm),
          _buildChip(context, 4, t.filter_4_stars),
          const Gap(AppSpacing.sm),
          _buildChip(context, 3, t.filter_3_stars),
          const Gap(AppSpacing.sm),
          _buildChip(context, 2, t.filter_2_stars),
          const Gap(AppSpacing.sm),
          _buildChip(context, 1, t.filter_1_star),
        ],
      ),
    );
  }

  Widget _buildChip(BuildContext context, int? rating, String label) {
    final isSelected = selectedRating == rating;
    final theme = Theme.of(context);

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        onRatingSelected(selected ? rating : null);
      },
      backgroundColor: theme.colorScheme.surface,
      selectedColor: theme.colorScheme.primary.withValues(alpha: 0.1),
      checkmarkColor: theme.colorScheme.primary,
      labelStyle: TextStyle(
        color: isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }
}
