import 'package:app/features/customer_orders/domain/entities/customer_order.dart';
import 'package:app/features/customer_orders/presentation/providers/customer_orders_provider.dart';
import 'package:app/features/customer_orders/presentation/screens/order_details_screen.dart';
import 'package:app/features/user_dashboard/presentation/screens/orders_screen.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/core/utils/fallback_images.dart';
import 'package:google_fonts/google_fonts.dart';

class ActiveOrdersPreview extends ConsumerWidget {
  const ActiveOrdersPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeOrdersAsync = ref.watch(activeOrdersPreviewProvider);

    return activeOrdersAsync.when(
      data: (orders) {
        if (orders.isEmpty) {
          return _buildEmptyState(context);
        }
        return _buildOrdersSection(context, ref, orders);
      },
      loading: () => _buildLoadingState(context),
      error: (error, _) => const SizedBox.shrink(),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context).user_dashboard.active_orders_preview;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OrdersScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFFE8C00).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.local_car_wash_outlined,
                color: Color(0xFFFE8C00),
                size: 28,
              ),
            ),
            const Gap(AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.empty_title,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const Gap(AppSpacing.xs),
                  Text(
                    t.empty_subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerSkeletons.textSkeleton(width: 140, height: 20),
          const Gap(AppSpacing.md),
          SizedBox(
            height: 170,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              separatorBuilder: (ctx, idx) => const Gap(AppSpacing.md),
              itemBuilder: (context, index) =>
                  ShimmerSkeletons.cardSkeleton(width: 280, height: 170),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersSection(
    BuildContext context,
    WidgetRef ref,
    List<CustomerOrder> orders,
  ) {
    final theme = Theme.of(context);
    final t = Translations.of(context).user_dashboard.active_orders_preview;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFE8C00).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.local_car_wash_outlined,
                    color: Color(0xFFFE8C00),
                    size: 20,
                  ),
                ),
                const Gap(AppSpacing.md),
                Text(
                  t.section_title,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const Gap(AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFE8C00).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${orders.length}',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFE8C00),
                    ),
                  ),
                ),
              ],
            ),
            if (orders.length > 2)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrdersScreen(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      t.view_all,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFE8C00),
                      ),
                    ),
                    const Gap(AppSpacing.xs),
                    const Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: Color(0xFFFE8C00),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const Gap(AppSpacing.md),
        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: orders.length,
            separatorBuilder: (ctx, idx) => const Gap(AppSpacing.md),
            itemBuilder: (context, index) {
              return _ActiveOrderCompactCard(order: orders[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _ActiveOrderCompactCard extends StatelessWidget {
  final CustomerOrder order;

  const _ActiveOrderCompactCard({required this.order});

  Color _getStatusColor(CustomerOrderStatus status) {
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

  String _getStatusLabel(BuildContext context, CustomerOrderStatus status) {
    final t = Translations.of(context).user_dashboard.orders.status;
    switch (status) {
      case CustomerOrderStatus.pendingAcceptance:
        return t.pending;
      case CustomerOrderStatus.accepted:
        return t.accepted;
      case CustomerOrderStatus.enRoute:
        return t.on_the_way;
      case CustomerOrderStatus.arrived:
        return t.arrived;
      case CustomerOrderStatus.inProgress:
        return t.in_progress;
      case CustomerOrderStatus.completed:
        return t.completed;
      case CustomerOrderStatus.rejected:
        return t.rejected;
      case CustomerOrderStatus.cancelled:
        return t.cancelled;
    }
  }

  String _getRelativeTime(BuildContext context) {
    final now = DateTime.now();
    final diff = now.difference(order.createdAt);
    final t = Translations.of(
      context,
    ).user_dashboard.active_orders_preview.time_ago;

    if (diff.inMinutes < 1) {
      return t.just_now;
    } else if (diff.inMinutes < 60) {
      return t.minutes_ago.replaceAll('{n}', diff.inMinutes.toString());
    } else if (diff.inHours < 24) {
      return t.hours_ago.replaceAll('{n}', diff.inHours.toString());
    } else {
      return t.days_ago.replaceAll('{n}', diff.inDays.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor(order.status);

    final serviceImage = order.serviceImageUrl ?? FallbackImages.serviceDefault;
    final isNetworkImage =
        order.serviceImageUrl != null && order.serviceImageUrl!.isNotEmpty;
    final vendorLogo = order.vendorLogoUrl ?? FallbackImages.vendorLogo;
    final vendorLogoNetwork =
        order.vendorLogoUrl != null && order.vendorLogoUrl!.isNotEmpty;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(orderId: order.id),
          ),
        );
      },
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: statusColor.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        width: 56,
                        height: 56,
                        color: theme.colorScheme.surface,
                        child: isNetworkImage
                            ? Image.network(
                                serviceImage,
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, err, st) => Image.asset(
                                  FallbackImages.serviceDefault,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.asset(serviceImage, fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      bottom: -3,
                      right: -3,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.surface,
                            width: 2,
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: vendorLogoNetwork
                            ? Image.network(
                                vendorLogo,
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, err, st) => const Icon(
                                  Icons.store,
                                  size: 12,
                                  color: Color(0xFFFE8C00),
                                ),
                              )
                            : const Icon(
                                Icons.store,
                                size: 12,
                                color: Color(0xFFFE8C00),
                              ),
                      ),
                    ),
                  ],
                ),
                const Gap(AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const Gap(AppSpacing.xs),
                            Text(
                              _getStatusLabel(context, order.status),
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(AppSpacing.xs),
                      Text(
                        order.serviceName ??
                            Translations.of(context)
                                .user_dashboard
                                .active_orders_preview
                                .unknown_service,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(AppSpacing.xs),
                      Row(
                        children: [
                          Icon(
                            Icons.storefront_outlined,
                            size: 11,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.5,
                            ),
                          ),
                          const Gap(AppSpacing.xs),
                          Expanded(
                            child: Text(
                              order.vendorName ??
                                  Translations.of(context)
                                      .user_dashboard
                                      .active_orders_preview
                                      .unknown_vendor,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 12,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                    const Gap(AppSpacing.xs),
                    Text(
                      _getRelativeTime(context),
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'KD ${order.baseAmount.split('.')[0]}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFE8C00),
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
