import 'package:app/core/utils/app_logger.dart';
import 'package:app/core/utils/fallback_images.dart';
import 'package:app/features/public_services/presentation/screens/category_vendors_screen.dart';
import 'package:app/features/public_marketplace/presentation/screens/marketplace_category_screen.dart';
import 'package:app/features/public_services/presentation/providers/public_services_provider.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/images/network_image_widget.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class ServicesGrid extends ConsumerWidget {
  final VoidCallback? onViewAllPressed;

  const ServicesGrid({
    super.key,
    this.onViewAllPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(publicServiceCategoriesProvider);
    final theme = Theme.of(context);
    final t = Translations.of(context).home.customer.services_grid;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            GestureDetector(
              onTap: onViewAllPressed,
              behavior: HitTestBehavior.opaque,
              child: Text(
                t.view_all,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFECA553),
                ),
              ),
            ),
          ],
        ),
        const Gap(AppSpacing.md),
        categoriesAsync.when(
          loading: () =>  SizedBox(
            height: 120,
            child: ShimmerSkeletons.gridItemSkeleton(),
          ),
          error: (error, stackTrace) {
            AppLogger.error(
              t.error_category,
              error: error,
              stackTrace: stackTrace,
            );
            return _buildErrorState(context, error, ref);
          },
          data: (categories) {
            if (categories.isEmpty) {
              return _buildEmptyState(context, ref);
            }
            return _buildDynamicGrid(context, categories);
          },
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, Object error, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context).home.customer.services_grid.error;

    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 32),
          const Gap(AppSpacing.sm),
          Text(
            t.title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const Gap(AppSpacing.sm),
          TextButton(
            onPressed: () {
              ref.invalidate(publicServiceCategoriesProvider);
            },
            child: Text(
              t.retry,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFECA553),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = Translations.of(context).home.customer.services_grid.empty;

    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.category_outlined, color: Colors.white54, size: 32),
          const Gap(AppSpacing.sm),
          Text(
            t.title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const Gap(AppSpacing.sm),
          TextButton(
            onPressed: () {
              ref.invalidate(publicServiceCategoriesProvider);
            },
            child: Text(
              t.refresh,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFECA553),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDynamicGrid(
    BuildContext context,
    List<ServiceCategory> categories,
  ) {
    final dynamicItems = categories.take(6).map((category) {
      return _buildDynamicItem(context, category);
    }).toList();

    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 20,
      crossAxisSpacing: 10,
      childAspectRatio: 0.75,
      children: [
        ...dynamicItems,
        _buildAccessoriesItem(context),
        _buildSparePartsItem(context),
      ],
    );
  }

  Widget _buildAccessoriesItem(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const MarketplaceCategoryScreen(productType: 'accessory'),
          ),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    FallbackImages.serviceAccessories,
                    width: 52,
                    height: 52,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            'Accessories',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSparePartsItem(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const MarketplaceCategoryScreen(productType: 'spare_part'),
          ),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/services_spare_parts.png',
                    width: 52,
                    height: 52,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            Translations.of(context).home.services_grid.spare_parts,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDynamicItem(BuildContext context, ServiceCategory category) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => _navigateToCategory(context, category),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: NetworkImageWidget(
                    imageUrl: category.iconUrl,
                    fallbackAsset: FallbackImages.categoryIcon(category.slug),
                    width: 52,
                    height: 52,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            category.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToCategory(BuildContext context, ServiceCategory category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryVendorsScreen(category: category),
      ),
    );
  }
}
