import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class ProfilePromoBanner extends StatelessWidget {
  const ProfilePromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context).home.customer.promo_banner;
    return Container(
      width: double.infinity,
      height: 85,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        // const Color(0xFF111315),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFF8A00), width: 1.2),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              right: -15,
              top: -16,
              child: SvgPicture.asset(
                'assets/images/promo_bg_pattern.svg',
                width: 203,
                height: 129,
                colorFilter: ColorFilter.mode(
                  Colors.white.withValues(alpha: 0.2),
                  BlendMode.srcIn,
                ),
              ),
            ),

            // Timer Badge
            Positioned(
              right: 30,
              top: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '35:00',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
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
                  const Gap(AppSpacing.xs),
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
      ),
    );
  }
}
