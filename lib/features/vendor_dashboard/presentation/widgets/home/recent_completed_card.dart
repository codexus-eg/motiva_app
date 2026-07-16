import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/vendor_orders/domain/entities/vendor_order.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/vendor_request_details_screen.dart';
import 'package:intl/intl.dart';
import 'package:app/core/theme/spacing.dart';

class RecentCompletedCard extends StatelessWidget {
  final List<VendorOrder> orders;

  const RecentCompletedCard({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).vendor_dashboard.recent_completed;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            if (orders.isNotEmpty)
              GestureDetector(
                onTap: () {
                  // Navigate to completed orders
                },
                child: Text(
                  t.see_all,
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
          ],
        ),
        const Gap(AppSpacing.md),
        if (orders.isEmpty)
          _buildEmptyState(context)
        else
          ...orders
              .take(3)
              .map(
                (order) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _CompletedOrderItem(order: order),
                ),
              ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final t = Translations.of(context).vendor_dashboard.recent_completed;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2D35),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.grey[600], size: 32),
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
      ),
    );
  }
}

class _CompletedOrderItem extends StatelessWidget {
  final VendorOrder order;

  const _CompletedOrderItem({required this.order});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).vendor_dashboard.recent_completed;
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
          color: const Color(0xFF2A2D35),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.check_circle, color: Colors.green, size: 22),
            ),
            const Gap(AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.serviceName ?? t.service_fallback,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const Gap(AppSpacing.xs),
                  Text(
                    order.customerName ?? t.customer_fallback,
                    style: const TextStyle(
                      color: Color(0xFFB9B9B9),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  order.displayPrice,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const Gap(AppSpacing.xs),
                Text(
                  DateFormat(
                    'MMM d',
                  ).format(order.completedAt ?? order.createdAt),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
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
}
