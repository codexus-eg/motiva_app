import 'package:app/features/buy_a_car/presentation/providers/car_listings_state.dart';
import 'package:app/features/sell_your_car/domain/repositories/car_marketplace_repository.dart';
import 'package:app/features/sell_your_car/data/datasources/datasources.dart';
import 'package:app/features/sell_your_car/data/repositories/repositories.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final carMarketplaceRemoteDataSourceProvider =
    Provider<CarMarketplaceRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return CarMarketplaceRemoteDataSourceImpl(dioClient);
    });

final carMarketplaceRepositoryProvider = Provider<CarMarketplaceRepository>((
  ref,
) {
  final remoteDataSource = ref.watch(carMarketplaceRemoteDataSourceProvider);
  return CarMarketplaceRepositoryImpl(remoteDataSource);
});

class CarListingsNotifier extends AsyncNotifier<CarListingsState> {
  static const int _pageSize = 20;

  @override
  CarListingsState build() {
    return const CarListingsInitial();
  }

  Future<void> fetchListings({
    String? conditionStatus,
    String? listingStatus,
    String? search,
    String? make,
    String? model,
    String? trim,
    int? yearFrom,
    int? yearTo,
    int? mileageFrom,
    int? mileageTo,
    String? transmission,
  }) async {
    debugPrint(
      'CarListingsNotifier: fetchListings called with conditionStatus: $conditionStatus, listingStatus: $listingStatus, search: $search',
    );
    state = const AsyncLoading();
    try {
      final repository = ref.read(carMarketplaceRepositoryProvider);
      debugPrint('CarListingsNotifier: calling repository.getListings...');
      final listings = await repository.getListings(
        page: 1,
        limit: _pageSize,
        conditionStatus: conditionStatus,
        listingStatus: listingStatus,
        search: search,
        make: make,
        model: model,
        trim: trim,
        yearFrom: yearFrom,
        yearTo: yearTo,
        mileageFrom: mileageFrom,
        mileageTo: mileageTo,
        transmission: transmission,
      );
      debugPrint('CarListingsNotifier: got ${listings.length} listings');

      state = AsyncData(
        CarListingsLoaded(
          listings: listings,
          hasReachedMax: listings.length < _pageSize,
          currentPage: 1,
        ),
      );
    } catch (e, stack) {
      debugPrint('CarListingsNotifier: error: $e');
      state = AsyncError(e, stack);
    }
  }

  Future<void> fetchNextPage({
    String? conditionStatus,
    String? listingStatus,
    String? search,
    String? make,
    String? model,
    String? trim,
    int? yearFrom,
    int? yearTo,
    int? mileageFrom,
    int? mileageTo,
    String? transmission,
  }) async {
    final currentState = state.value;
    if (currentState == null || currentState is! CarListingsLoaded) {
      return fetchListings(
        conditionStatus: conditionStatus,
        listingStatus: listingStatus,
        search: search,
        make: make,
        model: model,
        trim: trim,
        yearFrom: yearFrom,
        yearTo: yearTo,
        mileageFrom: mileageFrom,
        mileageTo: mileageTo,
        transmission: transmission,
      );
    }

    if (currentState.hasReachedMax) return;

    final nextPage = currentState.currentPage + 1;
    try {
      final repository = ref.read(carMarketplaceRepositoryProvider);
      final newListings = await repository.getListings(
        page: nextPage,
        limit: _pageSize,
        conditionStatus: conditionStatus,
        listingStatus: listingStatus,
        search: search,
        make: make,
        model: model,
        trim: trim,
        yearFrom: yearFrom,
        yearTo: yearTo,
        mileageFrom: mileageFrom,
        mileageTo: mileageTo,
        transmission: transmission,
      );

      final hasReachedMax = newListings.length < _pageSize;
      final allListings = [...currentState.listings, ...newListings];

      state = AsyncData(
        currentState.copyWith(
          listings: allListings,
          hasReachedMax: hasReachedMax,
          currentPage: nextPage,
        ),
      );
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> refresh({
    String? conditionStatus,
    String? listingStatus,
    String? search,
    String? make,
    String? model,
    String? trim,
    int? yearFrom,
    int? yearTo,
    int? mileageFrom,
    int? mileageTo,
    String? transmission,
  }) async {
    state = const AsyncLoading();
    await fetchListings(
      conditionStatus: conditionStatus,
      listingStatus: listingStatus,
      search: search,
      make: make,
      model: model,
      trim: trim,
      yearFrom: yearFrom,
      yearTo: yearTo,
      mileageFrom: mileageFrom,
      mileageTo: mileageTo,
      transmission: transmission,
    );
  }
}

final carListingsNotifierProvider =
    AsyncNotifierProvider<CarListingsNotifier, CarListingsState>(
      CarListingsNotifier.new,
    );

class CarDetailNotifier extends StateNotifier<CarDetailState> {
  final CarMarketplaceRepository _repository;

  CarDetailNotifier(this._repository) : super(const CarDetailState());

  Future<void> fetchListing(String id) async {
    debugPrint('CarDetailNotifier: fetchListing called with id: $id');
    state = state.copyWith(isLoading: true, error: null);
    try {
      debugPrint('CarDetailNotifier: calling repository.getListing...');
      final listing = await _repository.getListing(id);
      debugPrint(
        'CarDetailNotifier: got listing: ${listing.make} ${listing.model}',
      );
      state = state.copyWith(listing: listing, isLoading: false);
    } catch (e, stackTrace) {
      debugPrint('CarDetailNotifier: error: $e');
      debugPrint('CarDetailNotifier: stackTrace: $stackTrace');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() {
    state = const CarDetailState();
  }
}

final carDetailNotifierProvider =
    StateNotifierProvider<CarDetailNotifier, CarDetailState>((ref) {
      final repository = ref.read(carMarketplaceRepositoryProvider);
      return CarDetailNotifier(repository);
    });
