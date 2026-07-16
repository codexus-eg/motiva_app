import 'package:app/features/reviews/presentation/screens/submit_review_screen.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/customer_order.dart';
import '../providers/customer_orders_provider.dart';
import '../widgets/customer_status_timeline.dart';
import '../widgets/order_detail_section.dart';

import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/core/utils/fallback_images.dart';
import 'package:app/shared/ui/widgets/attribute_value_widget.dart';
import 'package:app/features/service_order_documents/presentation/providers/service_order_documents_provider.dart';
import 'package:app/features/service_order_documents/domain/entities/service_order_document.dart';

class OrderDetailsScreen extends ConsumerStatefulWidget {
  final String orderId;

  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  ConsumerState<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends ConsumerState<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final orderAsync = ref.watch(customerOrderByIdProvider(widget.orderId));
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: orderAsync.when(
        loading: () => ShimmerSkeletons.screenSkeleton(),
        error: (error, _) => _buildErrorState(error, theme),
        data: (order) => _buildContent(order, theme),
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
                  ref.invalidate(customerOrderByIdProvider(widget.orderId)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFE8C00),
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

  Widget _buildContent(CustomerOrder order, ThemeData theme) {
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
                        _buildHeroHeader(order, theme),
                        const Gap(AppSpacing.lg),
                        CustomerStatusTimeline(currentStatus: order.status),
                        const Gap(AppSpacing.lg),
                        _buildServiceInfoCard(order, theme),
                        const Gap(AppSpacing.lg),
                        if (order.scheduledAt != null) ...[
                          _buildScheduledCard(order, theme),
                          const Gap(AppSpacing.lg),
                        ],
                        if (order.locationAddress != null ||
                            (order.locationLat != null &&
                                order.locationLng != null)) ...[
                          _buildLocationCard(order, theme),
                          const Gap(AppSpacing.lg),
                        ],
                        if (order.orderVendorAttributes != null &&
                            order.orderVendorAttributes!.isNotEmpty) ...[
                          _buildAttributesCard(
                            t
                                .user_dashboard
                                .orders
                                .details
                                .service_specifications,
                            order.orderVendorAttributes!,
                            theme,
                          ),
                          const Gap(AppSpacing.lg),
                        ],
                        if (order.orderCustomerAttributes != null &&
                            order.orderCustomerAttributes!.isNotEmpty) ...[
                          _buildAttributesCard(
                            t.user_dashboard.orders.details.your_details,
                            order.orderCustomerAttributes!,
                            theme,
                          ),
                          const Gap(AppSpacing.lg),
                        ],
                        _buildTimelineCard(order, theme),
                        const Gap(AppSpacing.lg),
                        _buildDocumentsCard(order, theme),
                        const Gap(AppSpacing.lg),
                        if (order.rejectionReason != null) ...[
                          _buildReasonCard(
                            t.user_dashboard.orders.details.rejection_reason,
                            order.rejectionReason!,
                            Colors.red,
                            theme,
                          ),
                          const Gap(AppSpacing.lg),
                        ],
                        if (order.cancellationReason != null) ...[
                          _buildReasonCard(
                            t.user_dashboard.orders.details.cancellation_reason,
                            order.cancellationReason!,
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
          _buildBottomActions(order, theme),
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
                color: Color(0xFFFE8C00),
                size: 18,
              ),
            ),
          ),
          const Gap(AppSpacing.md),
          Expanded(
            child: Text(
              t.user_dashboard.orders.details.screen_title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          IconButton(
            onPressed: () =>
                ref.invalidate(customerOrderByIdProvider(widget.orderId)),
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

  Widget _buildHeroHeader(CustomerOrder order, ThemeData theme) {
    final statusColor = _getStatusColor(order.status);
    final statusText = order.statusDisplay;

    final serviceImage = order.serviceImageUrl ?? FallbackImages.serviceDefault;
    final isNetworkImage =
        order.serviceImageUrl != null && order.serviceImageUrl!.isNotEmpty;
    final vendorLogo = order.vendorLogoUrl ?? FallbackImages.vendorLogo;
    final vendorLogoNetwork =
        order.vendorLogoUrl != null && order.vendorLogoUrl!.isNotEmpty;

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
                order.orderRef,
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
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 72,
                      height: 72,
                      color: theme.colorScheme.primaryContainer,
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
                    bottom: -4,
                    right: -4,
                    child: Container(
                      width: 32,
                      height: 32,
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
                                size: 16,
                                color: Color(0xFFFE8C00),
                              ),
                            )
                          : const Icon(
                              Icons.store,
                              size: 16,
                              color: Color(0xFFFE8C00),
                            ),
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
                      order.serviceName ??
                          t.user_dashboard.orders.details.unknown_service,
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
                      order.vendorName ??
                          t.user_dashboard.orders.details.unknown_vendor,
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
                        color: const Color(0xFFFE8C00).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'KD ${order.baseAmount}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFE8C00),
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

  Widget _buildServiceInfoCard(CustomerOrder order, ThemeData theme) {
    return OrderDetailSection(
      title: t.user_dashboard.orders.details.order_information,
      icon: Icons.receipt_long,
      children: [
        OrderInfoRow(
          label: t.user_dashboard.orders.details.order_reference,
          value: order.orderRef,
        ),
        const Divider(height: 24, color: Color(0xFF383A42)),
        if (order.serviceName != null) ...[
          OrderInfoRow(
            label: t.user_dashboard.orders.details.service,
            value: order.serviceName!,
          ),
          const Divider(height: 24, color: Color(0xFF383A42)),
        ],
        if (order.vendorName != null) ...[
          OrderInfoRow(
            label: t.user_dashboard.orders.details.vendor,
            value: order.vendorName!,
          ),
          const Divider(height: 24, color: Color(0xFF383A42)),
        ],
        OrderInfoRow(
          label: t.user_dashboard.orders.details.base_amount,
          value: 'KD ${order.baseAmount}',
        ),
        if (order.status == CustomerOrderStatus.completed) ...[
          const Divider(height: 24, color: Color(0xFF383A42)),
          OrderInfoRow(
            label: t.user_dashboard.orders.details.total_amount,
            value: 'KD ${order.totalAmount}',
            isBold: true,
          ),
        ],
      ],
    );
  }

  Widget _buildScheduledCard(CustomerOrder order, ThemeData theme) {
    return OrderDetailSection(
      title: t.user_dashboard.orders.details.scheduled_date_time,
      icon: Icons.event,
      children: [
        OrderInfoRow(
          label: t.user_dashboard.orders.details.date,
          value: DateFormat(
            'EEEE, MMM d, yyyy',
          ).format(order.scheduledAt!.toLocal()),
        ),
        const Divider(height: 24, color: Color(0xFF383A42)),
        OrderInfoRow(
          label: t.user_dashboard.orders.details.time,
          value: DateFormat('hh:mm a').format(order.scheduledAt!.toLocal()),
        ),
      ],
    );
  }

  Widget _buildLocationCard(CustomerOrder order, ThemeData theme) {
    return OrderDetailSection(
      title: t.user_dashboard.orders.details.service_location,
      icon: Icons.location_on,
      children: [
        if (order.locationAddress != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.place, color: Color(0xFFFE8C00), size: 20),
              const Gap(AppSpacing.sm),
              Expanded(
                child: Text(
                  order.locationAddress!,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        if (order.locationLat != null && order.locationLng != null) ...[
          const Gap(AppSpacing.md),
          GestureDetector(
            onTap: () => _openMap(order.locationLat!, order.locationLng!),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.3,
                          ),
                          size: 36,
                        ),
                        const Gap(AppSpacing.sm),
                        Text(
                          t.user_dashboard.orders.details.open_in_maps,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFFFE8C00),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${order.locationLat!.toStringAsFixed(4)}, ${order.locationLng!.toStringAsFixed(4)}',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.7,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAttributesCard(
    String title,
    Map<String, dynamic> attributes,
    ThemeData theme,
  ) {
    return OrderDetailSection(
      title: title,
      icon: Icons.format_list_bulleted,
      children: attributes.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  _formatKey(entry.key),
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ),
              const Gap(AppSpacing.sm),
              Expanded(
                flex: 3,
                child: AttributeValueWidget(value: entry.value),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTimelineCard(CustomerOrder order, ThemeData theme) {
    final steps = _buildTimelineSteps(order);
    final stepCount = steps.length;

    return OrderDetailSection(
      title: t.user_dashboard.orders.details.timeline,
      icon: Icons.timeline,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: steps.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            final isLast = index == stepCount - 1;
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
                      ? (step.color ?? const Color(0xFFFE8C00))
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
                        ? (step.color ?? const Color(0xFFFE8C00))
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

  List<_TimelineStep> _buildTimelineSteps(CustomerOrder order) {
    final steps = <_TimelineStep>[];

    steps.add(
      _TimelineStep(
        t.user_dashboard.orders.details.order_placed,
        order.createdAt,
        true,
      ),
    );
    if (order.acceptedAt != null) {
      steps.add(
        _TimelineStep(
          t.user_dashboard.orders.details.vendor_accepted,
          order.acceptedAt!,
          order.status != CustomerOrderStatus.pendingAcceptance,
        ),
      );
    }
    if (order.completedAt != null) {
      steps.add(
        _TimelineStep(
          t.user_dashboard.orders.details.service_completed,
          order.completedAt!,
          order.status == CustomerOrderStatus.completed,
          color: Colors.green,
        ),
      );
    }
    if (order.cancelledAt != null) {
      steps.add(
        _TimelineStep(
          t.user_dashboard.orders.details.order_cancelled,
          order.cancelledAt!,
          true,
          color: Colors.red,
        ),
      );
    }

    return steps;
  }

  Widget _buildDocumentsCard(CustomerOrder order, ThemeData theme) {
    final docsAsync = ref.watch(serviceOrderDocumentsProvider(widget.orderId));

    return docsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (e, st) => const SizedBox.shrink(),
      data: (docs) {
        if (docs.isEmpty) return const SizedBox.shrink();

        return OrderDetailSection(
          title: t.user_dashboard.orders.details.documents,
          icon: Icons.folder_open,
          children: docs.map((doc) => _buildDocumentItem(doc, theme)).toList(),
        );
      },
    );
  }

  Widget _buildDocumentItem(ServiceOrderDocument doc, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => _launchDocumentUrl(doc.fileUrl),
        child: Row(
          children: [
            const Icon(Icons.description, size: 20, color: Color(0xFF2196F3)),
            const Gap(AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc.originalFilename.isNotEmpty
                        ? doc.originalFilename
                        : doc.fileUrl.split('/').last,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2196F3),
                      decoration: TextDecoration.underline,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    doc.documentType.isNotEmpty
                        ? doc.documentType[0].toUpperCase() +
                              doc.documentType.substring(1)
                        : t.user_dashboard.orders.details.document,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.open_in_new, size: 16, color: Color(0xFF2196F3)),
          ],
        ),
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

  Widget _buildBottomActions(CustomerOrder order, ThemeData theme) {
    final actions = _getActions(order);
    if (actions.isEmpty) return const SizedBox.shrink();

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
      child: SafeArea(child: Row(children: actions)),
    );
  }

  List<Widget> _getActions(CustomerOrder order) {
    final actions = <Widget>[];

    switch (order.status) {
      case CustomerOrderStatus.pendingAcceptance:
        break;
      case CustomerOrderStatus.accepted:
      case CustomerOrderStatus.enRoute:
      case CustomerOrderStatus.arrived:
      case CustomerOrderStatus.inProgress:
        actions.add(
          Expanded(
            child: _buildActionButton(
              label: t.user_dashboard.orders.details.call_vendor,
              icon: Icons.phone,
              color: const Color(0xFF4CAF50),
              onPressed: () => _callVendor(order),
            ),
          ),
        );
        break;
      case CustomerOrderStatus.completed:
        actions.add(
          Expanded(
            flex: 2,
            child: _buildActionButton(
              label: t.user_dashboard.orders.details.write_review,
              icon: Icons.star_border,
              color: const Color(0xFFFE8C00),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubmitReviewScreen(
                    orderId: order.id,
                    isServiceOrder: true,
                    orderName: order.serviceName ?? '',
                    vendorId: order.vendorId,
                    vendorName: order.vendorName ?? '',
                  ),
                ),
              ),
              // _showReviewDialog(order),
            ),
          ),
        );
        actions.add(const Gap(AppSpacing.md));
        actions.add(
          Expanded(
            child: _buildActionButton(
              label: t.user_dashboard.orders.details.book_again,
              icon: Icons.replay,
              isOutlined: true,
              onPressed: () => _bookAgain(order),
            ),
          ),
        );
        break;
      case CustomerOrderStatus.rejected:
      case CustomerOrderStatus.cancelled:
        actions.add(
          Expanded(
            child: _buildActionButton(
              label: t.user_dashboard.orders.details.book_again,
              icon: Icons.replay,
              onPressed: () => _bookAgain(order),
            ),
          ),
        );
        break;
    }

    return actions;
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    Color color = const Color(0xFFFE8C00),
    bool isOutlined = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: isOutlined ? Colors.transparent : color,
          borderRadius: BorderRadius.circular(12),
          border: isOutlined ? Border.all(color: color) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isOutlined ? color : Colors.white, size: 20),
            const Gap(AppSpacing.xs),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isOutlined ? color : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

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

  Future<void> _callVendor(CustomerOrder order) async {
    final phone = order.vendorPhone;
    if (phone == null || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.user_dashboard.orders.details.phone_not_available),
        ),
      );
      return;
    }

    final uri = Uri.parse('tel:$phone');
    final canLaunch = await canLaunchUrl(uri);
    if (!mounted) return;
    if (canLaunch) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            t.user_dashboard.orders.details.could_not_launch_dialer,
          ),
        ),
      );
    }
  }

  // void _showReviewDialog(CustomerOrder order) {
  //   // TODO: Implement review screen navigation
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(t.user_dashboard.orders.details.review_coming_soon),
  //     ),
  //   );
  // }

  void _bookAgain(CustomerOrder order) {
    // TODO: Navigate back to service booking with pre-filled data
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<void> _openMap(double lat, double lng) async {
    final url = 'https://maps.google.com/?q=$lat,$lng';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchDocumentUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  String _formatKey(String key) {
    return key
        .replaceAll('_', ' ')
        .split(' ')
        .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }
}

// Private helper model for timeline steps
class _TimelineStep {
  final String title;
  final DateTime time;
  final bool isActive;
  final Color? color;

  const _TimelineStep(this.title, this.time, this.isActive, {this.color});
}
