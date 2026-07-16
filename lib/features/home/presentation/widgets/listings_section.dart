import 'package:app/i18n/strings.g.dart' show Translations;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class ListingsSection extends StatelessWidget {
  const ListingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).home.customer.listing;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTab(t.popular_today, true, context),
              Gap(AppSpacing.xl),
              _buildTab(t.top_vendors, false, context),
              Gap(AppSpacing.xl),
              _buildTab(t.new_vendors, false, context),
            ],
          ),
        ),
        const Gap(AppSpacing.md),
        Column(
          children: [
            _buildListingCard(
              title: 'Battery jump-start',
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor  tempor ',
              price: 'KD 20',
              points: '+ 3',
              imagePath: 'assets/images/listing_thumb_1.png',
              showMetadata: true,
              context: context,
            ),
            const Gap(AppSpacing.md),
            _buildListingCard(
              title: 'Sell a Car',
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor  tempor ',
              imagePath: 'assets/images/listing_thumb_2.png',
              showMetadata: false,
              height: 109,
              context: context,
            ),
            const Gap(AppSpacing.md),
            _buildListingCard(
              title: 'Open Crane',
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor  tempor ',
              price: 'KD 200',
              points: '+ 3',
              imagePath: 'assets/images/listing_thumb_3.png',
              showMetadata: true,
              isImageBg: true, // Specific for third card
              context: context,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTab(String label, bool isSelected, BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          child: Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
        if (isSelected)
          Container(
            width: 119, // Fixed width from design for tab indicator
            height: 3,
            decoration: const BoxDecoration(
              color: Color(0xFFDC8735),
              borderRadius: BorderRadius.vertical(top: Radius.circular(100)),
            ),
          ),
      ],
    );
  }

  Widget _buildListingCard({
    required String title,
    required String description,
    String? price,
    String? points,
    required String imagePath,
    required bool showMetadata,
    double height = 161,
    bool isImageBg = false,
    required BuildContext context,
  }) {
    final theme = Theme.of(context);

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface,
                      height: 1.46,
                    ),
                  ),
                  const Gap(AppSpacing.xs),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      color: theme.colorScheme.onSurface,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (showMetadata) ...[
                    const Gap(AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFF8BA7F),
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                price!,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFF8BA7F),
                                ),
                              ),
                            ),
                            const Gap(AppSpacing.sm),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    points!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFFFF5500),
                                    ),
                                  ),
                                  const Gap(AppSpacing.xs),
                                  SvgPicture.asset(
                                    'assets/icons/award.svg',
                                    width: 12,
                                    height: 12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Gap(AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFDC8735),
                            Color(0xFFDC8735),
                          ], // Simplified gradient from Figma
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/shopping_bag.svg',
                            width: 11,
                            height: 11,
                          ),
                          const Gap(AppSpacing.xs),
                          Text(
                            'Add to Cart',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Container(
            width: 160,
            height: double.infinity,
            color: isImageBg ? const Color(0xFFE0E0E0) : null,
            child: isImageBg
                ? Center(
                    child: Image.asset(
                      imagePath,
                      width: 137,
                      height: 102,
                      fit: BoxFit.contain,
                    ),
                  )
                : Image.asset(imagePath, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
