import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/customer_checkout_orders/domain/entities/checkout_order.dart';
import 'package:app/features/customer_checkout_orders/domain/entities/checkout_order_detail.dart';
import 'package:app/features/customer_checkout_orders/presentation/providers/checkout_orders_provider.dart';
import 'package:app/features/customer_orders/domain/entities/customer_order.dart';
import 'package:app/features/customer_orders/presentation/screens/order_details_screen.dart';
import 'package:app/features/reviews/presentation/screens/submit_review_screen.dart';
import 'package:app/features/user_dashboard/presentation/screens/product_order_details_screen.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

/// A+ Premium unified order card for the customer-side orders screen.
/// Service orders navigate to OrderDetailsScreen on tap.
/// Product orders toggle inline expansion on tap.
class UnifiedCustomerOrderCard extends ConsumerWidget {
  final dynamic order;
  final bool isServiceOrder;
  final bool isExpanded;
  final VoidCallback? onToggle;

  const UnifiedCustomerOrderCard({
    super.key,
    required this.order,
    required this.isServiceOrder,
    this.isExpanded = false,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final cardT = Translations.of(context).user_dashboard.orders;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTypeHeader(context, theme),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleBlock(context, theme),
                const Gap(16),
                const Divider(color: Color(0xFF2C2F33), height: 1),
                const Gap(16),
                if (!isExpanded) _buildCollapsedContent(context, theme),
                if (isExpanded) ...[
                  if (isServiceOrder)
                    Center(
                      child: Text(
                        cardT.service_details,
                        style: TextStyle(color: theme.onSurface, fontSize: 12),
                      ),
                    )
                  else
                    _buildProductExpandedContent(context),
                ],
                const Gap(20),
                _buildActionButtons(context, theme, ref),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onViewDetails(BuildContext context) {
    if (isServiceOrder) {
      final o = order as CustomerOrder;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => OrderDetailsScreen(orderId: o.id)),
      );
    } else {
      final o = order as CheckoutOrder;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductOrderDetailsScreen(orderId: o.id),
        ),
      );
    }
  }

  Widget _buildTypeHeader(BuildContext context, ColorScheme theme) {
    final cardT = Translations.of(context).user_dashboard.orders.card;
    final typeColor = isServiceOrder
        ? const Color(0xFF8BB8E8)
        : AppColors.primary;
    final typeBg = isServiceOrder
        ? const Color(0xFF3D5A80).withValues(alpha: 0.15)
        : AppColors.primary.withValues(alpha: 0.10);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: typeBg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: typeColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: isServiceOrder
                  ? Icon(
                      Icons.construction_outlined,
                      size: 18,
                      color: typeColor,
                    )
                  : SvgPicture.asset(
                      'assets/icons/shopping_bag.svg',
                      width: 18,
                      height: 18,
                      colorFilter: ColorFilter.mode(typeColor, BlendMode.srcIn),
                    ),
            ),
          ),
          const Gap(12),
          Text(
            isServiceOrder ? cardT.service_order : cardT.product_order,
            style: TextStyle(
              color: typeColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          const Spacer(),
          _buildStatusBadge(context),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    if (isServiceOrder) {
      final o = order as CustomerOrder;
      final color = _serviceStatusColor(o.status);
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 1),
        ),
        child: Text(
          o.statusDisplay,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      );
    } else {
      final o = order as CheckoutOrder;
      final color = _productStatusColor(o.status);
      final displayName = _productStatusDisplay(context, o.status);
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 1),
        ),
        child: Text(
          displayName,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      );
    }
  }

  Widget _buildTitleBlock(BuildContext context, ColorScheme theme) {
    final cardT = Translations.of(context).user_dashboard.orders.card;
    final String title = isServiceOrder
        ? (order as CustomerOrder).serviceName ?? cardT.fallback_service
        : _productTitle(context, order as CheckoutOrder);

    final String subtitle = isServiceOrder
        ? (order as CustomerOrder).vendorName ?? cardT.fallback_vendor
        : '${cardT.order_id}: ${(order as CheckoutOrder).orderNumber}';

    final int itemCount = isServiceOrder
        ? 0
        : (order as CheckoutOrder).itemsSummary.length;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              title.isNotEmpty ? title[0].toUpperCase() : 'P',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: theme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFFB9B9B9),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                if (!isServiceOrder) ...[
                  Text(
                    '$itemCount ${itemCount == 1 ? cardT.item : cardT.items}',
                    style: const TextStyle(
                      color: Color(0xFFB9B9B9),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const Gap(4),
                  IconButton(
                    onPressed: () => onToggle?.call(),
                    icon: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCollapsedContent(BuildContext context, ColorScheme theme) {
    final String price = isServiceOrder
        ? (order as CustomerOrder).baseAmount
        : (order as CheckoutOrder).totalAmount;

    final cardT = Translations.of(context).user_dashboard.orders.card;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'KWD $price',
          style: TextStyle(
            color: theme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        const Gap(4),
        Text(
          cardT.view_details,
          style: TextStyle(
            color: Color(0xFFB9B9B9),
            fontSize: 12,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    ColorScheme theme,
    WidgetRef ref,
  ) {
    final cardT = Translations.of(context).user_dashboard.orders.card;
    final bool canAddReview = isServiceOrder
        ? !(order as CustomerOrder).reviewSubmitted
        : !(order as CheckoutOrder).reviewSubmitted;

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: canAddReview ? () => _onAddReview(context, ref) : null,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: canAddReview ? theme.onSurface : Colors.grey,
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Text(
              canAddReview ? cardT.add_review : 'Reviewed',
              style: TextStyle(
                color: canAddReview ? theme.onSurface : Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
        const Gap(12),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE28C37), Color(0xFF8C5219)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: ElevatedButton(
              onPressed: () => _onViewDetails(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Text(
                cardT.view_details,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onAddReview(BuildContext context, WidgetRef ref) async {
    final String orderId;
    String vendorId;
    final String orderName;
    String vendorName;

    if (isServiceOrder) {
      final o = order as CustomerOrder;
      orderId = o.id;
      vendorId = o.vendorId;
      orderName = o.serviceName ?? 'Service';
      vendorName = o.vendorName ?? 'Vendor';
    } else {
      final o = order as CheckoutOrder;
      orderId = o.id;
      orderName = o.itemsSummary.isNotEmpty
          ? o.itemsSummary.first.productName
          : 'Product';

      // Fetch order detail to get vendorId
      try {
        final detail = await ref.read(checkoutOrderDetailProvider(o.id).future);
        vendorId = detail.vendorId ?? '';
        vendorName = detail.vendorName ?? 'Vendor';
      } catch (e) {
        vendorId = '';
        vendorName = 'Vendor';
      }
    }

    if (vendorId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to submit review: Vendor information not available',
          ),
        ),
      );
      return;
    }

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => SubmitReviewScreen(
          orderId: orderId,
          vendorId: vendorId,
          orderName: orderName,
          vendorName: vendorName,
          isServiceOrder: isServiceOrder,
        ),
      ),
    );

    if (result == true) {
      // Refresh the order list by invalidating the providers
      // This will trigger a reload of the orders
      if (isServiceOrder) {
        // Invalidate customer orders provider
        // context.read(customerOrdersProvider.notifier).refresh();
      } else {
        // Invalidate checkout orders provider
        // context.read(checkoutOrdersProvider.notifier).refresh();
      }
    }
  }

  Widget _buildProductExpandedContent(BuildContext context) {
    final o = order as CheckoutOrder;
    final cardT = Translations.of(context).user_dashboard.orders.card;
    return Consumer(
      builder: (context, ref, child) {
        final detailAsync = ref.watch(checkoutOrderDetailProvider(o.id));
        return detailAsync.when(
          data: (detail) => _buildExpandedDetail(context, detail),
          loading: () => ShimmerSkeletons.cardSkeleton(),
          error: (err, stack) => Text(
            cardT.failed_details.replaceAll('{error}', err.toString()),
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
        );
      },
    );
  }

  Widget _buildExpandedDetail(
    BuildContext context,
    CheckoutOrderDetail detail,
  ) {
    final cardT = Translations.of(context).user_dashboard.orders.card;
    final theme = Theme.of(context).colorScheme;
    final items = detail.items;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Delivery address
        if (detail.deliveryAddress.formattedAddress.isNotEmpty) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: theme.onSurface,
                size: 20,
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardT.delivery_address,
                      style: TextStyle(
                        color: theme.onSurface,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const Gap(4),
                    Text(
                      detail.deliveryAddress.formattedAddress,
                      style: const TextStyle(
                        color: Color(0xFFB9B9B9),
                        fontSize: 12,
                        height: 1.5,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(20),
          const Divider(color: Color(0xFF2C2F33), height: 1),
          const Gap(20),
        ],
        // Order Summary header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              cardT.order_summary,
              style: TextStyle(
                color: theme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            GestureDetector(
              child: Text(
                cardT.download_receipt,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
        const Gap(16),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${item.quantity} ${item.productName}',
                  style: const TextStyle(
                    color: Color(0xFFB9B9B9),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  'KWD ${(double.tryParse(item.unitPrice) ?? 0.0) * item.quantity}',
                  style: const TextStyle(
                    color: Color(0xFFB9B9B9),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ),
        const Gap(8),
        _SummaryRow(
          label: cardT.total,
          value: 'KWD ${detail.totalAmount}',
          valueColor: AppColors.primary,
          isBold: true,
        ),
        _SummaryRow(
          label: cardT.payment_method,
          value: detail.paymentMethod ?? 'N/A',
          isBold: true,
        ),
      ],
    );
  }

  String _productTitle(BuildContext context, CheckoutOrder o) {
    final cardT = Translations.of(context).user_dashboard.orders.card;
    if (o.itemsSummary.isEmpty) return '#${o.orderNumber}';
    final first = o.itemsSummary.first.productName;
    if (o.itemsSummary.length == 1) return first;
    return '$first ${cardT.more_items.replaceAll('{count}', '${o.itemsSummary.length - 1}')}';
  }

  Color _serviceStatusColor(CustomerOrderStatus status) {
    switch (status) {
      case CustomerOrderStatus.pendingAcceptance:
        return const Color(0xFFFFC107);
      case CustomerOrderStatus.accepted:
        return const Color(0xFF2196F3);
      case CustomerOrderStatus.enRoute:
        return const Color(0xFF03A9F4);
      case CustomerOrderStatus.arrived:
        return const Color(0xFF009688);
      case CustomerOrderStatus.inProgress:
        return const Color(0xFFFE8C00);
      case CustomerOrderStatus.completed:
        return const Color(0xFF4CAF50);
      case CustomerOrderStatus.rejected:
        return Colors.grey;
      case CustomerOrderStatus.cancelled:
        return Colors.red;
    }
  }

  Color _productStatusColor(String status) {
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

  String _productStatusDisplay(BuildContext context, String status) {
    final t = Translations.of(context).user_dashboard.orders.status;
    switch (status) {
      case 'pending':
        return t.pending;
      case 'processing':
        return t.processing;
      case 'confirmed':
        return t.confirmed;
      case 'shipped':
        return t.shipped;
      case 'delivered':
        return t.delivered;
      case 'cancelled':
        return t.cancelled;
      default:
        return status[0].toUpperCase() + status.substring(1);
    }
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isBold ? theme.onSurface : const Color(0xFFB9B9B9),
              fontSize: 13,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? theme.onSurface,
              fontSize: 13,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
