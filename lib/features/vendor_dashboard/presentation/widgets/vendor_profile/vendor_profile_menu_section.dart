import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/user_dashboard/presentation/widgets/menu_card.dart';
import 'package:app/features/vendor-listings/presentation/screens/vendor_listings_screen.dart';
import 'package:app/features/vendor-products/presentation/screens/inventory_transactions_screen.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/vendor_orders_screen.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/vendor_support_screen.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/vendor_wallet_screen.dart';
import 'package:flutter/material.dart';

class VendorProfileMenuSection extends StatelessWidget {
  const VendorProfileMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).vendor_dashboard.profile_menu;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          MenuCard(
            title: t.all_orders,
            icon: 'assets/icons/user_profile/requests.svg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VendorOrdersScreen(),
                ),
              );
            },
          ),
          const Divider(color: AppColors.textSecondary, height: 1),
          MenuCard(
            title: t.my_listings,
            icon: 'assets/icons/user_profile/listing.svg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VendorListingsScreen(),
                ),
              );
            },
          ),
          const Divider(color: AppColors.textSecondary, height: 1),
          MenuCard(
            title: t.inventory_history,
            icon: 'assets/icons/user_profile/listing.svg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InventoryTransactionsScreen(),
                ),
              );
            },
          ),
          // const Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(
          //   title: "Reviews and Ratings",
          //   icon: 'assets/icons/user_profile/listing.svg',
          // ),
          const Divider(color: AppColors.textSecondary, height: 1),
          MenuCard(
            title: t.wallet,
            icon: 'assets/icons/user_profile/wallet.svg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VendorWalletScreen(),
                ),
              );
            },
          ),
          // const Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(
          //   title: "Service Management",
          //   icon: 'assets/icons/user_profile/orders.svg',
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const VendorServicesScreen(),
          //       ),
          //     );
          //   },
          // ),
          // const Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(
          //   title: "Support",
          //   icon: 'assets/icons/user_profile/support.svg',
          // ),
          // const Divider(color: AppColors.textSecondary, height: 1),
          // const Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(
          //   title: "Messages",
          //   icon: 'assets/icons/user_profile/messages.svg',
          // ),
          // const Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(
          //   title: "Favorites",
          //   icon: 'assets/icons/user_profile/favorites.svg',
          // ),
          // const Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(
          //   title: "Loyalty Program",
          //   icon: 'assets/icons/user_profile/loyalty_program.svg',
          // ),
          // const Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(
          //   title: "Reports",
          //   icon: 'assets/icons/user_profile/reports.svg',
          // ),
          // const Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(
          //   title: "Be Premium",
          //   icon: 'assets/icons/user_profile/be_premium.svg',
          // ),
          const Divider(color: AppColors.textSecondary, height: 1),
          MenuCard(
            title: t.faqs,
            icon: 'assets/icons/user_profile/faqs.svg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VendorSupportScreen(),
                ),
              );
            },
          ),
          // const Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(
          //   title: "Report a problem",
          //   icon: 'assets/icons/user_profile/report_problems.svg',
          // ),
          // const Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(
          //   title: "Terms and Conditions",
          //   icon: 'assets/icons/user_profile/terms_and_conditions.svg',
          // ),
          // const Divider(color: AppColors.textSecondary, height: 1),
          // MenuCard(
          //   title: "About Motors",
          //   icon: 'assets/icons/user_profile/about.svg',
          // ),
        ],
      ),
    );
  }
}
