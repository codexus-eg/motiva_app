import 'package:app/features/user_dashboard/presentation/screens/orders_screen.dart';
import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../customer_orders/domain/entities/customer_order.dart';
import '../../../customer_orders/presentation/providers/customer_orders_provider.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class OrderConfirmationScreen extends ConsumerStatefulWidget {
  final CustomerOrder order;

  const OrderConfirmationScreen({super.key, required this.order});

  @override
  ConsumerState<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState
    extends ConsumerState<OrderConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(AppSpacing.xl),
              _buildSuccessIcon(),
              const Gap(AppSpacing.lg),
              _buildTitle(),
              const Gap(AppSpacing.sm),
              _buildOrderReference(),
              const Gap(AppSpacing.xl),
              _buildStatusCard(),
              const Gap(AppSpacing.lg),
              _buildInfoCard(),
              const Gap(AppSpacing.xl),
              _buildActionButton(context),
              const Gap(AppSpacing.md),
              _buildSecondaryButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(40),
      ),
      child: const Icon(Icons.check_circle, color: Colors.green, size: 48),
    );
  }

  Widget _buildTitle() {
    final theme = Theme.of(context);
    final t = Translations.of(context).booking.order_confirmation;
    return Text(
      t.title,
      style: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onSurface,
      ),
    );
  }

  Widget _buildOrderReference() {
    final theme = Theme.of(context);
    final t = Translations.of(context).booking.order_confirmation;
    return Text(
      '${t.order} ${widget.order.orderRef}',
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
      ),
    );
  }

  Widget _buildStatusCard() {
    final theme = Theme.of(context);
    final t = Translations.of(context).booking.order_confirmation.status;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.green.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 20),
              const Gap(AppSpacing.sm),
              Text(
                t.title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.md),
          Text(
            t.description,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    final theme = Theme.of(context);
    final t = Translations.of(context).booking.order_confirmation.info;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.order.serviceName != null) ...[
            _buildInfoRow(t.service, widget.order.serviceName!),
            const Divider(color: Color(0xFF383A42), height: 24),
          ],
          if (widget.order.vendorName != null) ...[
            _buildInfoRow(t.vendor, widget.order.vendorName!),
            const Divider(color: Color(0xFF383A42), height: 24),
          ],
          _buildInfoRow(t.base_amount, 'KD ${widget.order.baseAmount}'),
          if (widget.order.scheduledAt != null) ...[
            const Divider(color: Color(0xFF383A42), height: 24),
            _buildInfoRow(
              t.scheduled,
              _formatDateTime(widget.order.scheduledAt!),
            ),
          ],
          if (widget.order.locationAddress != null) ...[
            const Divider(color: Color(0xFF383A42), height: 24),
            _buildInfoRow(t.location, widget.order.locationAddress!),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    final t = Translations.of(context).booking.order_confirmation.button;
    return Semantics(
      label: SemanticLabels.backHomeButton,
      button: true,
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: () {
            ref.invalidate(customerOrdersProvider);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFE8C00),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            t.primary,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context).booking.order_confirmation.button;
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: () {
          ref.invalidate(customerOrdersProvider);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const OrdersScreen()),
            (route) => route.isFirst,
          );
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: theme.colorScheme.primary.withValues(alpha: 0.54),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          t.secondary,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final localDateTime = dateTime.toLocal();
    final date = '${localDateTime.day}/${localDateTime.month}/${localDateTime.year}';
    final hour = localDateTime.hour.toString().padLeft(2, '0');
    final minute = localDateTime.minute.toString().padLeft(2, '0');
    return '$date at $hour:$minute';
  }
}
