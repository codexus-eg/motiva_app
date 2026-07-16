import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/user_dashboard/presentation/screens/listing_screen.dart';
import 'package:app/features/user_dashboard/presentation/screens/orders_screen.dart';
// import 'package:app/features/user_dashboard/presentation/screens/requests_screen.dart';
import 'package:app/features/user_dashboard/presentation/screens/loyalty_screen.dart';
import 'package:app/features/user_dashboard/presentation/screens/wallet_screen.dart';
import 'package:app/features/user_dashboard/presentation/widgets/menu_card.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context).user_dashboard.menu;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          MenuCard(
            title: t.wallet,
            icon: 'assets/icons/user_profile/wallet.svg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WalletScreen()),
              );
            },
          ),
          // Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(
          //   title: "Requests",
          //   icon: 'assets/icons/user_profile/requests.svg',
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const RequestsScreen()),
          //     );
          //   },
          // ),
          Divider(color: AppColors.textSecondary, height: 1),
          MenuCard(
            title: t.orders,
            icon: 'assets/icons/user_profile/orders.svg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrdersScreen()),
              );
            },
          ),
          Divider(color: AppColors.textSecondary, height: 1),
          MenuCard(
            title: t.listings,
            icon: 'assets/icons/user_profile/listing.svg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ListingsScreen()),
              );
            },
          ),
          // Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(
          //   title: "Messages",
          //   icon: 'assets/icons/user_profile/messages.svg',
          // ),
          // Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(
          //   title: "Favorites",
          //   icon: 'assets/icons/user_profile/favorites.svg',
          // ),
          Divider(color: AppColors.textSecondary, height: 1),
          MenuCard(
            title: t.loyalty_program,
            icon: 'assets/icons/user_profile/loyalty_program.svg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoyaltyScreen()),
              );
            },
          ),
          // MenuCard(
          //   title: "Reports",
          //   icon: 'assets/icons/user_profile/reports.svg',
          // ),
          // Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(
          //   title: "Be Premium",
          //   icon: 'assets/icons/user_profile/be_premium.svg',
          // ),
          // Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(
          //   title: "Support",
          //   icon: 'assets/icons/user_profile/support.svg',
          // ),
          // Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(title: "FAQs", icon: 'assets/icons/user_profile/faqs.svg'),
          // Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(
          //   title: "Report a problem",
          //   icon: 'assets/icons/user_profile/report_problems.svg',
          // ),
          // Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(
          //   title: "Terms and Conditions",
          //   icon: 'assets/icons/user_profile/terms_and_conditions.svg',
          // ),
          // Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(
          //   title: "About Motors",
          //   icon: 'assets/icons/user_profile/about.svg',
          // ),
        ],
      ),
    );
  }
}
