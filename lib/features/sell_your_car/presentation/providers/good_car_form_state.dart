class GoodCarFormState {
  final String? selectedMakeId;
  final String? selectedMakeName;
  final String? selectedModelId;
  final String? selectedModelName;
  final String? selectedTrimId;
  final String? selectedTrimName;
  final int? selectedYear;
  final int? mileage;
  final double? sellingPrice;
  final String? transmission;
  final String? engineSize;
  final String? color;
  final String? selectedPlanId;
  final List<String> images;
  final String? description;
  final bool isValid;

  const GoodCarFormState({
    this.selectedMakeId,
    this.selectedMakeName,
    this.selectedModelId,
    this.selectedModelName,
    this.selectedTrimId,
    this.selectedTrimName,
    this.selectedYear,
    this.mileage,
    this.sellingPrice,
    this.transmission,
    this.engineSize,
    this.color,
    this.selectedPlanId,
    this.images = const [],
    this.description,
    this.isValid = false,
  });

  GoodCarFormState copyWith({
    String? selectedMakeId,
    String? selectedMakeName,
    String? selectedModelId,
    String? selectedModelName,
    String? selectedTrimId,
    String? selectedTrimName,
    int? selectedYear,
    int? mileage,
    double? sellingPrice,
    String? transmission,
    String? engineSize,
    String? color,
    String? selectedPlanId,
    List<String>? images,
    String? description,
    bool? isValid,
  }) {
    return GoodCarFormState(
      selectedMakeId: selectedMakeId ?? this.selectedMakeId,
      selectedMakeName: selectedMakeName ?? this.selectedMakeName,
      selectedModelId: selectedModelId ?? this.selectedModelId,
      selectedModelName: selectedModelName ?? this.selectedModelName,
      selectedTrimId: selectedTrimId ?? this.selectedTrimId,
      selectedTrimName: selectedTrimName ?? this.selectedTrimName,
      selectedYear: selectedYear ?? this.selectedYear,
      mileage: mileage ?? this.mileage,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      transmission: transmission ?? this.transmission,
      engineSize: engineSize ?? this.engineSize,
      color: color ?? this.color,
      selectedPlanId: selectedPlanId ?? this.selectedPlanId,
      images: images ?? this.images,
      description: description ?? this.description,
      isValid: isValid ?? this.isValid,
    );
  }

  bool get isMakeSelected => selectedMakeId != null;
  bool get isModelSelected => selectedModelId != null;
  bool get isTrimSelected => selectedTrimId != null;
  bool get isYearSelected => selectedYear != null;
  bool get isMileageSet => mileage != null;
  bool get isSellingPriceSet => sellingPrice != null;
  bool get isTransmissionSelected => transmission != null;
  bool get isEngineSizeSet => engineSize != null;
  bool get isColorSelected => color != null;

  List<String> getMissingFields() {
    final missing = <String>[];
    if (selectedMakeId == null) missing.add('Make');
    if (selectedModelId == null) missing.add('Model');
    if (selectedYear == null) missing.add('Year');
    if (mileage == null) missing.add('Mileage');
    if (sellingPrice == null) missing.add('Selling Price');
    if (transmission == null) missing.add('Transmission');
    if (engineSize == null) missing.add('Engine Size');
    if (color == null) missing.add('Color');
    return missing;
  }
}
