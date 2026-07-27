import 'package:app/core/theme/spacing.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/core/utils/fallback_images.dart';
import 'package:app/features/public_marketplace/presentation/screens/marketplace_category_screen.dart';
import 'package:app/features/public_services/presentation/screens/category_vendors_screen.dart';
import 'package:app/features/public_services/presentation/providers/public_services_provider.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/screens/sell_or_buy_car_screen.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/images/platform_image.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class AllServicesGrid extends ConsumerWidget {
  final String? searchQuery;

  const AllServicesGrid({super.key, this.searchQuery});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(publicServiceCategoriesProvider);

    return categoriesAsync.when(
      loading: () => ShimmerSkeletons.gridItemSkeleton(),
      error: (error, stackTrace) {
        AppLogger.error(
          'Failed to load service categories',
          error: error,
          stackTrace: stackTrace,
        );
        return _buildErrorState(context, ref);
      },
      data: (categories) {
        final filtered = searchQuery != null && searchQuery!.isNotEmpty
            ? categories
                  .where(
                    (c) => c.name.toLowerCase().contains(
                      searchQuery!.toLowerCase(),
                    ),
                  )
                  .toList()
            : categories;
        return _buildCombinedGrid(context, filtered);
      },
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context).services.all_services_grid.error;
    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2C33),
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
              color: Colors.white70,
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

  List<_StaticService> _getStaticServices(BuildContext context) {
    final t = Translations.of(context).services.all_services_grid.static;
    return [
      _StaticService(
        title: t.buy_a_car,
        image: 'assets/images/services_buy_car.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SellOrBuyCarScreen()),
          );
        },
      ),
      _StaticService(
        title: t.sell_your_car,
        image: 'assets/images/services_sell_car.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SellOrBuyCarScreen()),
          );
        },
      ),
      _StaticService(
        title: t.car_accessories,
        image: 'assets/images/services_accessories.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const MarketplaceCategoryScreen(productType: 'accessory'),
            ),
          );
        },
      ),
      _StaticService(
        title: t.spare_parts,
        image: 'assets/images/services_spare_parts.png',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const MarketplaceCategoryScreen(productType: 'spare_part'),
            ),
          );
        },
      ),
    ];
  }

  Widget _buildCombinedGrid(
    BuildContext context,
    List<ServiceCategory> categories,
  ) {
    final staticServices = _getStaticServices(context);
    final filteredStatic = searchQuery != null && searchQuery!.isNotEmpty
        ? staticServices
              .where(
                (s) =>
                    s.title.toLowerCase().contains(searchQuery!.toLowerCase()),
              )
              .toList()
        : staticServices;

    final totalCount = filteredStatic.length + categories.length;

    if (totalCount == 0) {
      final t = Translations.of(context).services.all_services_grid.empty;
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Text(
            t.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
          ),
        ),
      );
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 183 / 210,
      ),
      itemCount: totalCount,
      itemBuilder: (context, index) {
        if (index < filteredStatic.length) {
          return _StaticServiceItem(service: filteredStatic[index]);
        }
        return _DynamicServiceItem(
          category: categories[index - filteredStatic.length],
        );
      },
    );
  }
}

class _StaticService {
  final String title;
  final String image;
  final VoidCallback onTap;

  const _StaticService({
    required this.title,
    required this.image,
    required this.onTap,
  });
}

class _StaticServiceItem extends StatelessWidget {
  final _StaticService service;

  const _StaticServiceItem({required this.service});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: service.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(
                service.image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  service.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                    height: 1.25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DynamicServiceItem extends StatelessWidget {
  final ServiceCategory category;

  const _DynamicServiceItem({required this.category});

  @override
  Widget build(BuildContext context) {
    final imageUrl = FallbackImages.resolveUrl(category.imageUrl);
    final iconUrl = FallbackImages.resolveUrl(category.iconUrl);
    final fallbackIcon = FallbackImages.categoryIcon(category.slug);
    final isNetworkImage = imageUrl.isNotEmpty;
    final isIconImage = iconUrl.isNotEmpty;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryVendorsScreen(category: category),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: _buildServiceImage(
                imageUrl: imageUrl,
                iconUrl: iconUrl,
                fallbackIcon: fallbackIcon,
                isNetworkImage: isNetworkImage,
                isIconImage: isIconImage,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  category.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                    height: 1.25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceImage({
    required String imageUrl,
    required String iconUrl,
    required String fallbackIcon,
    required bool isNetworkImage,
    required bool isIconImage,
  }) {
    if (isNetworkImage) {
      return buildPlatformImage(
        url: imageUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        placeholder: _buildFallbackImage(iconUrl, fallbackIcon, isIconImage),
      );
    }
    if (isIconImage) {
      return buildPlatformImage(
        url: iconUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        placeholder: Image.asset(
          fallbackIcon,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }
    return Image.asset(fallbackIcon, width: double.infinity, fit: BoxFit.cover);
  }

  Widget _buildFallbackImage(
    String iconUrl,
    String fallbackIcon,
    bool isIconImage,
  ) {
    if (isIconImage) {
      return buildPlatformImage(
        url: iconUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        placeholder: Image.asset(
          fallbackIcon,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }
    return Image.asset(fallbackIcon, width: double.infinity, fit: BoxFit.cover);
  }
}
