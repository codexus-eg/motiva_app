import 'package:app/features/sell_your_car/domain/entities/entities.dart';

sealed class CarDataState {
  const CarDataState();
}

class CarDataInitial extends CarDataState {
  const CarDataInitial();
}

class CarDataLoading extends CarDataState {
  const CarDataLoading();
}

class CarDataLoaded extends CarDataState {
  final List<CarMake> makes;
  final List<CarModel> models;
  final List<CarTrim> trims;
  final List<int> years;
  final CarMake? selectedMake;
  final CarModel? selectedModel;
  final CarTrim? selectedTrim;
  final int? selectedYear;

  const CarDataLoaded({
    this.makes = const [],
    this.models = const [],
    this.trims = const [],
    this.years = const [],
    this.selectedMake,
    this.selectedModel,
    this.selectedTrim,
    this.selectedYear,
  });

  CarDataLoaded copyWith({
    List<CarMake>? makes,
    List<CarModel>? models,
    List<CarTrim>? trims,
    List<int>? years,
    CarMake? selectedMake,
    CarModel? selectedModel,
    CarTrim? selectedTrim,
    int? selectedYear,
  }) {
    return CarDataLoaded(
      makes: makes ?? this.makes,
      models: models ?? this.models,
      trims: trims ?? this.trims,
      years: years ?? this.years,
      selectedMake: selectedMake ?? this.selectedMake,
      selectedModel: selectedModel ?? this.selectedModel,
      selectedTrim: selectedTrim ?? this.selectedTrim,
      selectedYear: selectedYear ?? this.selectedYear,
    );
  }
}

class CarDataError extends CarDataState {
  final String message;

  const CarDataError(this.message);
}
