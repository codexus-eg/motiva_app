import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AllCarListingCard extends StatelessWidget {
  final String image;
  final String title;
  final String year;
  final String km;
  final String price;
  final bool isGood;
  final bool isInspected;
  final bool isFeatured;
  final Function()? onTap;

  const AllCarListingCard({
    super.key,
    required this.image,
    required this.title,
    required this.year,
    required this.km,
    required this.price,
    this.isInspected = false,
    this.isFeatured = false,
    this.onTap,
    required this.isGood,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          border: isFeatured
              ? Border.all(color: Colors.orange, width: 2)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: image.startsWith('http')
                      ? Image.network(
                          image,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              width: double.infinity,
                              color: const Color(0xFF2A2A2A),
                              child: const Icon(
                                Icons.directions_car,
                                size: 64,
                                color: Colors.white54,
                              ),
                            );
                          },
                        )
                      : Image.asset(
                          image,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              width: double.infinity,
                              color: const Color(0xFF2A2A2A),
                              child: const Icon(
                                Icons.directions_car,
                                size: 64,
                                color: Colors.white54,
                              ),
                            );
                          },
                        ),
                ),

                /// Featured Badge
                if (isFeatured)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.local_fire_department,
                            color: Colors.white,
                            size: 16,
                          ),
                          Gap(AppSpacing.sm),
                          Text(
                            t.buy_a_car.listing_card.featured,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),

                /// Camera Count
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.camera_alt, size: 16),
                        Gap(AppSpacing.sm),
                        Text("19"),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            /// Info
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(AppSpacing.md),

                  /// Year & KM
                  Row(
                    children: [
                      _infoChip(year),
                      const Gap(AppSpacing.md),
                      _infoChip(km),
                      const Spacer(),
                      if (isGood) _inspectionBadge(),
                    ],
                  ),
                  const Gap(AppSpacing.md),
                  const Divider(color: Colors.white12),
                  const Gap(AppSpacing.md),

                  /// Price
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffF8BA7F)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      price,
                      style: const TextStyle(
                        color: Color(0xffF8BA7F),
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF393939),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xFFF8BA7F), fontSize: 15),
      ),
    );
  }

  Widget _inspectionBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Icon(
            isInspected ? Icons.check_circle_outline : Icons.cancel_outlined,
            color: isInspected ? Colors.green : Colors.red,
            size: 16,
          ),
          const Gap(AppSpacing.sm),
          Text(
            isInspected
                ? t.buy_a_car.listing_card.inspected
                : t.buy_a_car.listing_card.not_inspected,
            style: TextStyle(color: isInspected ? Colors.green : Colors.red),
          ),
        ],
      ),
    );
  }
}
