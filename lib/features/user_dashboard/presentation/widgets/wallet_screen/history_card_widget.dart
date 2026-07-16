import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/features/wallet/domain/entities/wallet_transaction.dart';

String _getReferenceTypeLabel(String referenceType, BuildContext context) {
  final t = Translations.of(context).user_dashboard.wallet.reference_types;
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

String _formatDate(DateTime date, BuildContext context) {
  final m = Translations.of(context).user_dashboard.wallet.months;
  final months = [
    m.jan,
    m.feb,
    m.mar,
    m.apr,
    m.may,
    m.jun,
    m.jul,
    m.aug,
    m.sep,
    m.oct,
    m.nov,
    m.dec,
  ];
  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}

class HistoryCardWidget extends StatefulWidget {
  final WalletTransaction transaction;

  const HistoryCardWidget({super.key, required this.transaction});

  @override
  State<HistoryCardWidget> createState() => _HistoryCardWidgetState();
}

class _HistoryCardWidgetState extends State<HistoryCardWidget> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    final hasDetails =
        widget.transaction.description != null ||
        widget.transaction.referenceId != null;
    if (!hasDetails) return;
    setState(() => _isExpanded = !_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    final transaction = widget.transaction;
    final hasDetails =
        transaction.description != null || transaction.referenceId != null;
    final theme = Theme.of(context);
    final t = Translations.of(context).user_dashboard.wallet;

    final isCredit = transaction.type == 'credit';
    final amountText = '${isCredit ? '+' : '-'}KWD ${transaction.amount}';
    final amountColor = isCredit
        ? const Color(0xFF017B3F)
        : const Color(0xFFFF5500);

    return GestureDetector(
      onTap: hasDetails ? _toggleExpanded : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(18),
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
                      color: theme.colorScheme.onSurface,
                      fontSize: 16,
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
                if (hasDetails) ...[
                  const Gap(AppSpacing.xs),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFF7E8087),
                    ),
                  ),
                ],
              ],
            ),
            const Gap(AppSpacing.xs),
            Text(
              _formatDate(transaction.createdAt, context),
              style: GoogleFonts.poppins(
                color: const Color(0xFF9FA1AA),
                fontSize: 12,
              ),
            ),
            AnimatedCrossFade(
              crossFadeState: hasDetails && _isExpanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 200),
              firstChild: Column(
                children: [
                  const Gap(AppSpacing.md),
                  const Divider(color: Color(0xFF7E8087), thickness: 1),
                  const Gap(AppSpacing.sm),
                  if (transaction.description != null)
                    _detailRow(
                      context,
                      t.transaction_details.description,
                      transaction.description!,
                    ),
                  if (transaction.description != null) const Gap(AppSpacing.sm),
                  if (transaction.referenceId != null)
                    _detailRow(
                      context,
                      t.transaction_details.reference_id,
                      transaction.referenceId!,
                    ),
                  if (transaction.referenceId != null) const Gap(AppSpacing.sm),
                  _detailRow(
                    context,
                    t.transaction_details.type,
                    isCredit ? t.credit : t.debit,
                  ),
                ],
              ),
              secondChild: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13),
        ),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
