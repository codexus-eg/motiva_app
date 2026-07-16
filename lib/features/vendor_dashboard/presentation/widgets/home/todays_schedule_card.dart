import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/utils/time_utils.dart';
import 'package:app/features/vendor_orders/domain/entities/vendor_order.dart';
import 'package:app/core/theme/spacing.dart';

class TodaysScheduleCard extends StatelessWidget {
  final List<VendorOrder> todayOrders;
  final VoidCallback onViewCalendar;

  const TodaysScheduleCard({
    super.key,
    required this.todayOrders,
    required this.onViewCalendar,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).vendor_dashboard.todays_schedule;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2D35),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const Gap(AppSpacing.sm),
                  Text(
                    t.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              if (todayOrders.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${todayOrders.length}',
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
          const Gap(AppSpacing.md),
          if (todayOrders.isEmpty)
            _buildEmptyState(context)
          else
            ...todayOrders.take(3).map((order) => _buildAppointmentItem(context, order)),
          const Gap(AppSpacing.sm),
          GestureDetector(
            onTap: onViewCalendar,
            child: Center(
              child: Text(
                todayOrders.isEmpty ? t.view_full_calendar : t.view_calendar,
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final t = Translations.of(context).vendor_dashboard.todays_schedule;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.event_available, color: Colors.grey[600], size: 32),
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

  Widget _buildAppointmentItem(BuildContext context ,VendorOrder order) {
    final hasScheduled = order.scheduledAt != null;
    final t = Translations.of(context).vendor_dashboard.todays_schedule;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1F2128),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Gap(AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hasScheduled
                        ? TimeUtils.formatTime(order.scheduledAt!)
                        : t.asap,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const Gap(AppSpacing.xs),
                  Text(
                    order.serviceName ?? t.service_fallback,
                    style: const TextStyle(
                      color: Color(0xFFB9B9B9),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[600], size: 20),
          ],
        ),
      ),
    );
  }
}
