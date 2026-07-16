import 'package:app/features/sell_your_car/damaged_car/presentation/screens/fast_track_car/fast_track_condition/ft_damaged_car_details_screen.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/screens/fast_track_car/fast_track_condition/ft_good_car_details_screen.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/service_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class ServiceFTCCSection extends StatelessWidget {
  const ServiceFTCCSection({super.key});

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
            title: t.good_condition_car,
            description: t.lorem_description,
            imagePath: 'assets/images/good_condition_car.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FtGoodCarDetailsScreen(),
                ),
              );
            },
          ),

          const Gap(AppSpacing.md),

          ServiceCard(
            title: t.damaged_car,
            description: t.lorem_description,
            imagePath: 'assets/images/damaged_car.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FtDamagedCarDetailsScreen(),
                ),
              );
            },
          ),
          // Gap(AppSpacing.md),
          // Text(
          //   'Similar Services',
          //   style: TextStyle(
          //     fontSize: 20,
          //     color: Colors.white,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // Gap(AppSpacing.lg),
          // Row(
          //   children: [
          //     SimilarServiceCard(
          //       title: 'Open an Auction',
          //       imagePath: 'assets/images/open_an_auction.png',
          //     ),
          //     Gap(AppSpacing.md),
          //     SimilarServiceCard(
          //       title: 'Sell Your Car',
          //       imagePath: 'assets/images/sell_car.png',
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
