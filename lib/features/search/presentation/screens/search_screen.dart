import 'package:app/core/theme/spacing.dart';
import 'package:app/core/utils/fallback_images.dart';
import 'package:app/features/buy_a_car/presentation/screens/buy_car_details_screen.dart';
import 'package:app/features/public_marketplace/presentation/screens/marketplace_vendor_details_screen.dart';
import 'package:app/features/public_services/domain/entities/entities.dart';
import 'package:app/features/public_services/presentation/screens/vendor_service_detail_screen.dart';
import 'package:app/features/search/domain/entities/search_result.dart';
import 'package:app/features/search/presentation/providers/search_provider.dart';
import 'package:app/features/sell_your_car/domain/entities/entities.dart';
import 'package:app/shared/ui/images/network_image_widget.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final searchAsync = ref.watch(searchNotifierProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: theme.colorScheme.onSurface,
                      size: 20,
                    ),
                  ),
                  const Gap(AppSpacing.md),
                  Expanded(
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(64),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: const Color(0xFF757575),
                            size: 20,
                          ),
                          const Gap(AppSpacing.md),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              autofocus: true,
                              onChanged: (value) {
                                ref
                                    .read(searchNotifierProvider.notifier)
                                    .search(value);
                              },
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: theme.colorScheme.onSurface,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: const Color(0xFF757575),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          if (_searchController.text.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                ref
                                    .read(searchNotifierProvider.notifier)
                                    .clear();
                                setState(() {});
                              },
                              child: Icon(
                                Icons.clear,
                                color: const Color(0xFF757575),
                                size: 20,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: searchAsync.when(
                loading: () => _buildLoading(),
                error: (e, _) => _buildError(e),
                data: (results) => _buildResults(context, results),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          for (int i = 0; i < 6; i++) ...[
            ShimmerSkeletons.listItemSkeleton(height: 80, showLeadingCircle: false),
            const Gap(AppSpacing.md),
          ],
        ],
      ),
    );
  }

  Widget _buildError(Object? error) {
    return Center(
      child: Text(
        'Something went wrong',
        style: GoogleFonts.poppins(color: Colors.red),
      ),
    );
  }

  Widget _buildResults(BuildContext context, List<SearchResult> results) {
    if (results.isEmpty) {
      return Center(
        child: Text(
          _searchController.text.isEmpty
              ? 'Start typing to search'
              : 'No results found',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: _buildResultCard(context, result),
        );
      },
    );
  }

  Widget _buildResultCard(BuildContext context, SearchResult result) {

    if (result is VendorSearchResult) {
      final v = result.vendor;
      return _buildCard(
        context: context,
        imageUrl: v.logoUrl,
        fallbackAsset: FallbackImages.vendorLogo,
        title: v.businessName,
        subtitle: 'Vendor',
        badge: v.isVerified ? 'Verified' : null,
        onTap: () => _navigateToVendor(context, v),
      );
    }

    if (result is ServiceSearchResult) {
      final s = result.service;
      return _buildCard(
        context: context,
        imageUrl: s.imageUrl,
        fallbackAsset: FallbackImages.serviceDefault,
        title: s.name,
        subtitle: 'Service • ${s.vendorBusinessName}',
        trailing: s.basePrice != null ? 'KD ${s.basePrice}' : null,
        onTap: () => _navigateToService(context, s),
      );
    }

    if (result is ProductSearchResult) {
      final p = result.product;
      return _buildCard(
        context: context,
        imageUrl: p.images.isNotEmpty ? p.images.first : null,
        fallbackAsset: FallbackImages.serviceAccessories,
        title: p.name,
        subtitle: 'Product',
        trailing: 'KD ${p.price}',
        onTap: () => _navigateToProduct(context, p),
      );
    }

    if (result is CarListingSearchResult) {
      final c = result.listing;
      return _buildCard(
        context: context,
        imageUrl: c.images.isNotEmpty ? c.images.first : null,
        fallbackAsset: FallbackImages.categoryCoverDefault,
        title: c.title ?? '${c.year} ${c.make} ${c.model}',
        subtitle: 'Car Listing',
        trailing: c.askingPrice != null ? 'KD ${c.askingPrice}' : null,
        onTap: () => _navigateToCar(context, c),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildCard({
    required BuildContext context,
    required String? imageUrl,
    required String fallbackAsset,
    required String title,
    required String subtitle,
    String? badge,
    String? trailing,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 96,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            SizedBox(
              width: 80,
              height: double.infinity,
              child: NetworkImageWidget(
                imageUrl: imageUrl,
                fallbackAsset: fallbackAsset,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(AppSpacing.xs),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            subtitle,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (trailing != null)
                          Text(
                            trailing,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFF8BA7F),
                            ),
                          ),
                      ],
                    ),
                    if (badge != null) ...[
                      const Gap(AppSpacing.xs),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDC8735).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          badge,
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFDC8735),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToVendor(BuildContext context, PublicVendor vendor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MarketplaceVendorDetailsScreen(vendor: vendor),
      ),
    );
  }

  void _navigateToService(BuildContext context, PublicVendorService service) {
    // Fetch vendor for detail screen. Build a light vendor stub from service fields.
    final vendor = PublicVendor(
      id: service.vendorId,
      businessName: service.vendorBusinessName,
      logoUrl: service.vendorLogoUrl,
      coverImageUrl: service.vendorCoverImageUrl,
      rating: service.vendorRating,
      totalReviews: service.vendorTotalReviews,
      totalServices: 0,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VendorServiceDetailScreen(
          service: service,
          vendor: vendor,
        ),
      ),
    );
  }

  void _navigateToProduct(BuildContext context, dynamic product) {
    // No dedicated product detail screen visible; open marketplace vendor for now.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MarketplaceVendorDetailsScreen(
          vendor: PublicVendor(
            id: product.vendorId,
            businessName: 'Product Vendor',
            totalReviews: 0,
            totalServices: 0,
          ),
        ),
      ),
    );
  }

  void _navigateToCar(BuildContext context, CarListing listing) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BuyCarDetailsScreen(listingId: listing.id),
      ),
    );
  }
}
