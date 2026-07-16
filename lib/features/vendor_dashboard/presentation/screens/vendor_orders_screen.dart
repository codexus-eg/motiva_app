import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/vendor_checkout_orders/domain/entities/vendor_checkout_order.dart';
import 'package:app/features/vendor_checkout_orders/presentation/providers/vendor_checkout_orders_provider.dart';
import 'package:app/features/vendor_orders/domain/entities/vendor_order.dart';
import 'package:app/features/vendor_orders/presentation/providers/vendor_orders_provider.dart';
import 'package:app/features/vendor_dashboard/presentation/widgets/unified_order_card.dart';
import 'package:app/shared/ui/empty_states/empty_state_widget.dart';
import 'package:app/shared/ui/inputs/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

enum _OrderFilter { all, services, products }

/// Standalone full-screen "All Orders" page (opens from Profile menu).
/// Uses the same A+ unified design as the tab screen.
class VendorOrdersScreen extends ConsumerStatefulWidget {
  const VendorOrdersScreen({super.key});

  @override
  ConsumerState<VendorOrdersScreen> createState() => _VendorOrdersScreenState();
}

class _VendorOrdersScreenState extends ConsumerState<VendorOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  String _searchQuery = '';
  _OrderFilter _filter = _OrderFilter.all;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _setFilter(_OrderFilter f) {
    if (_filter == f) return;
    setState(() {
      _filter = f;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(AppSpacing.lg),
            _buildAppBar(),
            const Gap(AppSpacing.lg),
            _buildSearchBar(),
            const Gap(AppSpacing.md),
            _buildFilterBar(),
            const Gap(AppSpacing.sm),
            _buildTabBar(),
            const Gap(AppSpacing.sm),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: theme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.primary,
                size: 18,
              ),
            ),
          ),
          const Gap(AppSpacing.md),
          Text(
            t.vendor_dashboard.orders.screen_title,
            style: TextStyle(
              color: theme.onSurface,
              fontSize: 26,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    final t = Translations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomSearchBar(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value.toLowerCase();
          });
        },
        hintText: t.vendor_dashboard.orders.search_hint,
        isBuyCar: false,
      ),
    );
  }

  Widget _buildFilterBar() {
    final t = Translations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          _buildFilterChip(
            t.vendor_dashboard.orders.filter_all,
            _OrderFilter.all,
          ),
          const Gap(10),
          _buildFilterChip(
            t.vendor_dashboard.orders.filter_services,
            _OrderFilter.services,
          ),
          const Gap(10),
          _buildFilterChip(
            t.vendor_dashboard.orders.filter_products,
            _OrderFilter.products,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, _OrderFilter filter) {
    final isSelected = _filter == filter;
    return GestureDetector(
      onTap: () => _setFilter(filter),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      indicatorColor: AppColors.secondary,
      dividerColor: Colors.transparent,
      labelColor: theme.onSurface,
      unselectedLabelColor: AppColors.textSecondary,
      labelStyle: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      indicatorSize: TabBarIndicatorSize.label,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      tabAlignment: TabAlignment.start,
      tabs: [
        Tab(text: t.vendor_dashboard.orders.tab_all),
        Tab(text: t.vendor_dashboard.orders.tab_new),
        Tab(text: t.vendor_dashboard.orders.tab_processing),
        Tab(text: t.vendor_dashboard.orders.tab_completed),
      ],
    );
  }

  Widget _buildContent() {
    final serviceAsync = ref.watch(vendorOrdersProvider);
    final productAsync = ref.watch(vendorCheckoutOrdersProvider);

    return serviceAsync.when(
      data: (serviceOrders) {
        return productAsync.when(
          data: (productOrders) {
            return _buildTabBarView(serviceOrders, productOrders);
          },
          loading: () => _buildLoadingState(),
          error: (e, s) => _buildErrorState(e, () {
            ref.invalidate(vendorCheckoutOrdersProvider);
          }),
        );
      },
      loading: () => _buildLoadingState(),
      error: (e, s) => _buildErrorState(e, () {
        ref.invalidate(vendorOrdersProvider);
      }),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }

  Widget _buildTabBarView(
    List<VendorOrder> serviceOrders,
    List<VendorCheckoutOrder> productOrders,
  ) {
    final allOrders = _combineOrders(serviceOrders, productOrders);
    final newOrders = _combineOrders(
      serviceOrders.where((o) => o.isIncoming).toList(),
      productOrders.where((o) => o.isPending).toList(),
    );
    final processingOrders = _combineOrders(
      serviceOrders.where((o) => o.isPending).toList(),
      productOrders
          .where((o) => o.isProcessing || o.isConfirmed || o.isShipped)
          .toList(),
    );
    final completedOrders = _combineOrders(
      serviceOrders.where((o) => o.isCompleted).toList(),
      productOrders.where((o) => o.isDelivered).toList(),
    );

    final t = Translations.of(context);
    return TabBarView(
      controller: _tabController,
      children: [
        _buildOrdersList(allOrders, t.vendor_dashboard.orders.tab_all),
        _buildOrdersList(newOrders, t.vendor_dashboard.orders.tab_new),
        _buildOrdersList(
          processingOrders,
          t.vendor_dashboard.orders.tab_processing,
        ),
        _buildOrdersList(
          completedOrders,
          t.vendor_dashboard.orders.tab_completed,
        ),
      ],
    );
  }

  List<({dynamic order, bool isService})> _combineOrders(
    List<VendorOrder> services,
    List<VendorCheckoutOrder> products,
  ) {
    List<({dynamic order, bool isService})> combined = [];

    if (_filter == _OrderFilter.all || _filter == _OrderFilter.services) {
      for (final o in services) {
        combined.add((order: o, isService: true));
      }
    }

    if (_filter == _OrderFilter.all || _filter == _OrderFilter.products) {
      for (final o in products) {
        combined.add((order: o, isService: false));
      }
    }

    if (_searchQuery.isNotEmpty) {
      combined = combined.where((item) {
        if (item.isService) {
          final o = item.order as VendorOrder;
          return o.orderRef.toLowerCase().contains(_searchQuery) ||
              (o.serviceName?.toLowerCase().contains(_searchQuery) ?? false) ||
              (o.customerName?.toLowerCase().contains(_searchQuery) ?? false);
        } else {
          final o = item.order as VendorCheckoutOrder;
          return o.orderNumber.toLowerCase().contains(_searchQuery);
        }
      }).toList();
    }

    combined.sort((a, b) {
      final aDate = a.isService
          ? (a.order as VendorOrder).createdAt
          : (a.order as VendorCheckoutOrder).createdAt;
      final bDate = b.isService
          ? (b.order as VendorOrder).createdAt
          : (b.order as VendorCheckoutOrder).createdAt;
      return bDate.compareTo(aDate);
    });

    return combined;
  }

  Widget _buildOrdersList(
    List<({dynamic order, bool isService})> orders,
    String tabName,
  ) {
    if (orders.isEmpty) {
      return _buildEmptyState(tabName);
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(vendorOrdersProvider);
        ref.invalidate(vendorCheckoutOrdersProvider);
        await ref.read(vendorOrdersProvider.future);
        await ref.read(vendorCheckoutOrdersProvider.future);
      },
      color: AppColors.primary,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
        itemCount: orders.length,
        separatorBuilder: (context, index) => const Gap(16),
        itemBuilder: (context, index) {
          final item = orders[index];
          return UnifiedOrderCard(
            order: item.order,
            isServiceOrder: item.isService,
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(String tabName) {
    final t = Translations.of(context);
    return EmptyStateWidget(
      icon: Icons.inbox_outlined,
      title: _searchQuery.isNotEmpty
          ? t.vendor_dashboard.orders.empty_search_title
          : t.vendor_dashboard.orders.empty_tab.replaceAll('{tabName}', tabName),
      subtitle: _searchQuery.isNotEmpty
          ? t.vendor_dashboard.orders.empty_search_subtitle
          : t.vendor_dashboard.orders.empty_tab_subtitle,
    );
  }

  Widget _buildErrorState(Object error, VoidCallback onRetry) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: AppColors.red),
            const Gap(AppSpacing.md),
            Text(
              t.vendor_dashboard.orders.error_loading,
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
            const Gap(AppSpacing.lg),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: Text(t.vendor_dashboard.profile.retry),
            ),
          ],
        ),
      ),
    );
  }
}
