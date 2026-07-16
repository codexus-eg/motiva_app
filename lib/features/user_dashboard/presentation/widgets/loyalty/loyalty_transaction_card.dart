import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/features/loyalty/domain/entities/loyalty_transaction.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class LoyaltyTransactionCard extends StatelessWidget {
  final LoyaltyTransaction transaction;

  const LoyaltyTransactionCard({super.key, required this.transaction});

  Color _getPointsColor(BuildContext context) {
    switch (transaction.type.toLowerCase()) {
      case 'earn':
        return Colors.green;
      case 'redeem':
        return Colors.red;
      case 'expire':
      case 'adjust':
        return AppColors.textSecondary;
      default:
        return AppColors.textSecondary;
    }
  }

  String _getSign() {
    switch (transaction.type.toLowerCase()) {
      case 'earn':
        return '+';
      case 'redeem':
      case 'expire':
        return '-';
      case 'adjust':
        return transaction.points >= 0 ? '+' : '-';
      default:
        return transaction.points >= 0 ? '+' : '-';
    }
  }

  String _getTypeLabel(BuildContext context) {
    final t = Translations.of(context).user_dashboard.loyalty;
    switch (transaction.type.toLowerCase()) {
      case 'earn':
        return t.earn;
      case 'redeem':
        return t.redeem;
      case 'expire':
        return t.expire;
      case 'adjust':
        return t.adjust;
      default:
        return transaction.type;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                _getSign(),
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _getPointsColor(context),
                ),
              ),
            ),
          ),
          const Gap(AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getTypeLabel(context),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                if (transaction.description != null) ...[
                  const Gap(AppSpacing.xs),
                  Text(
                    transaction.description!,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${_getSign()}${transaction.points.abs()}',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _getPointsColor(context),
                ),
              ),
              const Gap(AppSpacing.xs),
              Text(
                DateFormat('MMM d, yyyy').format(transaction.createdAt),
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
