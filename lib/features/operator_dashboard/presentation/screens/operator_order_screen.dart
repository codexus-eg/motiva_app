import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/operator_orders/presentation/providers/operator_orders_provider.dart';
import 'package:app/features/operator_dashboard/presentation/screens/operator_order_details_screen.dart';
import 'package:app/features/vendor_orders/domain/entities/vendor_order.dart';
import 'package:app/features/vendor_orders/presentation/widgets/status_badge.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:app/core/theme/spacing.dart';

class OperatorOrderScreen extends ConsumerStatefulWidget {
  final bool? isHomePage;

  const OperatorOrderScreen({super.key, this.isHomePage = false});

  @override
  ConsumerState<OperatorOrderScreen> createState() =>
      _OperatorOrderScreenState();
}

class _OperatorOrderScreenState extends ConsumerState<OperatorOrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final operatorOrdersAsync = ref.watch(operatorOrdersProvider);

    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),
            const Gap(AppSpacing.xl),
            _buildTabBar(),
            const Gap(AppSpacing.lg),
            Expanded(
              child: operatorOrdersAsync.when(
                data: (orders) {
                  final activeOrders = orders
                      .where((o) => o.isPending)
                      .toList();
                  final completedOrders = orders
                      .where((o) => o.isCompleted)
                      .toList();
                  final cancelledOrders = orders
                      .where((o) => o.isCancelled || o.isRejected)
                      .toList();

                  return TabBarView(
                    controller: _tabController,
                    children: [
                      _buildOrdersList(activeOrders, 'active'),
                      _buildOrdersList(completedOrders, 'completed'),
                      _buildOrdersList(cancelledOrders, 'cancelled'),
                    ],
                  );
                },
                loading: () => ShimmerSkeletons.listItemSkeleton(),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red[400],
                        size: 48,
                      ),
                      const Gap(AppSpacing.md),
                      Text(
                        'Failed to load orders',
                        style: TextStyle(
                          color: theme.onSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(AppSpacing.sm),
                      Text(
                        error.toString(),
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          if (widget.isHomePage != true) ...[
            Semantics(
              button: true,
              onTapHint: SemanticLabels.backButton,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
            const Gap(AppSpacing.sm),
          ],
          Text(
            'My Orders',
            style: TextStyle(
              color: theme.onSurface,
              fontSize: 26,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ],
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
      labelStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
      tabs: const [
        Tab(text: 'Active'),
        Tab(text: 'Completed'),
        Tab(text: 'Cancelled'),
      ],
    );
  }

  Widget _buildOrdersList(List<VendorOrder> orders, String type) {
    if (orders.isEmpty) {
      return _buildEmptyState(type);
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(operatorOrdersProvider);
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: orders.length,
        separatorBuilder: (context, index) => const Gap(AppSpacing.md),
        itemBuilder: (context, index) {
          final order = orders[index];
          return _OrderCard(order: order);
        },
      ),
    );
  }

  Widget _buildEmptyState(String type) {
    final theme = Theme.of(context).colorScheme;
    String message;
    IconData icon;

    switch (type) {
      case 'active':
        message = 'No active orders';
        icon = Icons.local_shipping_outlined;
        break;
      case 'completed':
        message = 'No completed orders yet';
        icon = Icons.check_circle_outline;
        break;
      case 'cancelled':
        message = 'No cancelled orders';
        icon = Icons.cancel_outlined;
        break;
      default:
        message = 'No orders';
        icon = Icons.inbox_outlined;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.grey[600], size: 64),
          const Gap(AppSpacing.md),
          Text(
            message,
            style: TextStyle(
              color: theme.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final VendorOrder order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      onTapHint: 'View order details',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatusBadge(status: order.statusEnum),
                if (order.scheduledAt != null)
                  _buildScheduledBadge()
                else
                  _buildASAPBadge(),
              ],
            ),
            const Gap(16),
            _buildInfoRow('Order Ref', order.orderRef, context),
            const Gap(8),
            _buildInfoRow('Service', order.serviceName ?? 'N/A', context),
            const Gap(8),
            _buildInfoRow('Customer', order.customerName ?? 'N/A', context),
            const Gap(8),
            _buildInfoRow('Price', order.displayPrice, context),
            if (order.locationAddress != null) ...[
              const Gap(8),
              _buildInfoRow('Location', order.locationAddress!, context),
            ],
            const Gap(16),
            const Divider(color: Color(0xFF3F3F3F), height: 1),
            const Gap(16),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OperatorOrderDetailsScreen(orderId: order.id),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: theme.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'View Details',
                  style: TextStyle(
                    color: theme.primary,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              color: theme.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildScheduledBadge() {
    return Semantics(
      label: SemanticLabels.scheduledBadge,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.schedule, size: 12, color: AppColors.primary),
            const Gap(4),
            Text(
              DateFormat.jm().format(order.scheduledAt!),
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildASAPBadge() {
    return Semantics(
      label: SemanticLabels.asapBadge,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bolt, size: 12, color: Colors.green),
            const Gap(4),
            Text(
              'ASAP',
              style: TextStyle(
                color: Colors.green,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
