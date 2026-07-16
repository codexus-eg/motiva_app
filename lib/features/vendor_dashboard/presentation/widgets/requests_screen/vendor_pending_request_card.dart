import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/vendor_orders/domain/entities/vendor_order.dart';
import 'package:app/features/vendor_orders/presentation/widgets/status_badge.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/vendor_request_details_screen.dart';
import 'package:intl/intl.dart';
import 'package:app/core/theme/spacing.dart';

class VendorPendingRequestCard extends ConsumerWidget {
  final VendorOrder order;

  const VendorPendingRequestCard({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).vendor_dashboard.request_cards;
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.serviceName ?? t.service_fallback,
                      style: TextStyle(
                        color: theme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const Gap(AppSpacing.xs),
                    Text(
                      order.customerName ?? t.customer_fallback,
                      style: const TextStyle(
                        color: Color(0xFFB9B9B9),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              StatusBadge(status: order.statusEnum),
            ],
          ),
          const Divider(color: Colors.white24, height: 24),
          _infoRow(t.order_ref, order.orderRef, context),
          const Gap(AppSpacing.sm),
          _infoRow(t.amount, order.displayPrice, context),
          const Gap(AppSpacing.sm),
          _infoRow(t.status, order.statusDisplayName, context),
          const Gap(AppSpacing.sm),
          _infoRow(t.time, _formatTime(order.createdAt), context),
          const Gap(AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: theme.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VendorRequestDetailsScreen(orderId: order.id),
                        ),
                      );
                    },
                    child: Text(
                      t.view_details_normal,
                      style: TextStyle(color: theme.primary),
                    ),
                  ),
                ),
              ),
              const Gap(AppSpacing.md),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VendorRequestDetailsScreen(orderId: order.id),
                        ),
                      );
                    },
                    child: Text(
                      t.proceed,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String title, String value, BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFB9B9B9),
            fontSize: 12,
            fontFamily: 'Poppins',
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: theme.onSurface,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
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
