import 'package:app/features/cart/presentation/screens/cart_screen.dart';
import 'package:app/features/offers/presentation/screens/offers_screen.dart';
import 'package:app/features/user_dashboard/presentation/screens/user_profile.dart';
import 'package:app/features/user_dashboard/presentation/widgets/home/active_orders_preview.dart';
import 'package:app/shared/ui/status_bar/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/home/presentation/widgets/top_bar.dart';
import 'package:app/features/home/presentation/widgets/premium_banner.dart';
import 'package:app/features/home/presentation/widgets/ad_banners.dart';
import 'package:app/features/home/presentation/widgets/services_grid.dart';
import 'package:app/features/home/presentation/widgets/buy_sell_car_buttons.dart';
import 'package:app/features/home/presentation/widgets/promo_banner.dart';
import 'package:app/features/home/presentation/widgets/listings_section.dart';
import 'package:app/shared/ui/navigation/bottom_nav_bar.dart';
import 'package:app/features/services/presentation/screens/services/services_screen.dart';
import 'package:app/features/customer_orders/presentation/providers/customer_orders_provider.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final int? initialIndex;

  const HomeScreen({super.key, this.initialIndex});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex ?? 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SystemUiWrapper(
      statusBarColor: theme.scaffoldBackgroundColor,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              // Using IndexedStack to preserve state or just conditional rendering
              // For now simple switching:
              _buildBody(),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: BottomNavBar(
                  selectedIndex: _selectedIndex,
                  onTap: _onItemTapped,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_selectedIndex == 1) {
      // Services Screen content (minus the scaffold/nav since we wrap it here)
      // Actually, ServicesScreen has its own Scaffold structure in my previous write.
      // Let's refactor to just return the content or handle it cleanly.
      // Ideally, extract the content of ServicesScreen to a widget or use it directly.
      // Since ServicesScreen duplicates TopBar/Banner, let's look at the design.
      // The design has TopBar, PremiumBanner, AdBanners, then "All Services" grid.
      // It's almost the same top part.
      return const ServicesScreenContent();
    }
    if (_selectedIndex == 2) {
      return const OffersScreen();
    }
    if (_selectedIndex == 3) {
      return const CartScreen();
    }
    if (_selectedIndex == 4) {
      return const UserProfileScreen();
    }

    // Home Screen Content
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(),
          Gap(AppSpacing.lg),
          _buildActiveOrdersSection(),
          Gap(AppSpacing.lg),
          PremiumBanner(),
          Gap(AppSpacing.lg),
          AdBanners(),
          Gap(AppSpacing.lg),
          ServicesGrid(onViewAllPressed: () => _onItemTapped(1)),
          Gap(AppSpacing.lg),
          const BuySellCarButtons(),
          Gap(AppSpacing.lg),
          PromoBanner(),
          Gap(AppSpacing.lg),
          ListingsSection(),
        ],
      ),
    );
  }

  Widget _buildActiveOrdersSection() {
    final activeOrdersAsync = ref.watch(activeOrdersPreviewProvider);

    return activeOrdersAsync.when(
      data: (orders) {
        if (orders.isEmpty) {
          return const SizedBox.shrink();
        }
        return const ActiveOrdersPreview();
      },
      loading: () => const ActiveOrdersPreview(),
      error: (e, s) => const SizedBox.shrink(),
    );
  }
}
