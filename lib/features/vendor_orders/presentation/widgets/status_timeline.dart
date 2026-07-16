import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../domain/entities/vendor_order_status.dart';

class StatusTimeline extends StatelessWidget {
  final VendorOrderStatus currentStatus;

  const StatusTimeline({super.key, required this.currentStatus});

  static const List<VendorOrderStatus> _timeline = [
    VendorOrderStatus.pendingAcceptance,
    VendorOrderStatus.enRoute,
    VendorOrderStatus.arrived,
    VendorOrderStatus.inProgress,
    VendorOrderStatus.completed,
  ];

  int get _currentIndex {
    int index = _timeline.indexOf(currentStatus);
    if (index == -1) {
      if (currentStatus == VendorOrderStatus.cancelled) {
        return -2;
      }
    }
    return index;
  }

  @override
  Widget build(BuildContext context) {
    if (currentStatus == VendorOrderStatus.cancelled) {
      return _buildCancelledRejectedStatus();
    }
    final theme = Theme.of(context).colorScheme;

    return Semantics(
      label: '${SemanticLabels.statusBadgePrefix} ${currentStatus.displayName}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Status',
            style: TextStyle(
              color: theme.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(12),
          Row(
            children: _timeline.asMap().entries.map((entry) {
              final index = entry.key;
              final status = entry.value;
              final isCompleted = index <= _currentIndex;
              final isCurrent = index == _currentIndex;

              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isCompleted
                                  ? status.getColor()
                                  : Colors.grey[700],
                              border: isCurrent
                                  ? Border.all(color: Colors.white, width: 2)
                                  : null,
                            ),
                            child: Center(
                              child: isCompleted
                                  ? const Icon(
                                      Icons.check,
                                      size: 14,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ),
                          const Gap(6),
                          Text(
                            _getShortLabel(status),
                            style: TextStyle(
                              color: isCompleted
                                  ? theme.onSurface
                                  : Colors.grey[500],
                              fontSize: 10,
                              fontWeight: isCurrent
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (index < _timeline.length - 1)
                      Expanded(
                        child: Container(
                          height: 2,
                          margin: const EdgeInsets.only(bottom: 28),
                          color: index < _currentIndex
                              ? _timeline[index].getColor()
                              : Colors.grey[700],
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelledRejectedStatus() {
    final isCancelled = currentStatus == VendorOrderStatus.cancelled;
    return Semantics(
      label: isCancelled ? 'Order Cancelled' : 'Order Rejected',
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: currentStatus.getColor().withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: currentStatus.getColor()),
        ),
        child: Row(
          children: [
            Icon(
              isCancelled ? Icons.cancel_outlined : Icons.block,
              color: currentStatus.getColor(),
              size: 24,
            ),
            const Gap(12),
            Text(
              isCancelled ? 'Order Cancelled' : 'Order Rejected',
              style: TextStyle(
                color: currentStatus.getColor(),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getShortLabel(VendorOrderStatus status) {
    switch (status) {
      case VendorOrderStatus.pendingAcceptance:
        return 'Pending';
      case VendorOrderStatus.enRoute:
        return 'En Route';
      case VendorOrderStatus.arrived:
        return 'Arrived';
      case VendorOrderStatus.inProgress:
        return 'In Progress';
      case VendorOrderStatus.completed:
        return 'Completed';
      default:
        return status.displayName;
    }
  }
}
