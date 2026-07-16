import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/widgets/attribute_value_widget.dart';
import 'package:app/features/service-categories/presentation/providers/category_with_schema_provider.dart';
import 'package:app/features/service_order_documents/presentation/providers/service_order_documents_provider.dart';
import 'package:app/features/service_order_documents/domain/entities/service_order_document.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/features/vendor_orders/domain/entities/vendor_order.dart';
import 'package:app/features/vendor_orders/domain/entities/vendor_order_status.dart';
import 'package:app/features/vendor_orders/presentation/providers/vendor_orders_provider.dart';
import 'package:app/features/vendor_orders/presentation/widgets/dialogs/assign_operator_dialog.dart';
import 'package:app/features/vendor_orders/presentation/widgets/status_badge.dart';
import 'package:app/features/vendor_orders/presentation/widgets/status_timeline.dart';
import 'package:app/features/vendor_orders/presentation/widgets/dialogs/reject_order_dialog.dart';
import 'package:app/features/vendor_orders/presentation/widgets/dialogs/complete_order_dialog.dart';
import 'package:app/features/vendor_orders/data/dtos/vendor_order_actions_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:app/core/theme/spacing.dart';

class VendorRequestDetailsScreen extends ConsumerStatefulWidget {
  final String orderId;

  const VendorRequestDetailsScreen({super.key, required this.orderId});

  @override
  ConsumerState<VendorRequestDetailsScreen> createState() =>
      _VendorRequestDetailsScreenState();
}

