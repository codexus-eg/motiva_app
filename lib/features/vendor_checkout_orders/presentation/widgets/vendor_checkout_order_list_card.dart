import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/vendor_checkout_orders/domain/entities/vendor_checkout_order.dart';
import 'package:app/features/vendor_checkout_orders/presentation/screens/vendor_checkout_order_detail_screen.dart';
import 'package:app/features/vendor_checkout_orders/presentation/widgets/checkout_status_badge.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class VendorCheckoutOrderListCard extends StatelessWidget {
  final VendorCheckoutOrder order;

  const VendorCheckoutOrderListCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).home.vendor.checkout_orders;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VendorCheckoutOrderDetailScreen(orderId: order.id),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '#${order.orderNumber}',
                        style: TextStyle(
                          color: theme.onSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const Gap(AppSpacing.xs),
                      Text(
                        '${order.itemsCount} ${order.itemsCount == 1 ? t.item : t.items_count}',
                        style: const TextStyle(
                          color: Color(0xFFB9B9B9),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
                CheckoutStatusBadge(status: order.status),
              ],
            ),
            const Divider(color: Colors.white24, height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(order.createdAt),
                  style: const TextStyle(
                    color: Color(0xFFB9B9B9),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
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
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }
}
