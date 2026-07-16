// import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/features/vendor/presentation/providers/vendor_operators_provider.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/add_operator_screen.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class VendorsOperatorsScreen extends ConsumerWidget {
  const VendorsOperatorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final operatorsAsync = ref.watch(vendorOperatorsProvider);
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        backgroundColor: theme.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          t.vendor_dashboard.operators.screen_title,
          style: GoogleFonts.poppins(
            color: theme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
        child: Column(
          children: [
            operatorsAsync.when(
              data: (operators) {
                if (operators.isEmpty) {
                  return _buildEmptyState(context);
                }
                return _buildOperatorsList(context, ref, operators);
              },
              loading: () => ShimmerSkeletons.cardSkeleton(height: 400),
              error: (error, _) => _buildErrorState(context, ref, error),
            ),
            Gap(AppSpacing.lg),
            _buildAddButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOperatorsList(
    BuildContext context,
    WidgetRef ref,
    List operators,
  ) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: operators.length,
        itemBuilder: (context, index) {
          final operator = operators[index];
          return _buildOperatorCard(context, ref, operator);
        },
      ),
    );
  }

  Widget _buildOperatorCard(
    BuildContext context,
    WidgetRef ref,
    dynamic operator,
  ) {
    final theme = Theme.of(context).colorScheme;
    return Card(
      color: theme.primaryContainer,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _buildAvatar(operator),
            const Gap(AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    operator.name,
                    style: GoogleFonts.poppins(
                      color: theme.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(AppSpacing.xs),
                  Text(
                    operator.phone,
                    style: GoogleFonts.poppins(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const Gap(AppSpacing.xs),
                  Text(
                    operator.email,
                    style: GoogleFonts.poppins(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            _buildStatusToggle(context, ref, operator),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(dynamic operator) {
    return CircleAvatar(
      radius: 28,
      backgroundColor: AppColors.primary.withValues(alpha: 0.2),
      backgroundImage: operator.avatarUrl != null
          ? NetworkImage(operator.avatarUrl!)
          : null,
      child: operator.avatarUrl == null
          ? const Icon(Icons.person, color: AppColors.primary, size: 28)
          : null,
    );
  }

  Widget _buildStatusToggle(
    BuildContext context,
    WidgetRef ref,
    dynamic operator,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Switch(
          value: operator.isActive,
          onChanged: (value) async {
            final notifier = ref.read(vendorOperatorsProvider.notifier);
            if (value) {
              await notifier.activateOperator(operator.id);
            } else {
              await notifier.deactivateOperator(operator.id);
            }
          },
          activeThumbColor: AppColors.primary,
          inactiveThumbColor: Colors.grey,
        ),
        Text(
          operator.isActive
              ? t.vendor_dashboard.operators.active
              : t.vendor_dashboard.operators.inactive,
          style: GoogleFonts.poppins(
            color: operator.isActive ? AppColors.primary : Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const Gap(16),
            Text(
              t.vendor_dashboard.operators.empty_title,
              style: GoogleFonts.poppins(
                color: theme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(AppSpacing.sm),
            Text(
              t.vendor_dashboard.operators.empty_subtitle,
              style: GoogleFonts.poppins(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, Object error) {
    final t = Translations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: AppColors.red),
          const Gap(AppSpacing.md),
          Text(
            t.vendor_dashboard.operators.error_loading,
            style: GoogleFonts.poppins(
              color: AppColors.red,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            error.toString(),
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const Gap(AppSpacing.lg),
          ElevatedButton(
            onPressed: () {
              ref.read(vendorOperatorsProvider.notifier).refresh();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: Text(t.vendor_dashboard.profile.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: GradientButton(
            text: t.vendor_dashboard.operators.add_new,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddOperatorScreen()),
            ),
          ),
        ),
      ),
    );
  }
}
