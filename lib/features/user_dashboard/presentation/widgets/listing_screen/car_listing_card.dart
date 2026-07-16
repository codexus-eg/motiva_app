import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class CarListingCard extends StatelessWidget {
  final String image;
  final String title;
  final String year;
  final String km;
  final String price;
  final bool isInspected;
  final bool isFeatured;
  final void Function()? onTap;

  const CarListingCard({
    super.key,
    required this.image,
    required this.title,
    required this.year,
    required this.km,
    required this.price,
    required this.isInspected,
    this.isFeatured = false,
    this.onTap,
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
                  child: _buildImage(),
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
                          const Icon(
                            Icons.local_fire_department,
                            color: Colors.white,
                            size: 16,
                          ),
                          const Gap(AppSpacing.sm),
                          Text(
                            Translations.of(
                              context,
                            ).user_dashboard.listings.card.featured,
                            style: const TextStyle(color: Colors.white),
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
                      _inspectionBadge(context),
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

  Widget _inspectionBadge(BuildContext context) {
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
                ? Translations.of(
                    context,
                  ).user_dashboard.listings.card.inspected
                : Translations.of(
                    context,
                  ).user_dashboard.listings.card.not_inspected,
            style: TextStyle(color: isInspected ? Colors.green : Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    final isNetworkImage =
        image.startsWith('http://') || image.startsWith('https://');

    if (isNetworkImage) {
      return Image.network(
        image,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[300],
            child: const Icon(Icons.car_rental, size: 64, color: Colors.grey),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[300],
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      );
    } else {
      return Image.asset(
        image,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[300],
            child: const Icon(Icons.car_rental, size: 64, color: Colors.grey),
          );
        },
      );
    }
  }
}
