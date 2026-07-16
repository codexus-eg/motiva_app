import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart' show Translations;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class QuickStatsCard extends StatelessWidget {
  final int totalSales;
  final double totalEarnings;
  final String averageRating;
  final String cancellationRate;
  final int totalOrders;
  final String period;

  const QuickStatsCard({
    super.key,
    required this.totalSales,
    required this.totalEarnings,
    required this.averageRating,
    required this.cancellationRate,
    required this.totalOrders,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).home.vendor.stats.stats_card;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.title,
                style: GoogleFonts.poppins(
                  color: theme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getPeriodLabel(context),
                  style: GoogleFonts.poppins(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.attach_money,
                  label: t.earnings,
                  value: 'KD ${totalEarnings.toStringAsFixed(2)}',
                  color: Colors.green,
                  context: context,
                ),
              ),
              const Gap(AppSpacing.md),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.work_history,
                  label: t.orders,
                  value: '$totalOrders',
                  color: AppColors.primary,
                  context: context,
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.star,
                  label: t.rating,
                  value: averageRating,
                  color: Colors.amber,
                  context: context
                ),
              ),
              const Gap(AppSpacing.md),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.receipt,
                  label: t.sales,
                  value: '$totalSales',
                  color: Colors.blue,
                  context: context,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getPeriodLabel(BuildContext context) {
    final t = Translations.of(context).home.vendor.stats;
    switch (period) {
      case 'today':
        return t.today;
      case 'weekly':
        return t.this_weekly;
      case 'monthly':
        return t.this_monthly;
      default:
        return t.today;
    }
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required BuildContext context,
  }) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const Gap(AppSpacing.sm),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: theme.onSurface.withValues(alpha: 0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.sm),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: theme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
