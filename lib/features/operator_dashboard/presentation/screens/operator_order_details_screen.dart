import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/shared/ui/widgets/attribute_value_widget.dart';
import 'package:app/features/service_order_documents/presentation/providers/service_order_documents_provider.dart';
import 'package:app/features/service_order_documents/domain/entities/service_order_document.dart';
import 'package:app/features/operator_orders/presentation/providers/operator_orders_provider.dart';
import 'package:app/features/vendor_orders/domain/entities/vendor_order.dart';
import 'package:app/features/vendor_orders/domain/entities/vendor_order_status.dart';
import 'package:app/features/vendor_orders/presentation/widgets/dialogs/complete_order_dialog.dart';
import 'package:app/features/vendor_orders/presentation/widgets/status_badge.dart';
import 'package:app/features/vendor_orders/presentation/widgets/status_timeline.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:url_launcher/url_launcher.dart';

class OperatorOrderDetailsScreen extends ConsumerStatefulWidget {
  final String orderId;

  const OperatorOrderDetailsScreen({super.key, required this.orderId});

  @override
  ConsumerState<OperatorOrderDetailsScreen> createState() =>
      _OperatorOrderDetailsScreenState();
}

class _OperatorOrderDetailsScreenState
    extends ConsumerState<OperatorOrderDetailsScreen> {
  bool _isStartingTravel = false;
  bool _isArriving = false;
  bool _isStartingService = false;

  Future<void> _handleStartTravel() async {
    setState(() => _isStartingTravel = true);
    try {
      await ref
          .read(operatorStartTravelNotifierProvider.notifier)
          .startTravel(widget.orderId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Status updated: On the way')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed: $e')));
      }
    } finally {
      if (mounted) setState(() => _isStartingTravel = false);
    }
  }

  Future<void> _handleArrive() async {
    setState(() => _isArriving = true);
    try {
      await ref
          .read(operatorArriveNotifierProvider.notifier)
          .arrive(widget.orderId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Status updated: Arrived at location')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed: $e')));
      }
    } finally {
      if (mounted) setState(() => _isArriving = false);
    }
  }

  Future<void> _handleStartService() async {
    setState(() => _isStartingService = true);
    try {
      await ref
          .read(operatorStartServiceNotifierProvider.notifier)
          .startService(widget.orderId);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Service started')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed: $e')));
      }
    } finally {
      if (mounted) setState(() => _isStartingService = false);
    }
  }

  void _showCompleteDialog(VendorOrder order) {
    showDialog(
      context: context,
      builder: (context) => CompleteOrderDialog(
        orderId: widget.orderId,
        baseAmount: order.baseAmount,
        onComplete: (finalPrice, documents) async {
          await ref
              .read(operatorCompleteOrderNotifierProvider.notifier)
              .complete(widget.orderId, finalPrice);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orderAsync = ref.watch(operatorOrderByIdProvider(widget.orderId));
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.surface,
      body: orderAsync.when(
        data: (order) => _buildContent(context, order),
        loading: () => ShimmerSkeletons.listItemSkeleton(),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error', style: TextStyle(color: theme.onSurface)),
              const Gap(AppSpacing.md),
              ElevatedButton(
                onPressed: () =>
                    ref.invalidate(operatorOrderByIdProvider(widget.orderId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, VendorOrder order) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(AppSpacing.md),
            _buildAppBar(context),
            const Gap(AppSpacing.lg),
            StatusTimeline(currentStatus: order.statusEnum),
            const Gap(AppSpacing.lg),
            _buildServiceCard(order),
            const Gap(AppSpacing.lg),
            if (order.locationAddress != null) ...[
              _buildLocationSection(order),
              const Gap(AppSpacing.lg),
            ],
            _buildOrderDetails(order),
            const Gap(AppSpacing.lg),
            _buildCustomerDetails(order),
            const Gap(AppSpacing.lg),
            _buildDocumentsSection(order),
            const Gap(AppSpacing.lg),
            if (order.rejectionReason != null) ...[
              _buildRejectionReason(order),
              const Gap(AppSpacing.lg),
            ],
            if (order.cancellationReason != null) ...[
              _buildCancellationDetails(order),
              const Gap(AppSpacing.lg),
            ],
            _buildActionButtons(order),
            const Gap(AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Semantics(
          button: true,
          onTapHint: SemanticLabels.backButton,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.orange,
              size: 20,
            ),
          ),
        ),
        const Gap(AppSpacing.md),
        Expanded(
          child: Text(
            'ORDER DETAILS',
            style: TextStyle(
              color: theme.onSurface,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard(VendorOrder order) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    order.serviceName ?? 'Service',
                    style: TextStyle(
                      color: theme.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                StatusBadge(status: order.statusEnum),
              ],
            ),
            const Gap(AppSpacing.md),
            Row(
              children: [
                _buildInfoColumn('Order Ref', order.orderRef),
                const Gap(AppSpacing.lg),
                _buildInfoColumn(
                  'Amount',
                  order.displayPrice,
                  isSemiBold: true,
                ),
              ],
            ),
            const Gap(AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: _buildInfoColumn(
                    'Created',
                    _formatDate(order.createdAt),
                  ),
                ),
                if (order.scheduledAt != null) ...[
                  const Gap(AppSpacing.lg),
                  Expanded(
                    child: _buildInfoColumn(
                      'Scheduled',
                      _formatDate(order.scheduledAt!),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection(VendorOrder order) {
    final hasRoute = order.pickupLat != null && order.dropoffLat != null;
    final theme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hasRoute ? 'Route' : 'Location',
          style: TextStyle(
            color: theme.onSurface,
            fontSize: 18.8,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        const Gap(AppSpacing.md),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.primaryContainer,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasRoute) ...[
                _buildRouteLocationItem(
                  'Pickup',
                  order.pickupAddress,
                  order.pickupLat,
                  order.pickupLng,
                  Icons.trip_origin,
                ),
                const Gap(AppSpacing.md),
                _buildRouteLocationItem(
                  'Dropoff',
                  order.dropoffAddress,
                  order.dropoffLat,
                  order.dropoffLng,
                  Icons.location_on,
                ),
              ] else ...[
                Text(
                  'Address',
                  style: TextStyle(
                    color: theme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                const Gap(AppSpacing.sm),
                Text(
                  order.locationAddress ?? 'No address provided',
                  style: const TextStyle(
                    color: Color(0xFFB9B9B9),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                ),
                if (order.locationLat != null && order.locationLng != null) ...[
                  const Gap(AppSpacing.md),
                  OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Open maps with coordinates
                    },
                    icon: const Icon(Icons.map_outlined, color: Colors.orange),
                    label: const Text(
                      'Open in Maps',
                      style: TextStyle(color: Colors.orange),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.orange),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRouteLocationItem(
    String label,
    String? address,
    double? lat,
    double? lng,
    IconData icon,
  ) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.orange, size: 20),
            const Gap(AppSpacing.sm),
            Text(
              label,
              style: TextStyle(
                color: theme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
        const Gap(AppSpacing.sm),
        Text(
          address ?? 'No address provided',
          style: const TextStyle(
            color: Color(0xFFB9B9B9),
            fontSize: 13,
            fontFamily: 'Poppins',
          ),
        ),
        if (lat != null && lng != null) ...[
          const Gap(AppSpacing.sm),
          Text(
            '(${lat.toStringAsFixed(6)}, ${lng.toStringAsFixed(6)})',
            style: const TextStyle(
              color: Color(0xFF808080),
              fontSize: 11,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildOrderDetails(VendorOrder order) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Details',
          style: TextStyle(
            color: theme.onSurface,
            fontSize: 18.8,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        const Gap(AppSpacing.md),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.primaryContainer,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildInfoColumn(
                      'Base Amount',
                      '${order.baseAmount} KWD',
                    ),
                  ),
                  Expanded(
                    child: _buildInfoColumn(
                      'Total',
                      '${order.totalAmount} KWD',
                      isSemiBold: true,
                    ),
                  ),
                ],
              ),
              if (order.orderVendorAttributes != null &&
                  order.orderVendorAttributes!.isNotEmpty) ...[
                const Gap(AppSpacing.md),
                Text(
                  'Service Specifications',
                  style: TextStyle(
                    color: theme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(AppSpacing.sm),
                ...order.orderVendorAttributes!.entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            '${_formatKey(e.key)}: ',
                            style: const TextStyle(color: Color(0xFFB9B9B9)),
                          ),
                        ),
                        Flexible(
                          child: AttributeValueWidget(value: e.value),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (order.orderCustomerAttributes != null &&
                  order.orderCustomerAttributes!.isNotEmpty) ...[
                const Gap(AppSpacing.md),
                Text(
                  'Customer Information',
                  style: TextStyle(
                    color: theme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(AppSpacing.sm),
                ...order.orderCustomerAttributes!.entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            '${_formatKey(e.key)}: ',
                            style: const TextStyle(color: Color(0xFFB9B9B9)),
                          ),
                        ),
                        Flexible(
                          child: AttributeValueWidget(value: e.value),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (order.orderVendorAttributes == null &&
                  order.orderCustomerAttributes == null &&
                  order.orderAttributes != null &&
                  order.orderAttributes!.isNotEmpty) ...[
                const Gap(AppSpacing.md),
                Text(
                  'Attributes',
                  style: TextStyle(
                    color: theme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(AppSpacing.sm),
                ...order.orderAttributes!.entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            '${_formatKey(e.key)}: ',
                            style: const TextStyle(color: Color(0xFFB9B9B9)),
                          ),
                        ),
                        Flexible(
                          child: AttributeValueWidget(value: e.value),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerDetails(VendorOrder order) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customer',
          style: TextStyle(
            color: theme.onSurface,
            fontSize: 18.8,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        const Gap(AppSpacing.md),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.primaryContainer,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  semanticLabel: SemanticLabels.userAvatar,
                ),
              ),
              const Gap(AppSpacing.md),
              Expanded(
                child: Text(
                  order.customerName ?? 'Customer',
                  style: TextStyle(
                    color: theme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentsSection(VendorOrder order) {
    final theme = Theme.of(context).colorScheme;
    final docsAsync = ref.watch(serviceOrderDocumentsProvider(widget.orderId));

    return docsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (docs) {
        if (docs.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Documents',
              style: TextStyle(
                color: theme.onSurface,
                fontSize: 18.8,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const Gap(AppSpacing.md),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.primaryContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: docs.map((doc) => _buildDocumentItem(doc, theme)).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDocumentItem(ServiceOrderDocument doc, ColorScheme theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => _launchDocumentUrl(doc.fileUrl),
        child: Row(
          children: [
            Icon(
              Icons.description,
              size: 20,
              color: AppColors.primary,
            ),
            const Gap(AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc.originalFilename.isNotEmpty
                        ? doc.originalFilename
                        : doc.fileUrl.split('/').last,
                    style: TextStyle(
                      color: const Color(0xFF2196F3),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFF2196F3),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    doc.documentType.isNotEmpty
                        ? doc.documentType[0].toUpperCase() + doc.documentType.substring(1)
                        : 'Document',
                    style: TextStyle(
                      color: theme.onSurface.withValues(alpha: 0.5),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.open_in_new,
              size: 16,
              color: Color(0xFF2196F3),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchDocumentUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildRejectionReason(VendorOrder order) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rejection Reason',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          const Gap(AppSpacing.sm),
          Text(
            order.rejectionReason ?? 'No reason provided',
            style: TextStyle(color: theme.onSurface),
          ),
        ],
      ),
    );
  }

  Widget _buildCancellationDetails(VendorOrder order) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cancellation Details',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          const Gap(AppSpacing.sm),
          Text(
            'Reason: ${order.cancellationReason ?? "No reason provided"}',
            style: TextStyle(color: theme.onSurface.withValues(alpha: 0.7)),
          ),
          if (order.cancellationFee != null) ...[
            const Gap(AppSpacing.xs),
            Text(
              'Penalty Fee: ${order.cancellationFee} KWD',
              style: TextStyle(color: theme.onSurface.withValues(alpha: 0.7)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons(VendorOrder order) {
    final status = order.statusEnum;

    if (status == VendorOrderStatus.completed ||
        status == VendorOrderStatus.cancelled) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        if (status.canStartTravel) ...[
          _buildSingleButton(
            label: 'Start Travel',
            onPressed: _handleStartTravel,
            loading: _isStartingTravel,
          ),
        ] else if (status.canArrive) ...[
          _buildSingleButton(
            label: 'Mark Arrived',
            onPressed: _handleArrive,
            loading: _isArriving,
          ),
        ] else if (status.canStartService) ...[
          _buildSingleButton(
            label: 'Start Service',
            onPressed: _handleStartService,
            loading: _isStartingService,
          ),
        ] else if (status.canComplete) ...[
          _buildSingleButton(
            label: 'Complete Order',
            onPressed: () => _showCompleteDialog(order),
            loading: false,
            color: Colors.green,
          ),
        ],
      ],
    );
  }

  Widget _buildSingleButton({
    required String label,
    required VoidCallback onPressed,
    required bool loading,
    Color color = AppColors.primary,
  }) {
    return Semantics(
      button: true,
      onTapHint: label,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: loading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: loading
              ? ShimmerSkeletons.buttonSkeleton()
              : Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(
    String title,
    String value, {
    bool isSemiBold = false,
  }) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFB9B9B9),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
        ),
        const Gap(AppSpacing.xs),
        Text(
          value,
          style: TextStyle(
            color: theme.onSurface,
            fontSize: 14,
            fontWeight: isSemiBold ? FontWeight.w600 : FontWeight.w400,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, y • h:mm a').format(date.toLocal());
  }

  String _formatKey(String key) {
    return key
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
