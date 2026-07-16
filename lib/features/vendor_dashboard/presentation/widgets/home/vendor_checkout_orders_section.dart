import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/vendor_checkout_orders/domain/entities/vendor_checkout_order.dart';
import 'package:app/features/vendor_checkout_orders/presentation/providers/vendor_checkout_orders_provider.dart';
import 'package:app/features/vendor_checkout_orders/presentation/widgets/checkout_status_badge.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class VendorCheckoutOrdersSection extends ConsumerStatefulWidget {
  final List<VendorCheckoutOrder> orders;

  const VendorCheckoutOrdersSection({super.key, required this.orders});

  @override
  ConsumerState<VendorCheckoutOrdersSection> createState() =>
      _VendorCheckoutOrdersSectionState();
}

class _VendorCheckoutOrdersSectionState
    extends ConsumerState<VendorCheckoutOrdersSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<VendorCheckoutOrder> _filterByStatus(List<String> statuses) {
    return widget.orders.where((o) => statuses.contains(o.status)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final all = widget.orders;
    final pending = _filterByStatus(['pending']);
    final processing = _filterByStatus(['processing']);
    final confirmed = _filterByStatus(['confirmed']);
    final shipped = _filterByStatus(['shipped']);
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).home.vendor.checkout_orders;

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
                '${all.length}',
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
            isScrollable: true,
            labelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
            tabs: [
              Tab(text: '${t.all} (${all.length})'),
              Tab(text: '${t.pending} (${pending.length})'),
              Tab(text: '${t.processing} (${processing.length})'),
              Tab(text: '${t.confirmed} (${confirmed.length})'),
              Tab(text: '${t.shipped} (${shipped.length})'),
            ],
          ),
        ),
        SizedBox(
          height: 280,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildOrdersList(all),
              _buildOrdersList(pending),
              _buildOrdersList(processing),
              _buildOrdersList(confirmed),
              _buildOrdersList(shipped),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrdersList(List<VendorCheckoutOrder> orders) {
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
          child: _CheckoutOrderCompactCard(order: orders[index]),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    final t = Translations.of(context).home.vendor.checkout_orders;
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

class _CheckoutOrderCompactCard extends ConsumerWidget {
  final VendorCheckoutOrder order;

  const _CheckoutOrderCompactCard({required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).home.vendor.checkout_orders;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CheckoutStatusBadge(status: order.status),
          const Gap(AppSpacing.md),
          Text(
            '${t.order_number}${order.orderNumber}',
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
            '${order.itemsCount} ${t.items_count}',
            style: const TextStyle(
              color: Color(0xFFB9B9B9),
              fontSize: 12,
              fontFamily: 'Poppins',
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Text(
            order.displayPrice,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          const Gap(AppSpacing.sm),
          if (order.canShip || order.canDeliver)
            _buildActionButtons(context, ref),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context).home.vendor.checkout_orders;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (order.canShip)
          _ActionButton(
            label: t.ship,
            color: AppColors.primary,
            onTap: () => _handleShip(context, ref),
          ),
        if (order.canDeliver)
          _ActionButton(
            label: t.deliver,
            color: Colors.green,
            onTap: () => _handleDeliver(context, ref),
          ),
      ],
    );
  }

  Future<void> _handleShip(BuildContext context, WidgetRef ref) async {
    await ref
        .read(updateCheckoutOrderStatusNotifierProvider.notifier)
        .updateStatus(order.id, 'shipped');
  }

  Future<void> _handleDeliver(BuildContext context, WidgetRef ref) async {
    await ref
        .read(updateCheckoutOrderStatusNotifierProvider.notifier)
        .updateStatus(order.id, 'delivered');
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 6),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color, width: 1),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }
}
