import 'package:app/features/sell_your_car/domain/entities/entities.dart';
import 'package:app/features/user_dashboard/presentation/providers/my_listings_provider.dart';
import 'package:app/features/user_dashboard/presentation/screens/listing_details_screen.dart';
import 'package:app/features/user_dashboard/presentation/widgets/listing_screen/car_listing_card.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:google_fonts/google_fonts.dart';

class ListingsScreen extends ConsumerStatefulWidget {
  const ListingsScreen({super.key});

  @override
  ConsumerState<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends ConsumerState<ListingsScreen> {
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
    final myListingsAsync = ref.watch(myListingsProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(AppSpacing.lg),
                    _headerSection(context),
                    Gap(AppSpacing.lg),
                  ],
                ),
              ),
            ),

            /// Listings
            myListingsAsync.when(
              data: (listings) {
                final filteredListings = listings.where((listing) {
                  if (_searchQuery.isEmpty) return true;
                  final query = _searchQuery.toLowerCase();
                  return listing.make.toLowerCase().contains(query) ||
                      listing.model.toLowerCase().contains(query);
                }).toList();

                return _buildListingsList(context, filteredListings);
              },
              loading: () =>
                  SliverToBoxAdapter(child: ShimmerSkeletons.cardSkeleton()),
              error: (error, stack) => SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red,
                      ),
                      const Gap(AppSpacing.md),
                      Text(
                        Translations.of(
                          context,
                        ).user_dashboard.listings.error.failed_to_load,
                        style: TextStyle(color: theme.colorScheme.onSurface),
                      ),
                      const Gap(AppSpacing.sm),
                      ElevatedButton(
                        onPressed: () => ref.refresh(myListingsProvider),
                        child: Text(
                          Translations.of(
                            context,
                          ).user_dashboard.listings.error.retry,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListingsList(BuildContext context, List<CarListing> listings) {
    if (listings.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _searchQuery.isNotEmpty
                    ? Icons.search_off
                    : Icons.car_rental_outlined,
                size: 64,
                color: Colors.grey[400],
              ),
              const Gap(AppSpacing.md),
              Text(
                _searchQuery.isNotEmpty
                    ? Translations.of(
                        context,
                      ).user_dashboard.listings.empty.no_results
                    : Translations.of(
                        context,
                      ).user_dashboard.listings.empty.no_listings_yet,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const Gap(AppSpacing.sm),
              Text(
                _searchQuery.isNotEmpty
                    ? '${Translations.of(context).user_dashboard.listings.empty.no_match} "$_searchQuery"'
                    : Translations.of(
                        context,
                      ).user_dashboard.listings.empty.appear_here,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final listing = listings[index];
          return Column(
            children: [
              CarListingCard(
                image: listing.images.isNotEmpty
                    ? listing.images.first
                    : 'assets/images/user_listing/default_car.png',
                title: '${listing.make} ${listing.model}',
                year: listing.year.toString(),
                km: '${listing.mileage.toString()} km',
                price: listing.askingPrice != null
                    ? 'KD ${listing.askingPrice!.toStringAsFixed(0)}'
                    : Translations.of(
                        context,
                      ).user_dashboard.listing_details.price_on_request,
                isInspected: listing.inspectionReportUrl != null,
                isFeatured: listing.isFeatured,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ListingDetailsScreen(listingId: listing.id),
                    ),
                  );
                },
              ),
              if (index < listings.length - 1) const Gap(AppSpacing.lg),
              if (index == listings.length - 1) const Gap(AppSpacing.xl),
            ],
          );
        }, childCount: listings.length),
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back_ios, color: Colors.orange, size: 20),
            ),
            Gap(AppSpacing.md),
            Text(
              Translations.of(context).user_dashboard.listings.screen_title,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
        Gap(AppSpacing.lg),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.grey),
              const Gap(AppSpacing.md),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: Translations.of(
                      context,
                    ).user_dashboard.listings.search_hint,
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                ),
              ),
              if (_searchController.text.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                  child: const Icon(Icons.clear, color: Colors.grey, size: 18),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
