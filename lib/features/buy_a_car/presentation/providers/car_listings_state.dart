import 'package:app/features/sell_your_car/domain/entities/entities.dart';

sealed class CarListingsState {
  const CarListingsState();
}

class CarListingsInitial extends CarListingsState {
  const CarListingsInitial();
}

class CarListingsLoading extends CarListingsState {
  const CarListingsLoading();
}

class CarListingsLoaded extends CarListingsState {
  final List<CarListing> listings;
  final bool hasReachedMax;
  final int currentPage;

  const CarListingsLoaded({
    required this.listings,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });

  CarListingsLoaded copyWith({
    List<CarListing>? listings,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return CarListingsLoaded(
      listings: listings ?? this.listings,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class CarListingsError extends CarListingsState {
  final String message;
  const CarListingsError(this.message);
}

class CarDetailState {
  final CarListing? listing;
  final bool isLoading;
  final String? error;

  const CarDetailState({this.listing, this.isLoading = false, this.error});

  CarDetailState copyWith({
    CarListing? listing,
    bool? isLoading,
    String? error,
  }) {
    return CarDetailState(
      listing: listing ?? this.listing,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
