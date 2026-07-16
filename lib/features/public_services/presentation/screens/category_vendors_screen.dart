import 'package:app/core/utils/fallback_images.dart';
import 'package:app/features/public_services/domain/entities/entities.dart';
import 'package:app/features/public_services/presentation/screens/vendor_services_screen.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/cards/provider_card.dart';
import 'package:app/shared/ui/images/cover_image_widget.dart';
import 'package:app/shared/ui/inputs/custom_search_bar.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/features/public_services/presentation/providers/public_services_provider.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class CategoryVendorsScreen extends ConsumerStatefulWidget {
  final ServiceCategory category;

  const CategoryVendorsScreen({super.key, required this.category});

  @override
  ConsumerState<CategoryVendorsScreen> createState() =>
      _CategoryVendorsScreenState();
}

class _CategoryVendorsScreenState extends ConsumerState<CategoryVendorsScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vendorsAsync = ref.watch(
      vendorsByCategoryProvider(widget.category.id),
    );
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
                      const Gap(AppSpacing.md),
                      _buildVendorsList(vendorsAsync),
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
    return CoverImageWidget(
      imageUrl: widget.category.coverImageUrl ?? widget.category.imageUrl,
      fallbackAsset: FallbackImages.categoryCover(widget.category.slug),
      height: 300,
      gradientOpacity: 0.3,
    );
  }

  Widget _buildTitle() {
    final t = Translations.of(
      context,
    ).public_services.category_vendors.description;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.category.name.toUpperCase(),
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
          widget.category.description ?? t,
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
    final t = Translations.of(context).public_services.category_vendors.search;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomSearchBar(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value.toLowerCase();
          });
        },
        hintText: t,
        isBuyCar: false,
      ),
    );
  }

  Widget _buildFilterRow() {
    final theme = Theme.of(context);
    final t = Translations.of(
      context,
    ).public_services.category_vendors.all_vendors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            t,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          // Row(
          //   children: [
          //     _buildFilterButton('Sort', Icons.swap_vert),
          //     const Gap(AppSpacing.sm),
          //     _buildFilterButton('Filter', Icons.filter_alt_outlined),
          //   ],
          // ),
        ],
      ),
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

  Widget _buildVendorsList(AsyncValue<List<PublicVendor>> vendorsAsync) {
    final theme = Theme.of(context);
    final t = Translations.of(context).public_services.category_vendors;
    return vendorsAsync.when(
      loading: () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            for (int i = 0; i < 4; i++) ...[
              ShimmerSkeletons.listItemSkeleton(
                height: 80,
                showLeadingCircle: true,
              ),
              const Gap(AppSpacing.md),
            ],
          ],
        ),
      ),
      error: (error, _) => Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Text(
            t.error_vendor,
            style: GoogleFonts.poppins(color: Colors.red),
          ),
        ),
      ),
      data: (vendors) {
        final filteredVendors = vendors.where((v) {
          if (_searchQuery.isEmpty) return true;
          return v.businessName.toLowerCase().contains(_searchQuery);
        }).toList();

        if (filteredVendors.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Text(
                t.null_vendor,
                style: GoogleFonts.poppins(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              for (int i = 0; i < filteredVendors.length; i++) ...[
                ProviderCard(
                  title: filteredVendors[i].businessName,
                  subtitle:
                      '${filteredVendors[i].totalServices} ${t.vendor_card.sub_title}',
                  rating: filteredVendors[i].rating ?? '0.0',
                  logoAsset: FallbackImages.vendorImage(
                    filteredVendors[i].logoUrl,
                  ),
                  isSvgLogo: false,
                  isNetworkImage:
                      filteredVendors[i].logoUrl != null &&
                      filteredVendors[i].logoUrl!.isNotEmpty,
                  badgeText: filteredVendors[i].isVerified
                      ? t.vendor_card.badge_title
                      : null,
                  onTap: () =>
                      _navigateToVendorServices(context, filteredVendors[i]),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _navigateToVendorServices(BuildContext context, PublicVendor vendor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            VendorServicesScreen(vendor: vendor, category: widget.category),
      ),
    );
  }
}
