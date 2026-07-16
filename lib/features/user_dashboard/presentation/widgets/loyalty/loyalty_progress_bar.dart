import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class LoyaltyProgressBar extends StatelessWidget {
  final int currentPoints;
  final int minRedeemPoints;

  const LoyaltyProgressBar({
    super.key,
    required this.currentPoints,
    required this.minRedeemPoints,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context).user_dashboard.loyalty;
    final progress = (currentPoints / minRedeemPoints).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.progress_to_reward,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const Gap(AppSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 12,
            backgroundColor: theme.colorScheme.primaryContainer,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFDC8735)),
          ),
        ),
        const Gap(AppSpacing.sm),
        Text(
          t.of_points_to_reward
              .replaceAll('{current}', currentPoints.toString())
              .replaceAll('{total}', minRedeemPoints.toString()),
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
