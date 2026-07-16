import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumBanner extends StatelessWidget {
  const PremiumBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).home.customer.premium_banner;
    return Container(
      width: double.infinity,
      height: 153,
      decoration: BoxDecoration(
        color: const Color(0xFFFF5C00),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: 0,
              top: 45,
              child: SvgPicture.asset(
                'assets/images/banner_bg_pattern.svg',
                width: 190.5,
                height: 108.11,
                colorFilter: ColorFilter.mode(
                  Colors.white.withValues(alpha: 0.27),
                  BlendMode.srcIn,
                ),
              ),
            ),
            Positioned(
              left: 27,
              top: 24,
              child: SizedBox(
                width: 195,
                child: Text(
                  t.title,
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.26,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 25,
              top: 103,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 11,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  t.button.toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF111111),
                  ),
                ),
              ),
            ),
            Positioned(
              right: -30,
              top: 5,
              child: Image.asset(
                'assets/images/banner_car.png',
                width: 200,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
