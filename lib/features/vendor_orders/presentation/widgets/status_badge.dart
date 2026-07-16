import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/vendor_order_status.dart';

class StatusBadge extends StatelessWidget {
  final VendorOrderStatus status;
  final double? fontSize;

  const StatusBadge({super.key, required this.status, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${SemanticLabels.statusBadgePrefix} ${status.displayName}',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: status.getColor().withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: status.getColor(), width: 1),
        ),
        child: Text(
          status.displayName,
          style: TextStyle(
            color: status.getColor(),
            fontSize: fontSize ?? 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
