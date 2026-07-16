import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/features/customer_checkout_orders/domain/entities/checkout_order_detail.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/customer_checkout_orders/presentation/providers/checkout_orders_provider.dart';
import 'package:app/features/customer_orders/presentation/widgets/order_detail_section.dart';

class ProductOrderDetailsScreen extends ConsumerStatefulWidget {
  final String orderId;

  const ProductOrderDetailsScreen({super.key, required this.orderId});

  @override
  ConsumerState<ProductOrderDetailsScreen> createState() =>
      _ProductOrderDetailsScreenState();
}

class _ProductOrderDetailsScreenState
    extends ConsumerState<ProductOrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(checkoutOrderDetailProvider(widget.orderId));
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: detailAsync.when(
        loading: () => ShimmerSkeletons.screenSkeleton(),
        error: (error, _) => _buildErrorState(error, theme),
        data: (detail) => _buildContent(detail, theme),
      ),
    );
  }

  Widget _buildErrorState(Object error, ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const Gap(AppSpacing.md),
            Text(
              t.user_dashboard.orders.details.failed_to_load,
              style: GoogleFonts.poppins(color: Colors.red, fontSize: 16),
            ),
            const Gap(AppSpacing.sm),
            Text(
              error.toString(),
              style: GoogleFonts.poppins(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.54),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(AppSpacing.lg),
            ElevatedButton(
              onPressed: () =>
                  ref.invalidate(checkoutOrderDetailProvider(widget.orderId)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(t.user_dashboard.orders.error.retry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(CheckoutOrderDetail detail, ThemeData theme) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildAppBar(theme)),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(AppSpacing.md),
                        _buildHeroHeader(detail, theme),
                        const Gap(AppSpacing.lg),
                        _buildOrderInfoCard(detail, theme),
                        const Gap(AppSpacing.lg),
                        if (detail
                            .deliveryAddress
                            .formattedAddress
                            .isNotEmpty) ...[
                          _buildDeliveryAddressCard(detail, theme),
                          const Gap(AppSpacing.lg),
                        ],
                        _buildItemsCard(detail, theme),
                        const Gap(AppSpacing.lg),
                        _buildPaymentSummaryCard(detail, theme),
                        const Gap(AppSpacing.lg),
                        _buildTimelineCard(detail, theme),
                        const Gap(AppSpacing.lg),
                        if (detail.cancelReason != null) ...[
                          _buildReasonCard(
                            t.user_dashboard.orders.details.cancellation_reason,
                            detail.cancelReason!,
                            Colors.orange,
                            theme,
                          ),
                          const Gap(AppSpacing.lg),
                        ],
                        const Gap(AppSpacing.xl),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildBottomActions(detail, theme),
        ],
      ),
    );
  }

  Widget _buildAppBar(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.orange,
                size: 18,
              ),
            ),
          ),
          const Gap(AppSpacing.md),
          Expanded(
            child: Text(
              t.user_dashboard.orders.details.screen_title_product,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          IconButton(
            onPressed: () =>
                ref.invalidate(checkoutOrderDetailProvider(widget.orderId)),
            icon: Icon(
              Icons.refresh,
              color: theme.colorScheme.onSurface,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(CheckoutOrderDetail detail, ThemeData theme) {
    final statusColor = _getStatusColor(detail.status);
    final statusText = _getStatusDisplay(detail.status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            statusColor.withValues(alpha: 0.2),
            theme.colorScheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(AppSpacing.xs),
                    Text(
                      statusText,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                '#${detail.orderNumber}',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.lg),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: AppColors.orange,
                    size: 32,
                  ),
                ),
              ),
              const Gap(AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detail.vendorName ??
                          t.user_dashboard.orders.card.product_order,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(AppSpacing.xs),
                    Text(
                      '${detail.items.length} ${detail.items.length == 1 ? t.user_dashboard.orders.card.item : t.user_dashboard.orders.card.items}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                    const Gap(AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.orange.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'KWD ${detail.totalAmount}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderInfoCard(CheckoutOrderDetail detail, ThemeData theme) {
    return OrderDetailSection(
      title: t.user_dashboard.orders.details.order_information,
      icon: Icons.receipt_long,
      children: [
        OrderInfoRow(
          label: t.user_dashboard.orders.card.order_id,
          value: detail.orderNumber,
        ),
        const Divider(height: 24, color: Color(0xFF383A42)),
        OrderInfoRow(
          label: t.user_dashboard.orders.details.order_date,
          value: DateFormat(
            'EEEE, MMM d, yyyy',
          ).format(detail.createdAt.toLocal()),
        ),
        if (detail.estimatedDelivery != null) ...[
          const Divider(height: 24, color: Color(0xFF383A42)),
          OrderInfoRow(
            label: t.checkout.estimated_delivery,
            value: detail.estimatedDelivery!,
          ),
        ],
        if (detail.vendorName != null) ...[
          const Divider(height: 24, color: Color(0xFF383A42)),
          OrderInfoRow(
            label: t.user_dashboard.orders.details.vendor,
            value: detail.vendorName!,
          ),
        ],
      ],
    );
  }

  Widget _buildDeliveryAddressCard(
    CheckoutOrderDetail detail,
    ThemeData theme,
  ) {
    return OrderDetailSection(
      title: t.user_dashboard.orders.card.delivery_address,
      icon: Icons.location_on,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.place, color: AppColors.orange, size: 20),
            const Gap(AppSpacing.sm),
            Expanded(
              child: Text(
                detail.deliveryAddress.formattedAddress,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildItemsCard(CheckoutOrderDetail detail, ThemeData theme) {
    return OrderDetailSection(
      title: t.user_dashboard.orders.details.order_items,
      icon: Icons.shopping_cart,
      children: [
        ...detail.items.asMap().entries.map((entry) {
          final isLast = entry.key == detail.items.length - 1;
          final item = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.inventory_2_outlined,
                          color: AppColors.orange,
                          size: 20,
                        ),
                      ),
                    ),
                    const Gap(AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.productName,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            t.user_dashboard.orders.details.quantity_label
                                .replaceAll('{qty}', item.quantity.toString()),
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'KWD ${item.unitPrice}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                if (!isLast) ...[
                  const Gap(12),
                  const Divider(height: 1, color: Color(0xFF383A42)),
                  const Gap(12),
                ],
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildPaymentSummaryCard(CheckoutOrderDetail detail, ThemeData theme) {
    return OrderDetailSection(
      title: t.user_dashboard.orders.details.payment_summary,
      icon: Icons.payment,
      children: [
        ...detail.items.map((item) {
          final unitPrice = double.tryParse(item.unitPrice) ?? 0.0;
          final lineTotal = unitPrice * item.quantity;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    '${item.quantity}x ${item.productName}',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  'KWD ${lineTotal.toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          );
        }),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Divider(height: 1, color: Color(0xFF383A42)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.user_dashboard.orders.card.total,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),
            Text(
              'KWD ${detail.totalAmount}',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.orange,
              ),
            ),
          ],
        ),
        if (detail.paymentMethod != null) ...[
          const Gap(12),
          const Divider(height: 1, color: Color(0xFF383A42)),
          const Gap(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.user_dashboard.orders.card.payment_method,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              Text(
                detail.paymentMethod!,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildTimelineCard(CheckoutOrderDetail detail, ThemeData theme) {
    final steps = <_TimelineStep>[];
    steps.add(
      _TimelineStep(
        t.user_dashboard.orders.details.order_placed,
        detail.createdAt,
        true,
      ),
    );
    if (detail.updatedAt != null) {
      steps.add(
        _TimelineStep(
          t.user_dashboard.orders.details.order_updated,
          detail.updatedAt!,
          true,
        ),
      );
    }

    return OrderDetailSection(
      title: t.user_dashboard.orders.details.timeline,
      icon: Icons.timeline,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: steps.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            final isLast = index == steps.length - 1;
            return _buildTimelineStepWidget(step, isLast, theme);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTimelineStepWidget(
    _TimelineStep step,
    bool isLast,
    ThemeData theme,
  ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: step.isActive
                      ? AppColors.orange
                      : Colors.grey.shade700,
                  shape: BoxShape.circle,
                  border: step.isActive
                      ? Border.all(color: Colors.white, width: 2)
                      : null,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: step.isActive
                        ? AppColors.orange
                        : Colors.grey.shade700,
                  ),
                ),
            ],
          ),
          const Gap(AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  DateFormat('MMM dd, yyyy \u2022 hh:mm a').format(step.time),
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                const Gap(AppSpacing.md),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReasonCard(
    String title,
    String reason,
    Color color,
    ThemeData theme,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: color, size: 20),
              const Gap(AppSpacing.sm),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.sm),
          Text(
            reason,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(CheckoutOrderDetail detail, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // TODO: Implement order again or receipt download
                },
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.receipt_long_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      const Gap(AppSpacing.xs),
                      Text(
                        t.user_dashboard.orders.card.download_receipt,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
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

  String _getStatusDisplay(String status) {
    final statusT = t.user_dashboard.orders.status;
    switch (status) {
      case 'pending':
        return statusT.pending;
      case 'processing':
        return statusT.processing;
      case 'confirmed':
        return statusT.confirmed;
      case 'shipped':
        return statusT.shipped;
      case 'delivered':
        return statusT.delivered;
      case 'cancelled':
        return statusT.cancelled;
      default:
        return status[0].toUpperCase() + status.substring(1);
    }
  }
}

class _TimelineStep {
  final String title;
  final DateTime time;
  final bool isActive;

  _TimelineStep(this.title, this.time, this.isActive);
}
