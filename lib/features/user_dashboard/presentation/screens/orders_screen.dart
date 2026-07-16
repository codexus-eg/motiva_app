import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/features/customer_checkout_orders/domain/entities/checkout_order.dart';
import 'package:app/features/customer_checkout_orders/presentation/providers/checkout_orders_provider.dart';
import 'package:app/features/customer_orders/data/models/customer_order_model.dart';
import 'package:app/features/customer_orders/domain/entities/customer_order.dart';
import 'package:app/features/customer_orders/presentation/providers/customer_orders_provider.dart';
import 'package:app/features/user_dashboard/presentation/widgets/orders_screen/unified_customer_order_card.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/empty_states/empty_state_widget.dart';
import 'package:app/shared/ui/inputs/custom_search_bar.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

enum _OrderFilter { all, services, products }

/// Unified customer orders screen combining service and product orders.
class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  String _searchQuery = '';
  _OrderFilter _filter = _OrderFilter.all;
  String? _expandedProductId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (mounted) {
        setState(() {
          _expandedProductId = null;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.invalidate(checkoutOrdersProvider);
    ref.invalidate(customerOrdersProvider);
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
      _expandedProductId = null;
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
    final t = Translations.of(context).user_dashboard.orders;
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
            t.screen_title,
            style: TextStyle(
              color: theme.onSurface,
              fontSize: 26,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            'assets/icons/nav_cart.svg',
            colorFilter: ColorFilter.mode(theme.onSurface, BlendMode.srcIn),
            height: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    final t = Translations.of(context).user_dashboard.orders;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomSearchBar(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value.toLowerCase();
            _expandedProductId = null;
          });
        },
        hintText: t.search_hint,
        isBuyCar: false,
      ),
    );
  }

  Widget _buildFilterBar() {
    final t = Translations.of(context).user_dashboard.orders;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          _buildFilterChip(t.filter_all, _OrderFilter.all),
          const Gap(10),
          _buildFilterChip(t.filter_service, _OrderFilter.services),
          const Gap(10),
          _buildFilterChip(t.filter_product, _OrderFilter.products),
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
        Tab(text: Translations.of(context).user_dashboard.orders.tab_all),
        Tab(text: Translations.of(context).user_dashboard.orders.tab_active),
        Tab(text: Translations.of(context).user_dashboard.orders.tab_completed),
      ],
    );
  }

  Widget _buildContent() {
    final serviceAsync = ref.watch(customerOrdersProvider);
    final productAsync = ref.watch(checkoutOrdersProvider);

    return serviceAsync.when(
      data: (serviceOrders) {
        return productAsync.when(
          data: (productOrders) {
            return _buildTabBarView(serviceOrders, productOrders);
          },
          loading: () => _buildLoadingState(),
          error: (e, s) => _buildErrorState(e, () {
            ref.invalidate(checkoutOrdersProvider);
          }),
        );
      },
      loading: () => _buildLoadingState(),
      error: (e, s) => _buildErrorState(e, () {
        ref.invalidate(customerOrdersProvider);
      }),
    );
  }

  Widget _buildLoadingState() {
    return ShimmerSkeletons.cardSkeleton();
  }

  Widget _buildTabBarView(
    List<CustomerOrderModel> serviceOrders,
    List<CheckoutOrder> productOrders,
  ) {
    final allOrders = _combineOrders(serviceOrders, productOrders);
    final activeOrders = _combineOrders(
      serviceOrders.where((o) => _isServiceActive(o)).toList(),
      productOrders.where((o) => _isProductActive(o)).toList(),
    );
    final completedOrders = _combineOrders(
      serviceOrders.where((o) => _isServiceCompleted(o)).toList(),
      productOrders.where((o) => _isProductCompleted(o)).toList(),
    );

    return TabBarView(
      controller: _tabController,
      children: [
        _buildOrdersList(
          allOrders,
          Translations.of(context).user_dashboard.orders.tab_all,
        ),
        _buildOrdersList(
          activeOrders,
          Translations.of(context).user_dashboard.orders.tab_active,
        ),
        _buildOrdersList(
          completedOrders,
          Translations.of(context).user_dashboard.orders.tab_completed,
        ),
      ],
    );
  }

  List<({dynamic order, bool isService})> _combineOrders(
    List<CustomerOrderModel> services,
    List<CheckoutOrder> products,
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
          final o = item.order as CustomerOrder;
          return o.orderRef.toLowerCase().contains(_searchQuery) ||
              (o.serviceName?.toLowerCase().contains(_searchQuery) ?? false) ||
              (o.vendorName?.toLowerCase().contains(_searchQuery) ?? false);
        } else {
          final o = item.order as CheckoutOrder;
          return o.orderNumber.toLowerCase().contains(_searchQuery) ||
              o.itemsSummary.any(
                (i) => i.productName.toLowerCase().contains(_searchQuery),
              );
        }
      }).toList();
    }

    combined.sort((a, b) {
      final aDate = a.isService
          ? (a.order as CustomerOrder).createdAt
          : (a.order as CheckoutOrder).createdAt;
      final bDate = b.isService
          ? (b.order as CustomerOrder).createdAt
          : (b.order as CheckoutOrder).createdAt;
      return bDate.compareTo(aDate);
    });

    return combined;
  }

  bool _isServiceActive(CustomerOrder o) {
    return o.status == CustomerOrderStatus.pendingAcceptance ||
        o.status == CustomerOrderStatus.accepted ||
        o.status == CustomerOrderStatus.enRoute ||
        o.status == CustomerOrderStatus.arrived ||
        o.status == CustomerOrderStatus.inProgress;
  }

  bool _isServiceCompleted(CustomerOrder o) {
    return o.status == CustomerOrderStatus.completed;
  }

  bool _isProductActive(CheckoutOrder o) {
    return o.status == 'pending' ||
        o.status == 'processing' ||
        o.status == 'confirmed' ||
        o.status == 'shipped';
  }

  bool _isProductCompleted(CheckoutOrder o) {
    return o.status == 'delivered';
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
        ref.invalidate(customerOrdersProvider);
        ref.invalidate(checkoutOrdersProvider);
        await ref.read(customerOrdersProvider.future);
        await ref.read(checkoutOrdersProvider.future);
      },
      color: AppColors.primary,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
        itemCount: orders.length,
        separatorBuilder: (context, index) => const Gap(16),
        itemBuilder: (context, index) {
          final item = orders[index];
          final isProduct = !item.isService;
          final productId = isProduct ? (item.order as CheckoutOrder).id : null;
          return UnifiedCustomerOrderCard(
            order: item.order,
            isServiceOrder: item.isService,
            isExpanded: isProduct && _expandedProductId == productId,
            onToggle: isProduct
                ? () {
                    setState(() {
                      if (_expandedProductId == productId) {
                        _expandedProductId = null;
                      } else {
                        _expandedProductId = productId;
                      }
                    });
                  }
                : null,
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(String tabName) {
    final t = Translations.of(context).user_dashboard.orders.empty;
    return EmptyStateWidget(
      icon: Icons.inbox_outlined,
      title: _searchQuery.isNotEmpty
          ? t.no_results
          : t.no_tab_orders.replaceAll('{tabName}', tabName),
      subtitle: _searchQuery.isNotEmpty
          ? t.adjust_search
          : t.orders_appear_here,
    );
  }

  Widget _buildErrorState(Object error, VoidCallback onRetry) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).user_dashboard.orders.error;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: AppColors.red),
            const Gap(AppSpacing.md),
            Text(
              t.title,
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
              child: Text(t.retry),
            ),
          ],
        ),
      ),
    );
  }
}
