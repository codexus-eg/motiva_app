import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/sell_your_car/domain/repositories/car_marketplace_repository.dart';
import 'package:app/features/sell_your_car/data/datasources/datasources.dart';
import 'package:app/features/sell_your_car/data/repositories/repositories.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';

final carFilterRemoteDataSourceProvider =
    Provider<CarMarketplaceRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return CarMarketplaceRemoteDataSourceImpl(dioClient);
    });

final carFilterRepositoryProvider = Provider<CarMarketplaceRepository>((ref) {
  final remoteDataSource = ref.watch(carFilterRemoteDataSourceProvider);
  return CarMarketplaceRepositoryImpl(remoteDataSource);
});

class CarFilterState {
  final String? make;
  final String? model;
  final String? trim;
  final int? yearFrom;
  final int? yearTo;
  final int? mileageFrom;
  final int? mileageTo;
  final String? transmission;

  const CarFilterState({
    this.make,
    this.model,
    this.trim,
    this.yearFrom,
    this.yearTo,
    this.mileageFrom,
    this.mileageTo,
    this.transmission,
  });

  CarFilterState copyWith({
    String? make,
    String? model,
    String? trim,
    int? yearFrom,
    int? yearTo,
    int? mileageFrom,
    int? mileageTo,
    String? transmission,
    bool clearMake = false,
    bool clearModel = false,
    bool clearTrim = false,
    bool clearYear = false,
    bool clearMileage = false,
    bool clearTransmission = false,
  }) {
    return CarFilterState(
      make: clearMake ? null : (make ?? this.make),
      model: clearModel ? null : (model ?? this.model),
      trim: clearTrim ? null : (trim ?? this.trim),
      yearFrom: clearYear ? null : (yearFrom ?? this.yearFrom),
      yearTo: clearYear ? null : (yearTo ?? this.yearTo),
      mileageFrom: clearMileage ? null : (mileageFrom ?? this.mileageFrom),
      mileageTo: clearMileage ? null : (mileageTo ?? this.mileageTo),
      transmission: clearTransmission
          ? null
          : (transmission ?? this.transmission),
    );
  }

  bool get hasActiveFilters =>
      make != null ||
      model != null ||
      trim != null ||
      yearFrom != null ||
      yearTo != null ||
      mileageFrom != null ||
      mileageTo != null ||
      transmission != null;

  String? get yearDisplay {
    if (yearFrom != null && yearTo != null) {
      return '$yearFrom - $yearTo';
    } else if (yearFrom != null) {
      return 'From $yearFrom';
    } else if (yearTo != null) {
      return 'Up to $yearTo';
    }
    return null;
  }

  String? get mileageDisplay {
    if (mileageFrom != null && mileageTo != null) {
      return '${mileageFrom! ~/ 1000}k - ${mileageTo! ~/ 1000}k km';
    } else if (mileageFrom != null) {
      return 'From ${mileageFrom! ~/ 1000}k km';
    } else if (mileageTo != null) {
      return 'Up to ${mileageTo! ~/ 1000}k km';
    }
    return null;
  }

  CarFilterState clear() => const CarFilterState();
}

final carFilterStateProvider =
    StateNotifierProvider<CarFilterNotifier, CarFilterState>((ref) {
      return CarFilterNotifier();
    });

class CarFilterNotifier extends StateNotifier<CarFilterState> {
  CarFilterNotifier() : super(const CarFilterState());

  void setMake(String? make) {
    state = state.copyWith(make: make, clearMake: make == null);
  }

  void setModel(String? model) {
    state = state.copyWith(model: model, clearModel: model == null);
  }

  void setTrim(String? trim) {
    state = state.copyWith(trim: trim, clearTrim: trim == null);
  }

  void setYearRange(int? yearFrom, int? yearTo) {
    state = state.copyWith(
      yearFrom: yearFrom,
      yearTo: yearTo,
      clearYear: yearFrom == null && yearTo == null,
    );
  }

  void setMileageRange(int? mileageFrom, int? mileageTo) {
    state = state.copyWith(
      mileageFrom: mileageFrom,
      mileageTo: mileageTo,
      clearMileage: mileageFrom == null && mileageTo == null,
    );
  }

  void setTransmission(String? transmission) {
    state = state.copyWith(
      transmission: transmission,
      clearTransmission: transmission == null,
    );
  }

  void clearMake() => state = state.copyWith(clearMake: true);
  void clearModel() => state = state.copyWith(clearModel: true);
  void clearTrim() => state = state.copyWith(clearTrim: true);
  void clearYear() => state = state.copyWith(clearYear: true);
  void clearMileage() => state = state.copyWith(clearMileage: true);
  void clearTransmission() => state = state.copyWith(clearTransmission: true);

  void clearAll() {
    state = const CarFilterState();
  }
}

final filterOptionsProvider = FutureProvider<FilterOptions>((ref) async {
  final repository = ref.watch(carFilterRepositoryProvider);
  return await repository.getFilterOptions();
});
