import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class CheckoutStatusBadge extends StatelessWidget {
  final String status;
  final double? fontSize;

  const CheckoutStatusBadge({super.key, required this.status, this.fontSize});

  Color _getColor() {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'confirmed':
        return Colors.indigo;
      case 'shipped':
        return Colors.teal;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    final t = Translations.of(context).home.vendor.checkout_orders.status;
    final displayName = switch (status) {
      'pending' => t.pending,
      'processing' => t.processing,
      'confirmed' => t.confirmed,
      'shipped' => t.shipped,
      'delivered' => t.delivered,
      'cancelled' => t.cancelled,
      _ => status,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        displayName,
        style: TextStyle(
          color: color,
          fontSize: fontSize ?? 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
