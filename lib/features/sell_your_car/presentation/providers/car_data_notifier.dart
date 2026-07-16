import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/sell_your_car/data/data.dart';
import 'package:app/features/sell_your_car/domain/domain.dart';
import 'package:app/core/utils/app_logger.dart';
import 'car_data_state.dart';

class CarDataNotifier extends AsyncNotifier<CarDataState> {
  @override
  CarDataState build() {
    return const CarDataInitial();
  }

  CarDataLoaded _getLoadedState() {
    final currentState = state.valueOrNull;
    if (currentState is CarDataLoaded) {
      return currentState;
    }
    return const CarDataLoaded();
  }

  Future<void> loadMakes() async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(carDataRepositoryProvider);
      final makes = await repository.getMakes();
      state = AsyncData(CarDataLoaded(makes: makes));
    } catch (e, stackTrace) {
      AppLogger.error('loadMakes failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> searchMakes(String query) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(carDataRepositoryProvider);
      final makes = await repository.searchMakes(query);
      final currentState = _getLoadedState();
      state = AsyncData(currentState.copyWith(makes: makes));
    } catch (e, stackTrace) {
      AppLogger.error('searchMakes failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> loadModels(String makeId) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(carDataRepositoryProvider);
      final models = await repository.getModelsByMake(makeId);
      final currentState = _getLoadedState();
      state = AsyncData(
        currentState.copyWith(
          models: models,
          selectedModel: null,
          selectedTrim: null,
          selectedYear: null,
        ),
      );
    } catch (e, stackTrace) {
      AppLogger.error('loadModels failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> loadTrims(String modelId) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(carDataRepositoryProvider);
      final trims = await repository.getTrimsByModel(modelId);
      final currentState = _getLoadedState();
      state = AsyncData(
        currentState.copyWith(
          trims: trims,
          selectedTrim: null,
          selectedYear: null,
        ),
      );
    } catch (e, stackTrace) {
      AppLogger.error('loadTrims failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> loadYears(String modelId) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(carDataRepositoryProvider);
      final years = await repository.getYearsForModel(modelId);
      final currentState = _getLoadedState();
      state = AsyncData(currentState.copyWith(years: years));
    } catch (e, stackTrace) {
      AppLogger.error('loadYears failed', error: e, stackTrace: stackTrace);
      state = AsyncError(e, stackTrace);
    }
  }

  void selectMake(CarMake make) {
    final currentState = _getLoadedState();
    state = AsyncData(
      currentState.copyWith(
        selectedMake: make,
        selectedModel: null,
        selectedTrim: null,
        selectedYear: null,
      ),
    );
  }

  void selectModel(CarModel model) {
    final currentState = _getLoadedState();
    state = AsyncData(
      currentState.copyWith(
        selectedModel: model,
        selectedTrim: null,
        selectedYear: null,
      ),
    );
  }

  void selectTrim(CarTrim trim) {
    final currentState = _getLoadedState();
    state = AsyncData(currentState.copyWith(selectedTrim: trim));
  }

  void selectYear(int year) {
    final currentState = _getLoadedState();
    state = AsyncData(currentState.copyWith(selectedYear: year));
  }

  void reset() {
    state = const AsyncData(CarDataLoaded());
  }
}

final carDataNotifierProvider =
    AsyncNotifierProvider<CarDataNotifier, CarDataState>(CarDataNotifier.new);

final carDataRemoteDataSourceProvider = Provider<CarDataRemoteDataSource>((
  ref,
) {
  final dioClient = ref.watch(dioClientProvider);
  return CarDataRemoteDataSourceImpl(dioClient);
});

final carDataRepositoryProvider = Provider<CarDataRepository>((ref) {
  final remoteDataSource = ref.watch(carDataRemoteDataSourceProvider);
  return CarDataRepositoryImpl(remoteDataSource);
});
