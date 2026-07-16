import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/features/wallet/domain/entities/wallet_transaction.dart';

String _getReferenceTypeLabel(String referenceType, BuildContext context) {
  final t = Translations.of(context).vendor_dashboard.wallet.reference_types;
  switch (referenceType) {
    case 'order':
      return t.order;
    case 'refund':
      return t.refund;
    case 'voucher':
      return t.voucher;
    case 'adjustment':
      return t.adjustment;
    case 'admin':
      return t.admin;
    case 'payout_hold':
      return t.payout_hold;
    case 'payout_release':
      return t.payout_release;
    case 'product_order':
      return t.product_order;
    default:
      return referenceType;
  }
}

String _formatDate(DateTime date) {
  final months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}

class VendorHistoryWidget extends StatelessWidget {
  final WalletTransaction transaction;

  const VendorHistoryWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).vendor_dashboard.wallet;

    final isCredit = transaction.type == 'credit';
    final amountText = '${isCredit ? '+' : '-'}KWD ${transaction.amount}';
    final amountColor = isCredit
        ? const Color(0xFF017B3F)
        : const Color(0xFFFF5500);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _getReferenceTypeLabel(transaction.referenceType, context),
                  style: GoogleFonts.poppins(
                    color: theme.onSurface,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                amountText,
                style: GoogleFonts.poppins(
                  color: amountColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(AppSpacing.sm),
              Icon(
                Icons.keyboard_arrow_down,
                color: theme.onSurface.withValues(alpha: 0.6),
              ),
            ],
          ),
          const Gap(AppSpacing.sm),
          Text(
            _formatDate(transaction.createdAt),
            style: GoogleFonts.poppins(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          if (transaction.description != null) ...[
            const Gap(AppSpacing.sm),
            Text(
              transaction.description!,
              style: GoogleFonts.poppins(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const Gap(AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (transaction.referenceId != null)
                Flexible(
                  child: Text(
                    t.id_label.replaceAll('{id}', transaction.referenceId!),
                    style: GoogleFonts.poppins(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
