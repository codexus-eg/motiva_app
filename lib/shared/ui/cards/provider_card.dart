import 'package:app/core/utils/fallback_images.dart';
import 'package:app/shared/ui/images/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class ProviderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String rating;
  final String logoAsset;
  final bool isSvgLogo;
  final bool isNetworkImage;
  final String? badgeText;
  final Color? badgeColor;
  final IconData? badgeIcon;
  final VoidCallback onTap;

  const ProviderCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.logoAsset,
    this.isSvgLogo = false,
    this.isNetworkImage = false,
    this.badgeText,
    this.badgeColor,
    this.badgeIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          // const Color(0xFF282A31),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 66,
              height: 66,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              child: _buildLogo(),
            ),
            const Gap(AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const Gap(AppSpacing.xs),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const Gap(AppSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            rating,
                            style: GoogleFonts.montserrat(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const Gap(AppSpacing.xs),
                          SvgPicture.asset(
                            'assets/icons/notification.svg',
                            height: 10,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFFFFC107),
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                      if (badgeText != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: badgeColor ?? const Color(0xFFDC8735),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              if (badgeIcon != null) ...[
                                Icon(badgeIcon, size: 10, color: Colors.white),
                                const Gap(AppSpacing.xs),
                              ],
                              Text(
                                badgeText!,
                                style: GoogleFonts.roboto(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
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
    );
  }

  Widget _buildLogo() {
    if (isNetworkImage) {
      return NetworkImageWidget(
        imageUrl: logoAsset,
        fallbackAsset: FallbackImages.vendorLogo,
        fit: BoxFit.cover,
      );
    }

    if (isSvgLogo) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset(logoAsset),
      );
    }

    return Image.asset(
      logoAsset,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) =>
          Image.asset(FallbackImages.vendorLogo, fit: BoxFit.cover),
    );
  }
}
