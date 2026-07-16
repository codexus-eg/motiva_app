import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/vendor/presentation/providers/vendor_operators_provider.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class AssignOperatorDialog extends ConsumerStatefulWidget {
  final String orderId;
  final Function(String operatorId) onAssign;

  const AssignOperatorDialog({super.key, required this.orderId, required this.onAssign});

  @override
  ConsumerState<AssignOperatorDialog> createState() =>
      _AssignOperatorDialogState();
}

class _AssignOperatorDialogState extends ConsumerState<AssignOperatorDialog> {
  String? _selectedOperatorId;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final operatorsAsync = ref.watch(vendorOperatorsProvider);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assign Operator',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.onSurface,
                ),
              ),
              const Gap(AppSpacing.sm),
              Text(
                'Select an operator to assign to this order',
                style: TextStyle(
                  fontSize: 14,
                  color: theme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const Gap(AppSpacing.md),
              operatorsAsync.when(
                data: (operators) {
                  final activeOperators = operators
                      .where((op) => op.isActive)
                      .toList();
                  if (activeOperators.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.person_off,
                            size: 48,
                            color: theme.onSurface.withValues(alpha: 0.5),
                          ),
                          const Gap(AppSpacing.sm),
                          Text(
                            'No active operators available',
                            style: TextStyle(
                              color: theme.onSurface.withValues(alpha: 0.7),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                  return Column(
                    children: activeOperators.map((operator) {
                      final isSelected = _selectedOperatorId == operator.id;
                      return InkWell(
                        onTap: () {
                          setState(() => _selectedOperatorId = operator.id);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withValues(alpha: 0.1)
                                : theme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const Gap(AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      operator.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: theme.onSurface,
                                      ),
                                    ),
                                    Text(
                                      operator.phone,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: theme.onSurface.withValues(
                                          alpha: 0.7,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle,
                                  color: AppColors.primary,
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
                loading: () => ShimmerSkeletons.cardSkeleton(),
                error: (error, _) => Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Error loading operators: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
              const Gap(AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: theme.onSurface.withValues(alpha: 0.3),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: theme.onSurface),
                      ),
                    ),
                  ),
                  const Gap(AppSpacing.md),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _selectedOperatorId == null || _isLoading
                          ? null
                          : () async {
                              setState(() => _isLoading = true);
                              try {
                                await widget.onAssign(_selectedOperatorId!);
                                if (mounted) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Operator assigned successfully',
                                      ),
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Failed to assign operator: $e',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              } finally {
                                if (mounted) {
                                  setState(() => _isLoading = false);
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? ShimmerSkeletons.buttonSkeleton()
                          : const Text(
                              'Assign',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
