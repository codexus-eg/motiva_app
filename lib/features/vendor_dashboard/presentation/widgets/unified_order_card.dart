import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/vendor_checkout_orders/domain/entities/vendor_checkout_order.dart';
import 'package:app/features/vendor_checkout_orders/presentation/screens/vendor_checkout_order_detail_screen.dart';
import 'package:app/features/vendor_checkout_orders/presentation/widgets/checkout_status_badge.dart';
import 'package:app/features/vendor_orders/domain/entities/vendor_order.dart';
import 'package:app/features/vendor_orders/presentation/widgets/status_badge.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/vendor_request_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

/// A+ Premium unified order card.
/// Spacious layout, clear visual hierarchy, generous padding, breathing room.
class UnifiedOrderCard extends StatelessWidget {
  final dynamic order;
  final bool isServiceOrder;

  const UnifiedOrderCard({
    super.key,
    required this.order,
    required this.isServiceOrder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).vendor_dashboard.unified_order_card;
    return GestureDetector(
      onTap: () => _navigateToDetail(context),
      child: Container(
        decoration: BoxDecoration(
          color: theme.primaryContainer,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: theme.onSurface.withValues(alpha: 0.03),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Premium top bar: compact, elegant
            _buildTypeHeader(theme, t),
            // Content area: generous padding
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + subtitle block
                  _buildTitleBlock(theme, t),
                  const Gap(20),
                  // Info grid with proper spacing
                  _buildInfoGrid(theme, t, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeHeader(
    ColorScheme theme,
    TranslationsVendorDashboardUnifiedOrderCardEn t,
  ) {
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
          // Icon in a small circle
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
            isServiceOrder ? t.service_order : t.product_order,
            style: TextStyle(
              color: typeColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          const Spacer(),
          // Status badge
          if (isServiceOrder)
            StatusBadge(status: (order as VendorOrder).statusEnum)
          else
            CheckoutStatusBadge(status: (order as VendorCheckoutOrder).status),
        ],
      ),
    );
  }

  Widget _buildTitleBlock(
    ColorScheme theme,
    TranslationsVendorDashboardUnifiedOrderCardEn t,
  ) {
    final title = isServiceOrder
        ? (order as VendorOrder).serviceName ?? t.service_fallback
        : '#${(order as VendorCheckoutOrder).orderNumber}';
    final subtitle = isServiceOrder
        ? (order as VendorOrder).customerName ?? t.customer_fallback
        : '${(order as VendorCheckoutOrder).itemsCount} ${(order as VendorCheckoutOrder).itemsCount == 1 ? t.item_singular : t.item_plural}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: theme.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            height: 1.3,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const Gap(6),
        Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFFB9B9B9),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildInfoGrid(
    ColorScheme theme,
    TranslationsVendorDashboardUnifiedOrderCardEn t,
    BuildContext context,
  ) {
    if (isServiceOrder) {
      final o = order as VendorOrder;
      return Row(
        children: [
          Expanded(
            child: _buildInfoItem(
              icon: Icons.receipt_outlined,
              label: t.reference,
              value: o.orderRef,
            ),
          ),
          Expanded(
            child: _buildInfoItem(
              icon: Icons.payments_outlined,
              label: t.amount,
              value: o.displayPrice,
            ),
          ),
          Expanded(
            child: _buildInfoItem(
              icon: Icons.access_time,
              label: t.time,
              value: _formatTime(o.createdAt),
            ),
          ),
        ],
      );
    } else {
      final o = order as VendorCheckoutOrder;
      return Row(
        children: [
          Expanded(
            child: _buildInfoItem(
              icon: Icons.local_shipping_outlined,
              label: t.status,
              value: o.displayStatus,
            ),
          ),
          Expanded(
            child: _buildInfoItem(
              icon: Icons.payments_outlined,
              label: t.amount,
              value: o.displayPrice,
            ),
          ),
          Expanded(
            child: _buildInfoItem(
              icon: Icons.calendar_today_outlined,
              label: t.date,
              value: DateFormat('MMM d').format(o.createdAt),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: const Color(0xFF757575)),
            const Gap(6),
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
        const Gap(6),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFFE8E8E8),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  void _navigateToDetail(BuildContext context) {
    if (isServiceOrder) {
      final o = order as VendorOrder;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VendorRequestDetailsScreen(orderId: o.id),
        ),
      );
    } else {
      final o = order as VendorCheckoutOrder;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VendorCheckoutOrderDetailScreen(orderId: o.id),
        ),
      );
    }
  }

  String _formatTime(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else {
      return DateFormat('MMM d').format(date);
    }
  }
}
