import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class RejectOrderDialog extends StatefulWidget {
  final String orderId;
  final Future<void> Function(String? reason) onReject;

  const RejectOrderDialog({
    super.key,
    required this.orderId,
    required this.onReject,
  });

  @override
  State<RejectOrderDialog> createState() => _RejectOrderDialogState();
}

class _RejectOrderDialogState extends State<RejectOrderDialog> {
  final _reasonController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _handleReject() async {
    setState(() => _isLoading = true);
    try {
      await widget.onReject(
        _reasonController.text.trim().isEmpty
            ? null
            : _reasonController.text.trim(),
      );
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to reject order: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return AlertDialog(
      backgroundColor: theme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        'Reject Order',
        style: TextStyle(color: theme.onSurface, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Are you sure you want to reject this order?',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const Gap(AppSpacing.md),
          TextField(
            controller: _reasonController,
            maxLines: 3,
            style: TextStyle(color: theme.onSurface),
            decoration: InputDecoration(
              hintText: 'Rejection reason (optional)',
              hintStyle: const TextStyle(color: Color(0xFF757575)),
              filled: true,
              fillColor: theme.primaryContainer,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(false),
          child: Text(
            'Cancel',
            style: TextStyle(color: theme.onSurface.withValues(alpha: 0.7)),
          ),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleReject,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: _isLoading
              ? ShimmerSkeletons.buttonSkeleton()
              : Text('Reject', style: TextStyle(color: theme.onSurface)),
        ),
      ],
    );
  }
}
