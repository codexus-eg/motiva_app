import 'package:app/features/sell_your_car/damaged_car/presentation/screens/condition_car_screen.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/screens/fast_track_car/fast_track_sale_screen.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/screens/open_an_auction/open_an_auction_screen.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/service_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class ServiceScSection extends StatelessWidget {
  const ServiceScSection({super.key});

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

          ServiceCard(
            title: t.sell_your_car,
            description: t.lorem_description,
            imagePath: 'assets/images/sell_car.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConditionCarScreen()),
              );
            },
          ),

          const Gap(AppSpacing.md),

          ServiceCard(
            title: t.open_an_auction,
            description: t.lorem_description,
            imagePath: 'assets/images/open_an_auction.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OpenAnAuctionScreen()),
              );
            },
          ),
          Gap(AppSpacing.md),
          ServiceCard(
            title: t.fast_track_car_sale,
            description: t.lorem_description,
            imagePath: 'assets/images/fast_track_car_sale.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FastTrackCarSaleScreen(),
                ),
              );
            },
          ),
          Gap(AppSpacing.lg),
        ],
      ),
    );
  }
}