class _VendorRequestDetailsScreenState
    extends ConsumerState<VendorRequestDetailsScreen> {
  bool _isAccepting = false;
  bool _isStartingTravel = false;
  bool _isArriving = false;
  bool _isStartingService = false;

  Future<void> _handleAccept() async {
    setState(() => _isAccepting = true);
    try {
      await ref
          .read(acceptOrderNotifierProvider.notifier)
          .accept(widget.orderId);
      if (mounted) {
        final t = Translations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.vendor_dashboard.request_details.order_accepted),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final t = Translations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              t.vendor_dashboard.request_details.accept_failed.replaceAll(
                '{error}',
                e.toString(),
              ),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isAccepting = false);
    }
  }

  Future<void> _handleStartTravel() async {
    setState(() => _isStartingTravel = true);
    try {
      await ref
          .read(startTravelNotifierProvider.notifier)
          .startTravel(widget.orderId);
      if (mounted) {
        final t = Translations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.vendor_dashboard.request_details.status_on_the_way),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final t = Translations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              t.vendor_dashboard.request_details.action_failed.replaceAll(
                '{error}',
                e.toString(),
              ),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isStartingTravel = false);
    }
  }

  Future<void> _handleArrive() async {
    setState(() => _isArriving = true);
    try {
      await ref.read(arriveNotifierProvider.notifier).arrive(widget.orderId);
      if (mounted) {
        final t = Translations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.vendor_dashboard.request_details.status_arrived),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final t = Translations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              t.vendor_dashboard.request_details.action_failed.replaceAll(
                '{error}',
                e.toString(),
              ),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isArriving = false);
    }
  }

  Future<void> _handleStartService() async {
    setState(() => _isStartingService = true);
    try {
      await ref
          .read(startServiceNotifierProvider.notifier)
          .startService(widget.orderId);
      if (mounted) {
        final t = Translations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.vendor_dashboard.request_details.service_started),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final t = Translations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              t.vendor_dashboard.request_details.action_failed.replaceAll(
                '{error}',
                e.toString(),
              ),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isStartingService = false);
    }
  }

  void _showRejectDialog() {
    showDialog(
      context: context,
      builder: (context) => RejectOrderDialog(
        orderId: widget.orderId,
        onReject: (reason) async {
          await ref
              .read(rejectOrderNotifierProvider.notifier)
              .reject(widget.orderId, RejectOrderDto(reason: reason));
        },
      ),
    );
  }

  bool get _requiresVendorDocuments {
    final orderAsync = ref.read(vendorOrderByIdProvider(widget.orderId));
    final order = orderAsync.value;
    if (order == null) return false;

    final serviceAsync = ref.read(
      vendorServiceApiProvider(order.vendorServiceId),
    );
    final service = serviceAsync.value;
    if (service == null) return false;

    final categoryAsync = ref.read(
      categoryWithSchemaProvider(service.categoryId),
    );
    final category = categoryAsync.value;
    if (category == null) return false;

    return category.behaviorConfig.requiresVendorDocuments;
  }

  String? get _serviceCategoryId {
    final orderAsync = ref.read(vendorOrderByIdProvider(widget.orderId));
    final order = orderAsync.value;
    if (order == null) return null;

    final serviceAsync = ref.read(
      vendorServiceApiProvider(order.vendorServiceId),
    );
    final service = serviceAsync.value;
    if (service == null) return null;

    return service.categoryId;
  }

  void _showCompleteDialog(VendorOrder order) {
    final serviceCategoryId = _serviceCategoryId;
    showDialog(
      context: context,
      builder: (context) => CompleteOrderDialog(
        orderId: widget.orderId,
        baseAmount: order.baseAmount,
        requiresVendorDocuments: _requiresVendorDocuments,
        serviceCategoryId: serviceCategoryId,
        onComplete: (finalPrice, documents) async {
          if (documents.isNotEmpty) {
            await ref
                .read(completeOrderNotifierProvider.notifier)
                .completeWithDocuments(
                  widget.orderId,
                  CompleteOrderDto(finalPrice: finalPrice),
                  documents,
                );
          } else {
            await ref
                .read(completeOrderNotifierProvider.notifier)
                .complete(
                  widget.orderId,
                  CompleteOrderDto(finalPrice: finalPrice),
                );
          }
        },
      ),
    );
  }

  void _showAssignOperatorDialog() {
    showDialog(
      context: context,
      builder: (context) => AssignOperatorDialog(
        orderId: widget.orderId,
        onAssign: (operatorId) async {
          await ref
              .read(assignOperatorNotifierProvider.notifier)
              .assignOperator(
                widget.orderId,
                AssignOperatorDto(
                  orderId: widget.orderId,
                  operatorId: operatorId,
                ),
              );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orderAsync = ref.watch(vendorOrderByIdProvider(widget.orderId));
    final order = orderAsync.value;
    if (order != null) {
      ref.watch(vendorServiceApiProvider(order.vendorServiceId));
    }
    final serviceAsync = order != null
        ? ref.watch(vendorServiceApiProvider(order.vendorServiceId))
        : null;
    final service = serviceAsync?.value;
    if (service != null) {
      ref.watch(categoryWithSchemaProvider(service.categoryId));
    }
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Scaffold(
      backgroundColor: theme.surface,
      body: orderAsync.when(
        data: (order) => _buildContent(context, order),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                t.vendor_dashboard.request_details.error.replaceAll(
                  '{error}',
                  error.toString(),
                ),
                style: TextStyle(color: theme.onSurface),
              ),
              const Gap(AppSpacing.md),
              ElevatedButton(
                onPressed: () =>
                    ref.invalidate(vendorOrderByIdProvider(widget.orderId)),
                child: Text(t.vendor_dashboard.profile.retry),
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
            const Gap(AppSpacing.md),
            _buildDocumentsSection(order),
            const Gap(AppSpacing.md),
            _buildCustomerDetails(order),
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
    final t = Translations.of(context);
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.orange,
            size: 20,
          ),
        ),
        const Gap(AppSpacing.md),
        Expanded(
          child: Text(
            t.vendor_dashboard.request_details.screen_title,
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
                    order.serviceName ??
                        t.vendor_dashboard.request_details.service_fallback,
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
                Expanded(
                  child: _buildInfoColumn(
                    t.vendor_dashboard.request_details.order_ref,
                    order.orderRef,
                  ),
                ),
                const Gap(AppSpacing.lg),
                Expanded(
                  child: _buildInfoColumn(
                    t.vendor_dashboard.request_details.amount,
                    order.displayPrice,
                    isSemiBold: true,
                  ),
                ),
              ],
            ),
            const Gap(AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: _buildInfoColumn(
                    t.vendor_dashboard.request_details.created,
                    _formatDate(order.createdAt),
                  ),
                ),
                if (order.scheduledAt != null) ...[
                  const Gap(AppSpacing.lg),
                  Expanded(
                    child: _buildInfoColumn(
                      t.vendor_dashboard.request_details.scheduled,
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
          hasRoute
              ? t.vendor_dashboard.request_details.route
              : t.vendor_dashboard.request_details.location,
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
                  t.vendor_dashboard.request_details.pickup,
                  order.pickupAddress,
                  order.pickupLat,
                  order.pickupLng,
                  Icons.trip_origin,
                ),
                const Gap(AppSpacing.md),
                _buildRouteLocationItem(
                  t.vendor_dashboard.request_details.dropoff,
                  order.dropoffAddress,
                  order.dropoffLat,
                  order.dropoffLng,
                  Icons.location_on,
                ),
              ] else ...[
                Text(
                  t.vendor_dashboard.request_details.address,
                  style: TextStyle(
                    color: theme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                const Gap(AppSpacing.sm),
                Text(
                  order.locationAddress ??
                      t.vendor_dashboard.request_details.no_address,
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
                    label: Text(
                      t.vendor_dashboard.request_details.open_in_maps,
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
          address ?? t.vendor_dashboard.request_details.no_address,
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
          t.vendor_dashboard.request_details.order_details,
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
                      t.vendor_dashboard.request_details.base_amount,
                      '${order.baseAmount} KWD',
                    ),
                  ),
                  Expanded(
                    child: _buildInfoColumn(
                      t.vendor_dashboard.request_details.total,
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
                  t.vendor_dashboard.request_details.service_specifications,
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
                        Flexible(child: AttributeValueWidget(value: e.value)),
                      ],
                    ),
                  ),
                ),
              ],
              if (order.orderCustomerAttributes != null &&
                  order.orderCustomerAttributes!.isNotEmpty) ...[
                const Gap(AppSpacing.md),
                Text(
                  t.vendor_dashboard.request_details.customer_information,
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
                        Flexible(child: AttributeValueWidget(value: e.value)),
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
                  t.vendor_dashboard.request_details.attributes,
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
                        Flexible(child: AttributeValueWidget(value: e.value)),
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
          t.vendor_dashboard.request_details.customer,
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
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const Gap(AppSpacing.md),
              Expanded(
                child: Text(
                  order.customerName ??
                      t.vendor_dashboard.request_details.customer,
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

  Widget _buildRejectionReason(VendorOrder order) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
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
          Text(
            t.vendor_dashboard.request_details.rejection_reason,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            order.rejectionReason ??
                t.vendor_dashboard.request_details.no_reason,
            style: TextStyle(color: theme.onSurface),
          ),
        ],
      ),
    );
  }

  Widget _buildCancellationDetails(VendorOrder order) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
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
          Text(
            t.vendor_dashboard.request_details.cancellation_details,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            t.vendor_dashboard.request_details.cancellation_reason_label
                .replaceAll(
                  '{reason}',
                  order.cancellationReason ??
                      t.vendor_dashboard.request_details.no_reason,
                ),
            style: TextStyle(color: theme.onSurface.withValues(alpha: 0.7)),
          ),
          if (order.cancellationFee != null) ...[
            const Gap(AppSpacing.xs),
            Text(
              t.vendor_dashboard.request_details.penalty_fee.replaceAll(
                '{fee}',
                order.cancellationFee.toString(),
              ),
              style: TextStyle(color: theme.onSurface.withValues(alpha: 0.7)),
            ),
          ],
        ],
      ),
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
              t.vendor_dashboard.request_details.documents,
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
                children: docs
                    .map((doc) => _buildDocumentItem(doc, theme))
                    .toList(),
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
            Icon(Icons.description, size: 20, color: AppColors.primary),
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
                        ? doc.documentType[0].toUpperCase() +
                              doc.documentType.substring(1)
                        : t.vendor_dashboard.request_details.document_fallback,
                    style: TextStyle(
                      color: theme.onSurface.withValues(alpha: 0.5),
                      fontSize: 11,
                      fontFamily: 'Poppins',
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

  Future<void> _launchDocumentUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildActionButtons(VendorOrder order) {
    final t = Translations.of(context);
    final status = order.statusEnum;

    if (status == VendorOrderStatus.completed ||
        status == VendorOrderStatus.cancelled ||
        status == VendorOrderStatus.rejected) {
      return const SizedBox.shrink();
    }

    final buttons = <Widget>[];

    // Primary status transitions
    if (status.canAccept) {
      buttons.add(
        _buildDualButtons(
          leftLabel: t.vendor_dashboard.request_details.reject,
          rightLabel: t.vendor_dashboard.request_details.accept,
          leftOnPressed: _showRejectDialog,
          rightOnPressed: _handleAccept,
          leftLoading: false,
          rightLoading: _isAccepting,
          leftColor: Colors.red,
          rightColor: AppColors.primary,
        ),
      );
    }

    if (status.canAssignOperator) {
      buttons.add(
        _buildSingleButton(
          label: t.vendor_dashboard.request_details.assign_operator,
          onPressed: _showAssignOperatorDialog,
          loading: false,
          color: AppColors.primary.withValues(alpha: 0.8),
        ),
      );
    }

    if (status.canStartTravel) {
      buttons.add(
        _buildSingleButton(
          label: t.vendor_dashboard.request_details.start_travel,
          onPressed: _handleStartTravel,
          loading: _isStartingTravel,
        ),
      );
    }

    if (status.canArrive) {
      buttons.add(
        _buildSingleButton(
          label: t.vendor_dashboard.request_details.mark_arrived,
          onPressed: _handleArrive,
          loading: _isArriving,
        ),
      );
    }

    if (status.canStartService) {
      buttons.add(
        _buildSingleButton(
          label: t.vendor_dashboard.request_details.start_service,
          onPressed: _handleStartService,
          loading: _isStartingService,
        ),
      );
    }

    if (status.canComplete) {
      buttons.add(
        _buildSingleButton(
          label: t.vendor_dashboard.request_details.complete,
          onPressed: () => _showCompleteDialog(order),
          loading: false,
          color: Colors.green,
        ),
      );
    }

    return Column(
      children: buttons
          .expand((button) => [button, const Gap(AppSpacing.sm)])
          .toList(),
    );
  }

  Widget _buildSingleButton({
    required String label,
    required VoidCallback onPressed,
    required bool loading,
    Color color = AppColors.primary,
  }) {
    return SizedBox(
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
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildDualButtons({
    required String leftLabel,
    required String rightLabel,
    required VoidCallback leftOnPressed,
    required VoidCallback rightOnPressed,
    required bool leftLoading,
    required bool rightLoading,
    Color leftColor = Colors.red,
    Color rightColor = AppColors.primary,
  }) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: leftLoading ? null : leftOnPressed,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: leftColor),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              leftLabel,
              style: TextStyle(
                color: leftColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const Gap(AppSpacing.md),
        Expanded(
          child: ElevatedButton(
            onPressed: rightLoading ? null : rightOnPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: rightColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: rightLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    rightLabel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ],
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
          style: TextStyle(
            color: const Color(0xFFB9B9B9),
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
