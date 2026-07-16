import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PayoutStatusBadge extends StatelessWidget {
  final String status;

  const PayoutStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, backgroundColor) = _statusConfig(context, status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  (String, Color) _statusConfig(BuildContext context, String status) {
    final t = Translations.of(context).vendor_dashboard.wallet.payout_status;
    switch (status) {
      case 'pending':
        return (t.pending, AppColors.primary);
      case 'processed':
        return (t.processed, AppColors.green);
      case 'rejected':
        return (t.rejected, AppColors.red);
      default:
        return (status, AppColors.primary);
    }
  }
}
