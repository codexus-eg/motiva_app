import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/vendor_request_details_screen.dart';
import 'package:app/features/vendor_orders/domain/entities/vendor_order.dart';
import 'package:app/features/vendor_orders/domain/entities/vendor_order_status.dart';
import 'package:app/features/vendor_orders/presentation/widgets/status_badge.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:app/core/theme/spacing.dart';

class ActiveOrdersSection extends ConsumerStatefulWidget {
  final List<VendorOrder> orders;

  const ActiveOrdersSection({super.key, required this.orders});

  @override
  ConsumerState<ActiveOrdersSection> createState() =>
      _ActiveOrdersSectionState();
}

class _ActiveOrdersSectionState extends ConsumerState<ActiveOrdersSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<VendorOrder> _filterByStatus(List<VendorOrderStatus> statuses) {
    return widget.orders.where((o) => statuses.contains(o.statusEnum)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final allActive = widget.orders;
    final enRoute = _filterByStatus([VendorOrderStatus.enRoute]);
    final arrived = _filterByStatus([VendorOrderStatus.arrived]);
    final inProgress = _filterByStatus([VendorOrderStatus.inProgress]);
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).home.vendor.active_orders;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.title,
              style: TextStyle(
                color: theme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${allActive.length}',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            indicatorColor: AppColors.primary,
            indicatorWeight: 3,
            labelColor: theme.onSurface,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
            tabs: [
              Tab(text: '${t.all} (${allActive.length})'),
              Tab(text: '${t.en_route} (${enRoute.length})'),
              Tab(text: '${t.arrived} (${arrived.length})'),
              Tab(text: '${t.in_progress} (${inProgress.length})'),
            ],
          ),
        ),
        SizedBox(
          height: 280,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildOrdersList(allActive),
              _buildOrdersList(enRoute),
              _buildOrdersList(arrived),
              _buildOrdersList(inProgress),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrdersList(List<VendorOrder> orders) {
    if (orders.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: orders.length,
      separatorBuilder: (_, _) => const Gap(AppSpacing.md),
      itemBuilder: (context, index) {
        return SizedBox(
          width: 200,
          child: _OrderCompactCard(order: orders[index]),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    final t = Translations.of(context).home.vendor.active_orders;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, color: Colors.grey[600], size: 32),
          const Gap(AppSpacing.sm),
          Text(
            t.empty,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderCompactCard extends StatelessWidget {
  final VendorOrder order;

  const _OrderCompactCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).home.vendor.active_orders;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VendorRequestDetailsScreen(orderId: order.id),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatusBadge(status: order.statusEnum),
            const Gap(AppSpacing.md),
            Text(
              order.serviceName ?? t.service,
              style: TextStyle(
                color: theme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(AppSpacing.xs),
            Text(
              order.customerName ?? t.customer,
              style: const TextStyle(
                color: Color(0xFFB9B9B9),
                fontSize: 12,
                fontFamily: 'Poppins',
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            if (order.scheduledAt != null)
              _buildScheduledBadge()
            else
              _buildASAPBadge(context),
            const Gap(AppSpacing.sm),
            Text(
              order.displayPrice,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduledBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule, size: 12, color: AppColors.primary),
          const Gap(AppSpacing.xs),
          Text(
            DateFormat.jm().format(order.scheduledAt!.toLocal()),
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildASAPBadge(BuildContext context) {
    final t = Translations.of(context).home.vendor.active_orders;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt, size: 12, color: Colors.green),
          const Gap(AppSpacing.xs),
          Text(
            t.asap,
            style: TextStyle(
              color: Colors.green,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
