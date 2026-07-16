import 'package:app/i18n/strings.g.dart' show Translations;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context).home.customer.promo_banner;
    return Container(
      width: double.infinity,
      height: 85,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFDC8735)),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            right: -20, // Adjust to match visual
            top: -16,
            child: SvgPicture.asset(
              'assets/images/promo_bg_pattern.svg',
              width: 203,
              height: 129,
              colorFilter: ColorFilter.mode(
                Colors.white.withValues(alpha: 0.27),
                BlendMode.srcIn,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                    height: 1.26,
                  ),
                ),
                const Gap(AppSpacing.xs), // Approx spacing
                Text(
                  t.description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onPrimaryContainer,
                    height: 1.26,
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
