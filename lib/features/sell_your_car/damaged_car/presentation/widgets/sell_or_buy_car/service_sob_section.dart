import 'package:app/features/buy_a_car/presentation/screens/buy_a_car_screen.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/screens/sell_a_car_screen.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/service_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class ServicesSOBSection extends StatelessWidget {
  const ServicesSOBSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context).sell_your_car.service_sections;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const Gap(AppSpacing.lg),

          Text(
            t.all_services,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const Gap(AppSpacing.lg),

          ServiceCard(
            title: t.sell_a_car,
            description: t.lorem_description,
            imagePath: 'assets/images/sell_car.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SellACarScreen()),
              );
            },
          ),

          const Gap(AppSpacing.md),

          ServiceCard(
            title: t.buy_a_car,
            description: t.lorem_description,
            imagePath: 'assets/images/buy_car.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BuyACarScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
