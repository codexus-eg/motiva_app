import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/utils/fallback_images.dart';
import 'package:app/features/public_marketplace/presentation/providers/public_marketplace_provider.dart';
import 'package:app/features/public_marketplace/presentation/screens/marketplace_details_screen.dart';
import 'package:app/features/public_services/domain/entities/entities.dart';
import 'package:app/features/vendor-products/domain/entities/vendor_product.dart';
import 'package:app/shared/ui/inputs/custom_search_bar.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/shared/ui/images/network_image_widget.dart';
import 'package:app/i18n/strings.g.dart';

class MarketplaceVendorDetailsScreen extends ConsumerStatefulWidget {
  final PublicVendor vendor;

  const MarketplaceVendorDetailsScreen({super.key, required this.vendor});

  @override
  ConsumerState<MarketplaceVendorDetailsScreen> createState() =>
      _MarketplaceVendorDetailsScreenState();
}

class _MarketplaceVendorDetailsScreenState
    extends ConsumerState<MarketplaceVendorDetailsScreen> {
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
    final productsAsync = ref.watch(
      vendorProductsProvider(widget.vendor.userId ?? widget.vendor.id),
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 350,
            child: _buildBackgroundImage(),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(AppSpacing.xl),
                Padding(
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
                const Gap(AppSpacing.lg),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _buildMarketplaceHeader(),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(AppSpacing.md),
                      _buildDragHandle(),
                      const Gap(AppSpacing.lg),
                      productsAsync.when(
                        data: (products) =>
                            _buildPopularServices(context, products),
                        loading: () => ShimmerSkeletons.cardSkeleton(),
                        error: (_, _) => const SizedBox.shrink(),
                      ),
                      const Gap(AppSpacing.lg),
                      _buildSearchBar(),
                      const Gap(AppSpacing.lg),
                      productsAsync.when(
                        data: (products) => _buildAllServices(products),
                        loading: () => ShimmerSkeletons.cardSkeleton(),
                        error: (error, _) => Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              Translations.of(
                                context,
                              ).public_services.vendor_services.error_service,
                              style: GoogleFonts.poppins(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      ),
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
    final coverUrl = widget.vendor.coverImageUrl;
    if (coverUrl != null && coverUrl.startsWith('assets/')) {
      return Image.asset(
        coverUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 350,
      );
    }
    return NetworkImageWidget(
      imageUrl: coverUrl,
      fallbackAsset: FallbackImages.serviceAccessories,
      width: double.infinity,
      height: 350,
      fit: BoxFit.cover,
    );
  }

  Widget _buildMarketplaceHeader() {
    final vendor = widget.vendor;
    final ratingValue = double.tryParse(vendor.rating ?? '0.0') ?? 0.0;
    final t = Translations.of(context).public_marketplace.vendor_details_screen;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: _buildLogoImage(vendor.logoUrl),
        ),
        const Gap(AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                vendor.businessName,
                style: const TextStyle(
                  fontFamily: 'Pepsi',
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  letterSpacing: 1.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Text(
                  vendor.rating ?? '0.0',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Gap(AppSpacing.xs),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      size: 12,
                      color: index < ratingValue.round()
                          ? const Color(0xFFFFC107)
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Gap(AppSpacing.xs),
        Text(
          '${vendor.totalServices} ${t.services} • ${vendor.totalReviews} ${t.reviews_label}',
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildLogoImage(String? logoUrl) {
    if (logoUrl != null && logoUrl.startsWith('assets/')) {
      return Image.asset(logoUrl, fit: BoxFit.contain);
    }
    return NetworkImageWidget(
      imageUrl: logoUrl,
      fallbackAsset: FallbackImages.serviceAccessories,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.contain,
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

  Widget _buildPopularServices(
    BuildContext context,
    List<VendorProduct> products,
  ) {
    final theme = Theme.of(context);
    final t = Translations.of(context).public_marketplace.vendor_details_screen;
    if (products.isEmpty) return const SizedBox.shrink();

    final popular = products.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            t.most_popular,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
        const Gap(AppSpacing.md),
        SizedBox(
          height: 175,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            scrollDirection: Axis.horizontal,
            itemCount: popular.length,
            separatorBuilder: (_, _) => const Gap(AppSpacing.md),
            itemBuilder: (context, index) {
              final product = popular[index];
              return GestureDetector(
                onTap: () => _navigateToServiceDetail(context, product.id),
                child: SizedBox(
                  width: 142,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        width: 142,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: theme.colorScheme.primaryContainer,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: _buildProductImage(product.images),
                      ),
                      const Gap(AppSpacing.sm),
                      Text(
                        product.name,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductImage(List<String> images) {
    if (images.isNotEmpty && images.first.startsWith('assets/')) {
      return Image.asset(images.first, fit: BoxFit.cover);
    }
    return NetworkImageWidget(
      imageUrl: images.isNotEmpty ? images.first : null,
      fallbackAsset: FallbackImages.serviceAccessories,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget _buildSearchBar() {
    final t = Translations.of(context).public_marketplace.vendor_details_screen;
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

  Widget _buildAllServices(List<VendorProduct> products) {
    final theme = Theme.of(context);
    final t = Translations.of(context).public_marketplace.vendor_details_screen;

    final filtered = products.where((p) {
      return p.name.toLowerCase().contains(_searchQuery);
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.all_services,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Text(
                      t.reviews,
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Gap(AppSpacing.xs),
                    Icon(
                      Icons.chat_bubble_outline,
                      color: theme.colorScheme.onSurface,
                      size: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Gap(AppSpacing.md),
        if (filtered.isEmpty)
          Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Text(
                t.no_services_found,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withAlpha(153),
                ),
              ),
            ),
          )
        else
          ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: filtered.length,
            separatorBuilder: (_, _) => const Gap(AppSpacing.md),
            itemBuilder: (context, index) {
              final product = filtered[index];
              return GestureDetector(
                onTap: () => _navigateToServiceDetail(context, product.id),
                child: _buildServiceCard(product),
              );
            },
          ),
      ],
    );
  }

  Widget _buildServiceCard(VendorProduct product) {
    final theme = Theme.of(context);
    final t = Translations.of(context).public_marketplace.vendor_details_screen;
    return Container(
      height: 161,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 12, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface,
                      height: 1.4,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(AppSpacing.xs),
                  Text(
                    product.description ?? t.professional_service,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      color: theme.colorScheme.onPrimaryContainer,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: const Color(0xFFF8BA7F)),
                        ),
                        child: Text(
                          '${product.currency} ${_formatPrice(product.price)}',
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFF8BA7F),
                          ),
                        ),
                      ),
                      const Gap(AppSpacing.md),
                    ],
                  ),
                  if (product.productType == 'spare_part' &&
                      (product.brand != null || product.partNumber != null)) ...[
                    Text(
                      '${product.brand ?? ''}${product.brand != null && product.partNumber != null ? ' · ' : ''}${product.partNumber ?? ''}',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const Gap(AppSpacing.md),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFDC8735), Color(0xFFDC8735)],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/shopping_bag.svg',
                          height: 11,
                          width: 11,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        const Gap(AppSpacing.xs),
                        Text(
                          t.add_to_cart,
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 160,
            height: double.infinity,
            child: _buildProductImage(product.images),
          ),
        ],
      ),
    );
  }

  void _navigateToServiceDetail(BuildContext context, String productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MarketplaceDetailScreen(productId: productId),
      ),
    );
  }

  String _formatPrice(String price) {
    final value = double.tryParse(price);
    if (value == null) return price;
    final intValue = value.toInt();
    if (value == intValue) return intValue.toString();
    return value.toString();
  }
}
