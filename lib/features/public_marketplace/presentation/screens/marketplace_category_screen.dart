import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/public_marketplace/presentation/providers/public_marketplace_provider.dart';
import 'package:app/features/public_marketplace/presentation/screens/marketplace_vendor_details_screen.dart';
import 'package:app/features/public_marketplace/presentation/widgets/spare_parts_filter_sheet.dart';
import 'package:app/features/public_services/domain/entities/entities.dart';
import 'package:app/shared/ui/cards/provider_card.dart';
import 'package:app/shared/ui/inputs/custom_search_bar.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class MarketplaceCategoryScreen extends ConsumerStatefulWidget {
  final String productType;

  const MarketplaceCategoryScreen({super.key, required this.productType});

  @override
  ConsumerState<MarketplaceCategoryScreen> createState() =>
      _MarketplaceCategoryScreenState();
}

class _MarketplaceCategoryScreenState
    extends ConsumerState<MarketplaceCategoryScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300,
            child: _buildBackgroundImage(),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const Gap(AppSpacing.xl),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _buildTitle(),
                ),
                const Gap(AppSpacing.xl),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Gap(AppSpacing.md),
                      _buildDragHandle(),
                      const Gap(AppSpacing.lg),
                      _buildSearchBar(),
                      const Gap(AppSpacing.lg),
                      _buildFilterRow(),
                      if (widget.productType == 'spare_part')
                        _buildAppliedFiltersRow(),
                      const Gap(AppSpacing.md),
                      _buildVendorsList(),
                      const Gap(AppSpacing.xl),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Image.asset(
      widget.productType == 'accessory'
          ? 'assets/images/services_accessories.png'
          : 'assets/images/services_spare_parts.png',
      fit: BoxFit.cover,
      width: double.infinity,
      height: 300,
    );
    // CoverImageWidget(
    //   imageUrl: widget.category.coverImageUrl ?? widget.category.imageUrl,
    //   fallbackAsset: FallbackImages.categoryCover(widget.category.slug),
    //   height: 300,
    //   gradientOpacity: 0.3,
    // );
  }

  Widget _buildTitle() {
    final t = Translations.of(context).public_marketplace.category_screen;
    final title = widget.productType == 'accessory'
        ? t.title_accessories
        : t.title_spare_parts;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Pepsi',
            fontSize: 24,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            color: Colors.white,
            letterSpacing: 1.0,
          ),
        ),
        const Gap(AppSpacing.sm),
        Text(
          t.subtitle,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.white,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildDragHandle() {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    final t = Translations.of(context).public_marketplace.category_screen;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomSearchBar(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value.toLowerCase();
          });
        },
        hintText: t.search_hint,
        isBuyCar: false,
      ),
    );
  }

  Widget _buildFilterRow() {
    final theme = Theme.of(context);
    final t = Translations.of(context).public_marketplace.category_screen;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            t.all_supplies,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          if (widget.productType == 'spare_part')
            IconButton(
              icon: const Icon(Icons.tune, color: AppColors.primary),
              tooltip: Translations.of(context)
                  .public_marketplace
                  .spare_parts
                  .category_screen
                  .filter_button_tooltip,
              onPressed: () async {
                final current = ref.read(publicProductFilterProvider);
                final result = await SparePartsFilterSheet.show(
                  context,
                  initialFilter: current,
                );
                if (result != null) {
                  ref.read(publicProductFilterProvider.notifier).set(result);
                }
              },
            ),
        ],
      ),
    );
  }

  Widget _buildAppliedFiltersRow() {
    return Consumer(
      builder: (context, ref, _) {
        final filter = ref.watch(publicProductFilterProvider);
        if (filter.isEmpty) return const SizedBox.shrink();
        final notifier = ref.read(publicProductFilterProvider.notifier);
        final chips = Translations.of(context)
            .public_marketplace
            .spare_parts
            .category_screen;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (filter.make != null)
                _buildFilterChip(
                  chips.chip_make.replaceAll('{value}', filter.make!),
                  () => notifier.set(filter.copyWith(make: null)),
                ),
              if (filter.model != null)
                _buildFilterChip(
                  chips.chip_model.replaceAll('{value}', filter.model!),
                  () => notifier.set(filter.copyWith(model: null)),
                ),
              if (filter.yearFrom != null)
                _buildFilterChip(
                  chips.chip_year_from
                      .replaceAll('{value}', filter.yearFrom!.toString()),
                  () => notifier.set(filter.copyWith(yearFrom: null)),
                ),
              if (filter.yearTo != null)
                _buildFilterChip(
                  chips.chip_year_to
                      .replaceAll('{value}', filter.yearTo!.toString()),
                  () => notifier.set(filter.copyWith(yearTo: null)),
                ),
              if (filter.brand != null)
                _buildFilterChip(
                  chips.chip_brand.replaceAll('{value}', filter.brand!),
                  () => notifier.set(filter.copyWith(brand: null)),
                ),
              if (filter.minPrice != null)
                _buildFilterChip(
                  chips.chip_min_price
                      .replaceAll('{value}', filter.minPrice!.toString()),
                  () => notifier.set(filter.copyWith(minPrice: null)),
                ),
              if (filter.maxPrice != null)
                _buildFilterChip(
                  chips.chip_max_price
                      .replaceAll('{value}', filter.maxPrice!.toString()),
                  () => notifier.set(filter.copyWith(maxPrice: null)),
                ),
              _buildFilterChip(chips.chip_clear_all, () => notifier.clear(),
                  isClearAll: true),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(
    String label,
    VoidCallback onRemove, {
    bool isClearAll = false,
  }) {
    final theme = Theme.of(context);
    return InputChip(
      label: Text(label, style: GoogleFonts.poppins(fontSize: 12)),
      onDeleted: isClearAll ? null : onRemove,
      onPressed: isClearAll ? onRemove : null,
      deleteIconColor: AppColors.primary,
      backgroundColor: theme.colorScheme.primaryContainer,
    );
  }

  // Widget _buildFilterButton(String text, IconData icon) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //     decoration: BoxDecoration(
  //       color: const Color(0xFF282A31),
  //       borderRadius: BorderRadius.circular(6),
  //       boxShadow: [
  //         BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4),
  //       ],
  //     ),
  //     child: Row(
  //       children: [
  //         Text(
  //           text,
  //           style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
  //         ),
  //         const Gap(AppSpacing.xs),
  //         Icon(icon, color: Colors.white, size: 14),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildVendorsList() {
    final t = Translations.of(context).public_marketplace.category_screen;
    final vendorsAsync = ref.watch(
      marketplaceVendorsProvider(widget.productType),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: vendorsAsync.when(
        data: (vendors) {
          final filtered = vendors.where((v) {
            if (_searchQuery.isEmpty) return true;
            return v.businessName.toLowerCase().contains(_searchQuery);
          }).toList();

          if (filtered.isEmpty) {
            return Center(
              child: Text(
                _searchQuery.isNotEmpty
                    ? t.no_vendors_match_search
                    : t.no_vendors_found,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            );
          }
          return Column(
            children: filtered
                .map((vendor) => _buildVendorCard(vendor))
                .toList(),
          );
        },
        loading: () => ShimmerSkeletons.cardSkeleton(),
        error: (error, _) => Center(
          child: Text(
            '${t.error_loading} $error',
            style: GoogleFonts.poppins(color: Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildVendorCard(PublicVendor vendor) {
    final t = Translations.of(context).public_marketplace.category_screen;
    final label = widget.productType == 'accessory'
        ? t.label_accessories
        : t.label_spare_parts;
    return ProviderCard(
      title: vendor.businessName,
      subtitle: '${vendor.totalServices} $label available',
      rating: vendor.rating ?? '0.0',
      logoAsset: vendor.logoUrl ?? '',
      isSvgLogo: false,
      isNetworkImage: vendor.logoUrl != null && vendor.logoUrl!.isNotEmpty,
      badgeText: vendor.isVerified ? t.verified : null,
      onTap: () {
        _navigateToMarketplaceServices(context, vendor);
      },
    );
  }

  void _navigateToMarketplaceServices(
    BuildContext context,
    PublicVendor vendor,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MarketplaceVendorDetailsScreen(vendor: vendor),
      ),
    );
  }
}
