import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../domain/entities/customer_order.dart';
import 'package:app/core/theme/spacing.dart';

class CustomerStatusTimeline extends StatelessWidget {
  final CustomerOrderStatus currentStatus;

  const CustomerStatusTimeline({super.key, required this.currentStatus});

  static const List<CustomerOrderStatus> _timeline = [
    CustomerOrderStatus.pendingAcceptance,
    CustomerOrderStatus.accepted,
    CustomerOrderStatus.enRoute,
    CustomerOrderStatus.arrived,
    CustomerOrderStatus.inProgress,
    CustomerOrderStatus.completed,
  ];

  int get _currentIndex {
    final index = _timeline.indexOf(currentStatus);
    if (index == -1) {
      if (currentStatus == CustomerOrderStatus.rejected ||
          currentStatus == CustomerOrderStatus.cancelled) {
        return -2;
      }
    }
    return index;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    if (currentStatus == CustomerOrderStatus.rejected ||
        currentStatus == CustomerOrderStatus.cancelled) {
      return _buildCancelledRejectedStatus(theme);
    }

    return Column(
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
        const Gap(AppSpacing.md),
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
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCompleted
                                ? _statusColor(status)
                                : Colors.grey.shade700,
                            border: isCurrent
                                ? Border.all(color: Colors.white, width: 2)
                                : null,
                          ),
                          child: Center(
                            child: isCompleted
                                ? const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                        const Gap(AppSpacing.sm),
                        Text(
                          _getShortLabel(status),
                          style: TextStyle(
                            color: isCompleted
                                ? theme.onSurface
                                : Colors.grey.shade500,
                            fontSize: 10,
                            fontWeight:
                                isCurrent ? FontWeight.bold : FontWeight.normal,
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
                        height: 3,
                        margin: const EdgeInsets.only(bottom: 28),
                        decoration: BoxDecoration(
                          color: index < _currentIndex
                              ? _statusColor(_timeline[index])
                              : Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCancelledRejectedStatus(ColorScheme theme) {
    final isCancelled = currentStatus == CustomerOrderStatus.cancelled;
    final color = isCancelled ? Colors.red : Colors.grey;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Icon(
            isCancelled ? Icons.cancel_outlined : Icons.block,
            color: color,
            size: 28,
          ),
          const Gap(AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCancelled ? 'Order Cancelled' : 'Order Rejected',
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(AppSpacing.xs),
                Text(
                  isCancelled
                      ? 'This order has been cancelled.'
                      : 'The vendor could not fulfill this request.',
                  style: TextStyle(
                    color: theme.onSurface.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(CustomerOrderStatus status) {
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
      case CustomerOrderStatus.cancelled:
        return Colors.grey;
    }
  }

  String _getShortLabel(CustomerOrderStatus status) {
    switch (status) {
      case CustomerOrderStatus.pendingAcceptance:
        return 'Pending';
      case CustomerOrderStatus.accepted:
        return 'Accepted';
      case CustomerOrderStatus.enRoute:
        return 'On the Way';
      case CustomerOrderStatus.arrived:
        return 'Arrived';
      case CustomerOrderStatus.inProgress:
        return 'In Progress';
      case CustomerOrderStatus.completed:
        return 'Completed';
      default:
        return statusDisplay(status);
    }
  }

  String statusDisplay(CustomerOrderStatus status) {
    switch (status) {
      case CustomerOrderStatus.pendingAcceptance:
        return 'Pending Acceptance';
      case CustomerOrderStatus.accepted:
        return 'Accepted';
      case CustomerOrderStatus.enRoute:
        return 'En Route';
      case CustomerOrderStatus.arrived:
        return 'Arrived';
      case CustomerOrderStatus.inProgress:
        return 'In Progress';
      case CustomerOrderStatus.completed:
        return 'Completed';
      case CustomerOrderStatus.rejected:
        return 'Rejected';
      case CustomerOrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}
