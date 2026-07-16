import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/utils/fallback_images.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/vendor/presentation/providers/vendor_provider.dart';
import 'package:app/shared/ui/upload/image_upload_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class VendorCoverImageScreen extends ConsumerStatefulWidget {
  const VendorCoverImageScreen({super.key});

  @override
  ConsumerState<VendorCoverImageScreen> createState() =>
      _VendorCoverImageScreenState();
}

class _VendorCoverImageScreenState
    extends ConsumerState<VendorCoverImageScreen> {
  String? _uploadedUrl;

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(vendorProfileProvider);
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerSection(context),
              const Gap(AppSpacing.xl),
              _coverImageSection(profileState),
              const Gap(AppSpacing.xl),
              _instructionsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24,
            color: Color(0xFFE28C37),
          ),
        ),
        const Gap(AppSpacing.md),
        Text(
          t.vendor_dashboard.cover_image.screen_title,
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: theme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _coverImageSection(AsyncValue profileState) {
    final coverUrl = _uploadedUrl ?? profileState.valueOrNull?.coverImageUrl;
    final isNetworkImage = coverUrl != null && coverUrl.isNotEmpty;
    final theme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: theme.primaryContainer,
            borderRadius: BorderRadius.circular(16.6),
          ),
          clipBehavior: Clip.antiAlias,
          child: isNetworkImage
              ? Image.network(
                  coverUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Image.asset(
                    FallbackImages.vendorCoverDefault,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  FallbackImages.vendorCoverDefault,
                  fit: BoxFit.cover,
                ),
        ),
        const Gap(AppSpacing.lg),
        Center(
          child: ImageUploadCard(
            currentImageUrl: coverUrl,
            fallbackAsset: FallbackImages.vendorCoverDefault,
            folder: 'vendor-covers',
            title: t.vendor_dashboard.cover_image.screen_title,
            width: 150,
            height: 100,
            onUploadComplete: (url) async {
              final success = await ref
                  .read(vendorProfileProvider.notifier)
                  .updateCoverImage(url);
              if (success && mounted) {
                setState(() => _uploadedUrl = url);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      t.vendor_dashboard.cover_image.updated_success,
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _instructionsSection() {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.vendor_dashboard.cover_image.guidelines_title,
          style: GoogleFonts.poppins(
            color: theme.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(AppSpacing.md),
        Text(
          t.vendor_dashboard.cover_image.guidelines_text,
          style: GoogleFonts.poppins(
            color: AppColors.textSecondary,
            fontSize: 12,
            height: 1.8,
          ),
        ),
      ],
    );
  }
}
