import 'package:app/features/buy_a_car/presentation/providers/car_listings_notifier.dart';
import 'package:app/features/buy_a_car/presentation/providers/car_listings_state.dart';
import 'package:app/features/buy_a_car/presentation/providers/car_filter_state.dart';
import 'package:app/features/buy_a_car/presentation/screens/buy_car_details_screen.dart';
import 'package:app/features/buy_a_car/presentation/widgets/all_car_listing_card.dart';
import 'package:app/features/buy_a_car/presentation/widgets/filter_row.dart';
import 'package:app/features/home/presentation/widgets/ad_banners.dart';
import 'package:app/features/home/presentation/widgets/premium_banner.dart';
import 'package:app/features/sell_your_car/domain/entities/entities.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/inputs/custom_search_bar.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:app/core/theme/spacing.dart';

class GoodConditionCarsScreen extends ConsumerStatefulWidget {
  const GoodConditionCarsScreen({super.key});

  @override
  ConsumerState<GoodConditionCarsScreen> createState() =>
      _GoodConditionCarsScreenState();
}

class _GoodConditionCarsScreenState
    extends ConsumerState<GoodConditionCarsScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;
  static const String _conditionFilter = 'GOOD';
  String _searchQuery = '';
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    debugPrint('GoodConditionCarsScreen: initState called');
    Future.microtask(() {
      debugPrint('GoodConditionCarsScreen: calling fetchListings');
      _fetchListings();
    });
    _scrollController.addListener(_onScroll);
    _searchController.addListener(() {
      setState(() {
        _showClearButton = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _fetchListings() {
    final filterState = ref.read(carFilterStateProvider);
    ref
        .read(carListingsNotifierProvider.notifier)
        .fetchListings(
          conditionStatus: _conditionFilter,
          search: _searchQuery.isEmpty ? null : _searchQuery,
          make: filterState.make,
          model: filterState.model,
          trim: filterState.trim,
          yearFrom: filterState.yearFrom,
          yearTo: filterState.yearTo,
          mileageFrom: filterState.mileageFrom,
          mileageTo: filterState.mileageTo,
          transmission: filterState.transmission,
        );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final filterState = ref.read(carFilterStateProvider);
      ref
          .read(carListingsNotifierProvider.notifier)
          .fetchNextPage(
            conditionStatus: _conditionFilter,
            search: _searchQuery.isEmpty ? null : _searchQuery,
            make: filterState.make,
            model: filterState.model,
            trim: filterState.trim,
            yearFrom: filterState.yearFrom,
            yearTo: filterState.yearTo,
            mileageFrom: filterState.mileageFrom,
            mileageTo: filterState.mileageTo,
            transmission: filterState.transmission,
          );
    }
  }

  void _onSearchChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _searchQuery = value.trim();
      _fetchListings();
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _searchQuery = '';
    _fetchListings();
  }

  Future<void> _onRefresh() async {
    final filterState = ref.read(carFilterStateProvider);
    await ref
        .read(carListingsNotifierProvider.notifier)
        .refresh(
          conditionStatus: _conditionFilter,
          search: _searchQuery.isEmpty ? null : _searchQuery,
          make: filterState.make,
          model: filterState.model,
          trim: filterState.trim,
          yearFrom: filterState.yearFrom,
          yearTo: filterState.yearTo,
          mileageFrom: filterState.mileageFrom,
          mileageTo: filterState.mileageTo,
          transmission: filterState.transmission,
        );
  }

  @override
  Widget build(BuildContext context) {
    final listingsState = ref.watch(carListingsNotifierProvider);
    debugPrint('GoodConditionCarsScreen: state = $listingsState');
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          Gap(AppSpacing.xl),
                          Text(
                            t.buy_a_car.good_condition_screen.title,
                            style: GoogleFonts.poppins(
                              color: theme.colorScheme.onSurface,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Gap(AppSpacing.xl),
                      PremiumBanner(),
                      Gap(AppSpacing.lg),
                      AdBanners(),
                      Gap(AppSpacing.lg),
                      CustomSearchBar(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        hintText: t.buy_a_car.good_condition_screen.search_hint,
                        isBuyCar: true,
                        showClearButton: _showClearButton,
                        onTapClearIcon: _clearSearch,
                      ),
                      Gap(AppSpacing.lg),
                      FilterRow(onFiltersChanged: _fetchListings),
                      Gap(AppSpacing.lg),
                      Text(
                        t.buy_a_car.good_condition_screen.all_cars,
                        style: GoogleFonts.poppins(
                          color: theme.colorScheme.onSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(AppSpacing.lg),
                    ],
                  ),
                ),
              ),
              _buildListingsList(listingsState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListingsList(AsyncValue<CarListingsState> state) {
    return state.when(
      data: (data) {
        if (data is CarListingsLoaded) {
          if (data.listings.isEmpty) {
            return SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Icon(
                        Icons.directions_car_outlined,
                        size: 64,
                        color: Colors.grey[600],
                      ),
                      Gap(AppSpacing.md),
                      Text(
                        _searchQuery.isNotEmpty
                            ? t.buy_a_car.good_condition_screen.no_cars_found
                            : t
                                  .buy_a_car
                                  .good_condition_screen
                                  .no_cars_available,
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index < data.listings.length) {
                final listing = data.listings[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [_buildCarCard(listing), Gap(AppSpacing.lg)],
                  ),
                );
              }
              return null;
            }, childCount: data.listings.length),
          );
        }
        if (data is CarListingsError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
                    Gap(AppSpacing.md),
                    Text(
                      data.message,
                      style: GoogleFonts.poppins(
                        color: Colors.red[400],
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(AppSpacing.md),
                    ElevatedButton(
                      onPressed: () => _fetchListings(),
                      child: Text(t.buy_a_car.good_condition_screen.retry),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return SliverToBoxAdapter(child: SizedBox.shrink());
      },
      loading: () => SliverToBoxAdapter(child: ShimmerSkeletons.cardSkeleton()),
      error: (error, stack) => SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
                Gap(AppSpacing.md),
                Text(
                  t.buy_a_car.good_condition_screen.failed_to_load,
                  style: GoogleFonts.poppins(
                    color: Colors.red[400],
                    fontSize: 16,
                  ),
                ),
                Gap(AppSpacing.sm),
                Text(
                  error.toString(),
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(AppSpacing.md),
                ElevatedButton(
                  onPressed: () => _fetchListings(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFDC8735),
                  ),
                  child: Text(
                    t.buy_a_car.good_condition_screen.retry,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCarCard(CarListing listing) {
    final priceStr = listing.askingPrice != null
        ? 'KD ${listing.askingPrice!.toInt()}'
        : 'Price on request';

    final kmStr = '${_formatNumber(listing.mileage)} km';

    return AllCarListingCard(
      image: listing.images.isNotEmpty ? listing.images.first : '',
      title: '${listing.make} ${listing.model}',
      year: listing.year.toString(),
      km: kmStr,
      price: priceStr,
      isGood:
          listing.conditionStatus == VehicleCondition.good ||
          listing.conditionStatus == VehicleCondition.excellent,
      isInspected: listing.inspectionReportUrl != null,
      isFeatured: listing.isFeatured,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BuyCarDetailsScreen(
              listingId: listing.id,
              isGood:
                  listing.conditionStatus == VehicleCondition.good ||
                  listing.conditionStatus == VehicleCondition.excellent,
              isInspected: listing.inspectionReportUrl != null,
            ),
          ),
        );
      },
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(0)}k';
    }
    return number.toString();
  }
}
