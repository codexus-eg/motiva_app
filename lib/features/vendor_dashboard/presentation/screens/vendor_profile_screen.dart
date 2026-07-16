import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/vendor/presentation/providers/vendor_provider.dart';
import 'package:app/features/vendor_dashboard/presentation/widgets/vendor_profile/vendor_profile_header_section.dart';
import 'package:app/features/vendor_dashboard/presentation/widgets/vendor_profile/vendor_profile_menu_section.dart';
import 'package:app/features/vendor_dashboard/presentation/widgets/vendor_profile/vendor_profile_promo_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class VendorProfileScreen extends ConsumerWidget {
  const VendorProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(vendorProfileProvider);
    final theme = Theme.of(context).colorScheme;

    return Container(
      color: theme.surface,
      child: SafeArea(
        bottom: false,
        child: profileAsync.when(
          data: (profile) {
            if (profile == null) {
              return _buildMissingProfileContent(context);
            }
            return _buildContent(context, ref);
          },
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          error: (error, stack) => _buildErrorContent(context, ref, error),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 100,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                VendorProfileHeaderSection(),
                Gap(AppSpacing.xl),
                VendorProfilePromoBanner(),
                Gap(AppSpacing.xl),
                VendorProfileMenuSection(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMissingProfileContent(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_outline, size: 64, color: AppColors.textSecondary),
          const Gap(AppSpacing.md),
          Text(
            t.vendor_dashboard.profile.not_found_title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: theme.onSurface,
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            t.vendor_dashboard.profile.not_found_description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorContent(BuildContext context, WidgetRef ref, Object error) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: AppColors.red),
          const Gap(AppSpacing.md),
          Text(
            t.vendor_dashboard.profile.error_loading_title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: theme.onSurface,
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            error.toString(),
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const Gap(AppSpacing.lg),
          ElevatedButton(
            onPressed: () {
              ref.read(vendorProfileProvider.notifier).refresh();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: theme.onSurface,
            ),
            child: Text(t.vendor_dashboard.profile.retry),
          ),
        ],
      ),
    );
  }
}
