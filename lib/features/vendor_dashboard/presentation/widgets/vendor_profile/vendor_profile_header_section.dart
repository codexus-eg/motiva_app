import 'package:app/core/utils/fallback_images.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/vendor/presentation/providers/vendor_provider.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/setting/vendor_setting_screen.dart';
import 'package:app/shared/ui/images/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class VendorProfileHeaderSection extends ConsumerWidget {
  const VendorProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(vendorProfileProvider);
    final theme = Theme.of(context).colorScheme;

    final t = Translations.of(context).vendor_dashboard.profile;
    return profileAsync.when(
      data: (profile) {
        if (profile == null) {
          return _buildMissingProfileHeader(context);
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  CircleNetworkImage(
                    radius: 22,
                    imageUrl: profile.logoUrl,
                    fallbackAsset: FallbackImages.vendorLogo,
                    backgroundColor: const Color(0xFFE28C37),
                    placeholderText: profile.businessName.isNotEmpty
                        ? profile.businessName[0].toUpperCase()
                        : 'V',
                  ),
                  const Gap(AppSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.businessName,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 20,
                            color: theme.onSurface,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            if (profile.isVerified) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF017B3F,
                                  ).withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  t.verified,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: const Color(0xFF017B3F),
                                  ),
                                ),
                              ),
                              const Gap(AppSpacing.sm),
                            ],
                            Text(
                              '${profile.rating} ★ (${profile.totalReviews} ${t.reviews})',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VendorSettingScreen(),
                    ),
                  );
                },
                child: SvgPicture.asset(
                  'assets/icons/user_profile/settings.svg',
                  height: 28,
                  width: 28,
                  colorFilter: ColorFilter.mode(
                    theme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        );
      },
      loading: () => _buildSkeletonLoader(),
      error: (error, stack) => _buildErrorHeader(context),
    );
  }

  Widget _buildMissingProfileHeader(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).vendor_dashboard.profile;
    return Row(
      children: [
        const CircleAvatar(
          radius: 22,
          backgroundColor: Color(0xFFE28C37),
          child: Text(
            "V",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const Gap(AppSpacing.lg),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.vendor_profile,
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: theme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              t.profile_not_set_up,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSkeletonLoader() {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            shape: BoxShape.circle,
          ),
        ),
        const Gap(AppSpacing.lg),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const Gap(AppSpacing.sm),
            Container(
              width: 100,
              height: 14,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildErrorHeader(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).vendor_dashboard.profile;
    return Row(
      children: [
        const CircleAvatar(
          radius: 22,
          backgroundColor: Color(0xFFE28C37),
          child: Text(
            "V",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const Gap(AppSpacing.lg),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.vendor_profile,
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: theme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              t.unable_to_load_profile,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
