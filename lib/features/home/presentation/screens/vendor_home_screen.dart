import 'dart:async';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/vendor/domain/entities/vendor_profile.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:app/features/vendor/presentation/providers/vendor_provider.dart';
import 'package:app/features/vendor/presentation/providers/vendor_stats_provider.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/vendors_operators_screen.dart';
import 'package:app/features/vendor_dashboard/presentation/widgets/vendor_profile/vendor_profile_header_section.dart';
import 'package:app/features/vendor_dashboard/presentation/widgets/wallet_screen/vendor_completed_jobs_card.dart';
import 'package:app/features/vendor_orders/presentation/providers/vendor_orders_provider.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/vendor_orders_tab_screen.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/vendor_profile_screen.dart';
import 'package:app/features/vendor_dashboard/presentation/widgets/home/active_orders_section.dart';
import 'package:app/features/vendor_dashboard/presentation/widgets/home/vendor_checkout_orders_section.dart';
import 'package:app/features/vendor_checkout_orders/presentation/providers/vendor_checkout_orders_provider.dart';
import 'package:app/features/vendor_dashboard/presentation/widgets/home/quick_stats_card.dart';
import 'package:app/features/vendor_dashboard/presentation/widgets/home/vendor_availability_card.dart';
// import 'package:app/features/vendor_dashboard/presentation/widgets/home/vendor_status_card.dart';
import 'package:app/features/vendor-listings/presentation/screens/vendor_listings_screen.dart';
import 'package:app/features/vendor-products/presentation/providers/vendor_products_provider.dart';
import 'package:app/features/vendor-services/presentation/screens/create_service_screen.dart';
import 'package:app/features/vendor-services/presentation/providers/vendor_services_provider.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/navigation/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class VendorHomeScreen extends ConsumerStatefulWidget {
  const VendorHomeScreen({super.key});

  @override
  ConsumerState<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends ConsumerState<VendorHomeScreen> {
  int _selectedStatTab = 0;
  int _selectedIndex = 0;
  Timer? _refreshTimer;
  bool _isUpdatingAvailability = false;

  @override
  void initState() {
    super.initState();
    _refreshTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      _refreshOrderData();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _refreshOrderData() {
    ref.invalidate(vendorPendingAcceptanceProvider);
    ref.invalidate(vendorTodayScheduleProvider);
    ref.invalidate(vendorActiveOrdersGroupedProvider);
    ref.invalidate(vendorCompletedOrdersProvider);
    ref.invalidate(vendorCheckoutOrdersProvider);
    ref.invalidate(vendorOrdersProvider);
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    _refreshDataForTab(index);
  }

  void _refreshDataForTab(int index) {
    switch (index) {
      case 0:
        _refreshOrderData();
        break;
      case 1:
        ref.invalidate(vendorProductsNotifierProvider);
        ref.invalidate(vendorServicesNotifierProvider);
        break;
      case 2:
        ref.invalidate(vendorOrdersProvider);
        break;
      case 3:
        ref.invalidate(vendorProfileProvider);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            _buildBody(),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: BottomNavBar(
                selectedIndex: _selectedIndex,
                onTap: _onItemTapped,
                isVendor: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return IndexedStack(
      index: _selectedIndex,
      children: [
        _buildHomeTab(),
        const VendorListingsScreen(isHomePage: true,),
        const VendorOrdersTabScreen(),
        const VendorsOperatorsScreen(),
        const VendorProfileScreen(),
      ],
    );
  }

  Widget _buildHomeTab() {
    final profileAsync = ref.watch(vendorProfileProvider);

    return profileAsync.when(
      data: (profile) {
        if (profile == null) {
          return _buildMissingProfileContent();
        }
        return _buildContentWithProfile(profile);
      },
      loading: () => ShimmerSkeletons.screenSkeleton(),
      error: (error, stack) => _buildErrorContent(error),
    );
  }

  Widget _buildContentWithProfile(VendorProfile profile) {
    final activeGroupedAsync = ref.watch(vendorActiveOrdersGroupedProvider);
    final completedAsync = ref.watch(vendorCompletedOrdersProvider);
    final statsAsync = ref.watch(vendorStatsProvider(profile.id));
    final checkoutAsync = ref.watch(vendorCheckoutOrdersProvider);
    final theme = Theme.of(context).colorScheme;
    final profileNotifier = ref.read(vendorProfileProvider.notifier);
    final t = Translations.of(context).home.vendor;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 100, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VendorProfileHeaderSection(),
          const Gap(AppSpacing.xl),
          _buildServicesGrid(),
          const Gap(AppSpacing.lg),
          _buildStatsSection(statsAsync),
          const Gap(AppSpacing.xl),
          Text(
            t.completed_jobs,
            style: GoogleFonts.poppins(
              color: theme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(AppSpacing.md),
          completedAsync.when(
            data: (orders) => VendorCompletedJobsCard(orders: orders),
            loading: () => ShimmerSkeletons.cardSkeleton(height: 100),
            error: (_, _) => const SizedBox.shrink(),
          ),
          const Gap(AppSpacing.xl),
          VendorAvailabilityCard(
            profile: profile,
            isUpdating: _isUpdatingAvailability,
            onAvailabilityChanged: (isAvailable) async {
              setState(() => _isUpdatingAvailability = true);
              try {
                final success = await profileNotifier.updateAvailability(
                  isAvailable,
                );
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        success
                            ? 'Availability updated successfully'
                            : 'Failed to update availability',
                      ),
                      backgroundColor: success ? Colors.green : Colors.red,
                    ),
                  );
                }
              } finally {
                if (mounted) {
                  setState(() => _isUpdatingAvailability = false);
                }
              }
            },
            onCapacityChanged: (orderCapacity) async {
              setState(() => _isUpdatingAvailability = true);
              try {
                final success = await profileNotifier.updateCapacity(
                  orderCapacity,
                );
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        success
                            ? 'Capacity updated successfully'
                            : 'Failed to update capacity',
                      ),
                      backgroundColor: success ? Colors.green : Colors.red,
                    ),
                  );
                }
              } finally {
                if (mounted) {
                  setState(() => _isUpdatingAvailability = false);
                }
              }
            },
          ),
          // const Gap(AppSpacing.xl),
          // VendorStatusCard(
          //   profile: profile,
          //   isUpdating: false,
          //   onStatusChanged: (status) async {
          //     await profileNotifier.updateStatus(status);
          //   },
          // ),
          const Gap(AppSpacing.xl),
          activeGroupedAsync.when(
            data: (grouped) =>
                ActiveOrdersSection(orders: grouped['all'] ?? []),
            loading: () => ShimmerSkeletons.listItemSkeleton(height: 90),
            error: (_, _) => const SizedBox.shrink(),
          ),
          const Gap(AppSpacing.xl),
          checkoutAsync.when(
            data: (orders) => VendorCheckoutOrdersSection(orders: orders),
            loading: () => ShimmerSkeletons.listItemSkeleton(height: 90),
            error: (_, _) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid() {
    final t = Translations.of(context).home.vendor.services_grid;
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 20,
      crossAxisSpacing: 10,
      childAspectRatio: 0.75,
      children: [
        _buildItem(context, t.messages, 'assets/icons/home/message.png', () {}),
        _buildItem(context, t.support, 'assets/icons/home/buy_car.png', () {}),
        _buildItem(context, t.requests, 'assets/icons/home/requests.png', () {
          _onItemTapped(2);
        }),
        _buildItem(context, t.orders, 'assets/icons/home/orders.png', () {
          _onItemTapped(2);
        }),
        _buildItem(context, t.add_services, 'assets/icons/home/hummer.png', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateServiceScreen()),
          );
        }),
        _buildItem(
          context,
          t.current_services,
          'assets/icons/home/current_services.png',
          () {},
        ),
      ],
    );
  }

  Widget _buildItem(
    BuildContext context,
    String label,
    String emoji,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: theme.primaryContainer,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: Image.asset(emoji, width: 52, height: 52)),
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: theme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(AsyncValue statsAsync) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).home.vendor.stats;
    List<String> statTabs = [t.today, t.weekly, t.monthly];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(statTabs.length, (index) {
              final isActive = index == _selectedStatTab;
              return Padding(
                padding: EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedStatTab = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.primary
                          : theme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      statTabs[index],
                      style: GoogleFonts.poppins(
                        color: isActive ? Colors.white : theme.onSurface,
                        fontSize: 13,
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const Gap(AppSpacing.md),
        statsAsync.when(
          data: (stats) => QuickStatsCard(
            totalSales: stats.totalSales,
            totalEarnings: stats.totalEarnings,
            averageRating: stats.averageRating,
            cancellationRate: stats.cancellationRate,
            totalOrders: stats.totalOrders,
            period: statTabs[_selectedStatTab].toLowerCase(),
          ),
          loading: () => ShimmerSkeletons.cardSkeleton(height: 120),
          error: (_, _) => const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildMissingProfileContent() {
    final t = Translations.of(context).home.vendor.empty;
    return Center(child: Text(t));
  }

  Widget _buildErrorContent(Object error) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).home.vendor.error;
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: AppColors.red),
          const Gap(AppSpacing.md),
          Text(
            t,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: theme.onSurface,
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            error.toString(),
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
