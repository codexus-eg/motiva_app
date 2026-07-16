import 'package:app/features/buy_a_car/presentation/screens/approved_cars_screen.dart';
import 'package:app/features/buy_a_car/presentation/screens/damaged_condition_car_screen.dart';
import 'package:app/features/buy_a_car/presentation/screens/good_condition_cars_screen.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/widgets/service_card.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class ServiceBcSection extends StatelessWidget {
  const ServiceBcSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            title: t.buy_a_car.service_section.good_condition_cars,
            description:
                'Lorem ipsum dolor sit amet,\n'
                'consectetur adipiscing elit, sed do\n'
                'eiusmod tempor tempor',
            imagePath: 'assets/images/good_condition_car.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GoodConditionCarsScreen(),
                ),
              );
            },
          ),

          const Gap(AppSpacing.md),

          ServiceCard(
            title: t.buy_a_car.service_section.damaged_cars,
            description:
                'Lorem ipsum dolor sit amet,\n'
                'consectetur adipiscing elit, sed do\n'
                'eiusmod tempor tempor',
            imagePath: 'assets/images/damaged_car.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DamagedConditionCarsScreen(),
                ),
              );
            },
          ),

          const Gap(AppSpacing.md),

          ServiceCard(
            title: t.buy_a_car.service_section.approved_cars,
            description:
                'Lorem ipsum dolor sit amet,\n'
                'consectetur adipiscing elit, sed do\n'
                'eiusmod tempor tempor',
            imagePath: 'assets/images/approved_cars.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ApprovedCarsScreen(),
                ),
              );
            },
          ),

          // const Gap(AppSpacing.md),

          // ServiceCard(
          //   title: 'Live Auctions',
          //   description:
          //       'Lorem ipsum dolor sit amet,\n'
          //       'consectetur adipiscing elit, sed do\n'
          //       'eiusmod tempor tempor',
          //   imagePath: 'assets/images/live_auctions.png',
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }
}
