import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/vendor_checkout_orders/domain/entities/vendor_checkout_order.dart';
import 'package:app/features/vendor_checkout_orders/domain/entities/vendor_checkout_order_detail.dart';
import 'package:app/features/vendor_checkout_orders/presentation/providers/vendor_checkout_orders_provider.dart';
import 'package:app/features/vendor_checkout_orders/presentation/widgets/checkout_status_badge.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

/// A+ Premium Checkout Order Detail Screen.
/// Clean, spacious, modern delivery app design.
class VendorCheckoutOrderDetailScreen extends ConsumerStatefulWidget {
  final String orderId;

  const VendorCheckoutOrderDetailScreen({super.key, required this.orderId});

  @override
  ConsumerState<VendorCheckoutOrderDetailScreen> createState() =>
      _VendorCheckoutOrderDetailScreenState();
}

class _VendorCheckoutOrderDetailScreenState
    extends ConsumerState<VendorCheckoutOrderDetailScreen> {
  bool _isUpdatingStatus = false;

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(
      vendorCheckoutOrderDetailProvider(widget.orderId),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: detailAsync.when(
        data: (order) => _buildContent(context, order),
        loading: () => _buildLoadingState(),
        error: (error, stack) => _buildErrorState(error),
      ),
    );
  }

  Widget _buildContent(BuildContext context, VendorCheckoutOrderDetail order) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).home.vendor.checkout_orders;
    return Stack(
      children: [
        RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            ref.invalidate(vendorCheckoutOrderDetailProvider(widget.orderId));
            await ref.read(
              vendorCheckoutOrderDetailProvider(widget.orderId).future,
            );
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Compact back button
              SliverToBoxAdapter(
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    child: _buildBackButton(),
                  ),
                ),
              ),
              // Hero header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: _buildHeroHeader(order, theme),
                ),
              ),
              // Status timeline
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: _buildStatusTimeline(order),
                ),
              ),
              // Content cards
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Customer card
                      if (order.customer != null) ...[
                        _buildSectionHeader(t.customer, Icons.person_outline),
                        const Gap(12),
                        _buildCustomerCard(order, theme),
                        const Gap(28),
                      ],
                      // Items card
                      if (order.items.isNotEmpty) ...[
                        _buildSectionHeader(
                          t.order_items,
                          Icons.inventory_2_outlined,
                        ),
                        const Gap(12),
                        _buildItemsCard(order, theme),
                        const Gap(28),
                      ],
                      // Delivery card
                      if (order.deliveryAddress != null) ...[
                        _buildSectionHeader(
                          t.delivery,
                          Icons.local_shipping_outlined,
                        ),
                        const Gap(12),
                        _buildDeliveryCard(order, theme),
                        const Gap(28),
                      ],
                      // Payment card
                      _buildSectionHeader(t.payment, Icons.payment_outlined),
                      const Gap(12),
                      _buildPaymentCard(order, theme),
                      const Gap(28),
                      // Order info
                      _buildSectionHeader(t.order_info, Icons.info_outline),
                      const Gap(12),
                      _buildOrderInfoCard(order, theme),
                      const Gap(28),
                      // Cancellation reason
                      if (order.cancelReason != null) ...[
                        _buildSectionHeader(
                          t.cancellation,
                          Icons.cancel_outlined,
                        ),
                        const Gap(12),
                        _buildCancellationCard(order, theme),
                        const Gap(28),
                      ],
                      // Bottom padding for FAB
                      const Gap(100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Floating action bar at bottom
        if (order.canShip || order.canDeliver)
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: _buildFloatingActionBar(order),
          ),
      ],
    );
  }

  Widget _buildHeroHeader(VendorCheckoutOrderDetail order, ColorScheme theme) {
    final t = Translations.of(context).home.vendor.checkout_orders;
    final statusColor = _getStatusColor(order.status);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [statusColor.withValues(alpha: 0.15), theme.primaryContainer],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.12),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: icon + text left, status right
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: statusColor,
                  size: 20,
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.product_order,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const Gap(2),
                    Text(
                      '#${order.orderNumber}',
                      style: TextStyle(
                        color: theme.onSurface,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              CheckoutStatusBadge(status: order.status),
            ],
          ),
          const Gap(16),
          // Thin divider
          Container(height: 1, color: theme.onSurface.withValues(alpha: 0.06)),
          const Gap(14),
          // Info row: placed date + total
          Row(
            children: [
              Expanded(
                child: _buildHeroInfo(
                  icon: Icons.calendar_today_outlined,
                  label: t.placed,
                  value: DateFormat('MMM d, yyyy').format(order.createdAt),
                ),
              ),
              Container(
                width: 1,
                height: 36,
                color: theme.onSurface.withValues(alpha: 0.06),
              ),
              Expanded(
                child: _buildHeroInfo(
                  icon: Icons.payments_outlined,
                  label: t.total,
                  value: order.displayPrice,
                  valueColor: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroInfo({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 13, color: AppColors.textSecondary),
            const Gap(5),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF757575),
                fontSize: 11,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
        const Gap(4),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? const Color(0xFFE8E8E8),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget _buildStatusTimeline(VendorCheckoutOrderDetail order) {
    final t = Translations.of(context).home.vendor.checkout_orders;
    final steps = [
      (
        t.timeline.pending,
        t.timeline.pending_sublabel,
        order.isPending ||
            order.isProcessing ||
            order.isConfirmed ||
            order.isShipped ||
            order.isDelivered,
      ),
      (
        t.timeline.processing,
        t.timeline.processing_sublabel,
        order.isProcessing ||
            order.isConfirmed ||
            order.isShipped ||
            order.isDelivered,
      ),
      (
        t.timeline.shipped,
        t.timeline.shipped_sublabel,
        order.isShipped || order.isDelivered,
      ),
      (t.timeline.delivered, t.timeline.delivered_sublabel, order.isDelivered),
    ];

    final currentIndex = order.isDelivered
        ? 3
        : order.isShipped
        ? 2
        : order.isConfirmed || order.isProcessing
        ? 1
        : 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.status_timeline,
            style: TextStyle(
              color: Color(0xFFE8E8E8),
              fontSize: 15,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          const Gap(20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: steps.asMap().entries.map((entry) {
              final index = entry.key;
              final (label, sublabel, isActive) = entry.value;
              final isCurrent = index == currentIndex;
              final isPast = index < currentIndex;

              return Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isActive
                                  ? (isCurrent
                                        ? AppColors.primary
                                        : AppColors.primary.withValues(
                                            alpha: 0.3,
                                          ))
                                  : const Color(0xFF3A3A3A),
                            ),
                            child: Center(
                              child: isPast
                                  ? const Icon(
                                      Icons.check,
                                      size: 14,
                                      color: Colors.white,
                                    )
                                  : Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: isActive
                                            ? Colors.white
                                            : AppColors.textSecondary,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                          const Gap(8),
                          Text(
                            label,
                            style: TextStyle(
                              color: isActive
                                  ? const Color(0xFFE8E8E8)
                                  : AppColors.textSecondary,
                              fontSize: 11,
                              fontWeight: isCurrent
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Gap(2),
                          Text(
                            sublabel,
                            style: TextStyle(
                              color: AppColors.textSecondary.withValues(
                                alpha: 0.6,
                              ),
                              fontSize: 9,
                              fontFamily: 'Poppins',
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (index < steps.length - 1)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 13),
                          child: Container(
                            height: 2,
                            color: isPast
                                ? AppColors.primary.withValues(alpha: 0.3)
                                : const Color(0xFF3A3A3A),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const Gap(10),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFE8E8E8),
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget _buildItemsCard(VendorCheckoutOrderDetail order, ColorScheme theme) {
    final t = Translations.of(context).home.vendor.checkout_orders;
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          for (int i = 0; i < order.items.length; i++) ...[
            if (i > 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  color: theme.onSurface.withValues(alpha: 0.05),
                  height: 1,
                ),
              ),
            _buildItemRow(order.items[i], theme),
          ],
          // Total row
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${t.total} (${order.items.length} ${order.items.length == 1 ? t.item : t.items_count})',
                  style: const TextStyle(
                    color: Color(0xFFB9B9B9),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  order.displayPrice,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(VendorCheckoutOrderItem item, ColorScheme theme) {
    final subtotal = (double.parse(item.unitPrice) * item.quantity)
        .toStringAsFixed(3);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Product icon - smaller
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(
                Icons.inventory_2_outlined,
                size: 18,
                color: AppColors.primary,
              ),
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: TextStyle(
                    color: theme.onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                const Gap(3),
                Text(
                  '${item.quantity} x KD ${item.unitPrice}',
                  style: const TextStyle(
                    color: Color(0xFFB9B9B9),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          Text(
            'KD $subtotal',
            style: TextStyle(
              color: theme.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryCard(
    VendorCheckoutOrderDetail order,
    ColorScheme theme,
  ) {
    final t = Translations.of(context).home.vendor.checkout_orders;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF3D5A80).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: Color(0xFF8BB8E8),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.delivery_address,
                      style: TextStyle(
                        color: Color(0xFFE8E8E8),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const Gap(6),
                    Text(
                      order.deliveryAddress?.formattedAddress ??
                          t.no_address_provided,
                      style: const TextStyle(
                        color: Color(0xFFB9B9B9),
                        fontSize: 13,
                        height: 1.5,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (order.deliveryAddress?.notes != null &&
              order.deliveryAddress!.notes!.isNotEmpty) ...[
            const Gap(14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE28C37).withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.note_alt_outlined,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const Gap(8),
                  Expanded(
                    child: Text(
                      order.deliveryAddress!.notes!,
                      style: const TextStyle(
                        color: Color(0xFFE8E8E8),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentCard(VendorCheckoutOrderDetail order, ColorScheme theme) {
    final t = Translations.of(context).home.vendor.checkout_orders;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.payments_outlined,
              size: 18,
              color: Colors.green,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatPaymentMethod(order.paymentMethod),
                  style: const TextStyle(
                    color: Color(0xFFE8E8E8),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                const Gap(3),
                Text(
                  '${t.payment_status}: ${order.isDelivered ? t.payment_paid : t.payment_pending}',
                  style: const TextStyle(
                    color: Color(0xFFB9B9B9),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderInfoCard(
    VendorCheckoutOrderDetail order,
    ColorScheme theme,
  ) {
    final t = Translations.of(context).home.vendor.checkout_orders;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildInfoRow(t.order_id, order.id.substring(0, 8).toUpperCase()),
          const Gap(10),
          _buildInfoRow(
            t.placed_on,
            DateFormat('MMM d, yyyy · h:mm a').format(order.createdAt),
          ),
          if (order.updatedAt != null) ...[
            const Gap(10),
            _buildInfoRow(
              t.last_updated,
              DateFormat('MMM d, yyyy · h:mm a').format(order.updatedAt!),
            ),
          ],
          if (order.estimatedDelivery != null) ...[
            const Gap(10),
            _buildInfoRow(t.est_delivery, order.estimatedDelivery!),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF757575),
            fontSize: 12,
            fontFamily: 'Poppins',
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFFE8E8E8),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget _buildCancellationCard(
    VendorCheckoutOrderDetail order,
    ColorScheme theme,
  ) {
    final t = Translations.of(context).home.vendor.checkout_orders;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red.withValues(alpha: 0.15), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.cancel_outlined,
              size: 16,
              color: Colors.red,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.cancellation_reason,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                const Gap(5),
                Text(
                  order.cancelReason ?? t.no_reason_provided,
                  style: const TextStyle(
                    color: Color(0xFFB9B9B9),
                    fontSize: 13,
                    height: 1.5,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(
    VendorCheckoutOrderDetail order,
    ColorScheme theme,
  ) {
    final customer = order.customer!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF3D5A80).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.person_outline,
              size: 20,
              color: Color(0xFF8BB8E8),
            ),
          ),
          const Gap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.fullName,
                  style: TextStyle(
                    color: theme.onSurface,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                if (customer.phone != null && customer.phone!.isNotEmpty) ...[
                  const Gap(4),
                  Text(
                    customer.phone!,
                    style: const TextStyle(
                      color: Color(0xFFB9B9B9),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionBar(VendorCheckoutOrderDetail order) {
    final t = Translations.of(context).home.vendor.checkout_orders;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.surface.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.08),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              if (order.canShip)
                Expanded(
                  child: _buildActionButton(
                    label: t.mark_shipped,
                    icon: Icons.local_shipping_outlined,
                    onTap: () => _handleStatusUpdate(order.id, 'shipped'),
                    isPrimary: true,
                  ),
                ),
              if (order.canDeliver) ...[
                if (order.canShip) const Gap(10),
                Expanded(
                  child: _buildActionButton(
                    label: t.mark_delivered,
                    icon: Icons.check_circle_outline,
                    onTap: () => _handleStatusUpdate(order.id, 'delivered'),
                    isPrimary: !order.canShip,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    return GestureDetector(
      onTap: _isUpdatingStatus ? null : onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: isPrimary
              ? null
              : Border.all(
                  color: AppColors.primary.withValues(alpha: 0.5),
                  width: 1.5,
                ),
        ),
        child: _isUpdatingStatus
            ? const Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 16,
                    color: isPrimary ? Colors.white : AppColors.primary,
                  ),
                  const Gap(6),
                  Text(
                    label,
                    style: TextStyle(
                      color: isPrimary ? Colors.white : AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primary,
            size: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    final t = Translations.of(context).home.vendor.checkout_orders;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 3,
              ),
            ),
          ),
          const Gap(16),
          Text(
            t.loading_order,
            style: TextStyle(
              color: Color(0xFFB9B9B9),
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).home.vendor.checkout_orders;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.error_outline,
                size: 32,
                color: AppColors.red,
              ),
            ),
            const Gap(20),
            Text(
              t.failed_to_load,
              style: TextStyle(
                color: theme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const Gap(6),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFB9B9B9),
                fontSize: 13,
                fontFamily: 'Poppins',
              ),
            ),
            const Gap(28),
            ElevatedButton.icon(
              onPressed: () {
                ref.invalidate(
                  vendorCheckoutOrderDetailProvider(widget.orderId),
                );
              },
              icon: const Icon(Icons.refresh, size: 18),
              label: Text(t.try_again),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleStatusUpdate(String orderId, String status) async {
    final t = Translations.of(context).home.vendor.checkout_orders;
    setState(() => _isUpdatingStatus = true);
    try {
      await ref
          .read(updateCheckoutOrderStatusNotifierProvider.notifier)
          .updateStatus(orderId, status);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white, size: 18),
                const Gap(10),
                Text(
                  status == 'shipped'
                      ? t.order_shipped_success
                      : t.order_delivered_success,
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${t.failed}: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isUpdatingStatus = false);
    }
  }

  String _formatPaymentMethod(
    String? method,
  ) {
    final t = Translations.of(context).home.vendor.checkout_orders;
    if (method == null) return t.not_specified;
    switch (method.toLowerCase()) {
      case 'cod':
        return t.cash_on_delivery;
      case 'card':
        return t.credit_debit_card;
      default:
        return method;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'confirmed':
        return Colors.indigo;
      case 'shipped':
        return Colors.teal;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
