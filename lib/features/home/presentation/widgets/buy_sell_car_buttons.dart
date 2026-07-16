import 'package:app/features/sell_your_car/damaged_car/presentation/screens/sell_or_buy_car_screen.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class BuySellCarButtons extends StatelessWidget {
  const BuySellCarButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).home.customer.buy_sell_card;
    return Row(
      children: [
        Expanded(
          child: _CarButton(
            title: t.buy,
            image: 'assets/images/services_buy_car.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SellOrBuyCarScreen(),
                ),
              );
            },
          ),
        ),
        const Gap(AppSpacing.md),
        Expanded(
          child: _CarButton(
            title: t.sell,
            image: 'assets/images/services_sell_car.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SellOrBuyCarScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CarButton extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const _CarButton({
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).home.customer.buy_sell_card;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFF2B2C33),
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -20,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  image,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Gap(AppSpacing.xs),
                  Text(
                    t.tap,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFFECA553),
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
