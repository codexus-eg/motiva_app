import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class LoyaltyBalanceCard extends StatelessWidget {
  final int? points;

  const LoyaltyBalanceCard({super.key, this.points});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context).user_dashboard.loyalty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDC8735), width: 1.4),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -24,
            right: -24,
            bottom: -24,
            child: SvgPicture.asset(
              'assets/images/wallet_card.svg',
              width: 166,
              height: 258,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.points_balance,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFFB5B5B5),
                  ),
                ),
                const Gap(AppSpacing.md),
                Text(
                  '${points ?? 0}',
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(AppSpacing.sm),
                Text(
                  t.points,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color(0xFFDC8735),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
