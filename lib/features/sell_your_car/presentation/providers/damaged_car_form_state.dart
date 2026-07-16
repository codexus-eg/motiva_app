class DamagedCarFormState {
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
  final String? paintCondition;
  final String? bodyPanelDamage;
  final String? inspectionReportUrl;
  final bool? wantsInspection;
  final String? chassisIssues;
  final String? mechanicalIssues;
  final String? warningLights;
  final String? tiresCondition;
  final bool? runsAndDrives;
  final String? color;
  final List<String> images;
  final List<String> damageImages;
  final String? description;
  final Set<String> features;
  final bool isValid;

  const DamagedCarFormState({
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
    this.paintCondition,
    this.bodyPanelDamage,
    this.inspectionReportUrl,
    this.wantsInspection,
    this.chassisIssues,
    this.mechanicalIssues,
    this.warningLights,
    this.tiresCondition,
    this.runsAndDrives,
    this.color,
    this.images = const [],
    this.damageImages = const [],
    this.description,
    this.features = const {},
    this.isValid = false,
  });

  DamagedCarFormState copyWith({
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
    String? paintCondition,
    String? bodyPanelDamage,
    String? inspectionReportUrl,
    bool? wantsInspection,
    String? chassisIssues,
    String? mechanicalIssues,
    String? warningLights,
    String? tiresCondition,
    bool? runsAndDrives,
    String? color,
    List<String>? images,
    List<String>? damageImages,
    String? description,
    Set<String>? features,
    bool? isValid,
  }) {
    return DamagedCarFormState(
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
      paintCondition: paintCondition ?? this.paintCondition,
      bodyPanelDamage: bodyPanelDamage ?? this.bodyPanelDamage,
      inspectionReportUrl: inspectionReportUrl ?? this.inspectionReportUrl,
      wantsInspection: wantsInspection ?? this.wantsInspection,
      chassisIssues: chassisIssues ?? this.chassisIssues,
      mechanicalIssues: mechanicalIssues ?? this.mechanicalIssues,
      warningLights: warningLights ?? this.warningLights,
      tiresCondition: tiresCondition ?? this.tiresCondition,
      runsAndDrives: runsAndDrives ?? this.runsAndDrives,
      color: color ?? this.color,
      images: images ?? this.images,
      damageImages: damageImages ?? this.damageImages,
      description: description ?? this.description,
      features: features ?? this.features,
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
  bool get isPaintConditionSet => paintCondition != null;
  bool get isBodyPanelDamageSet => bodyPanelDamage != null;
  bool get isChassisIssuesSet => chassisIssues != null;
  bool get isMechanicalIssuesSet => mechanicalIssues != null;
  bool get isWarningLightsSet => warningLights != null;
  bool get isTiresConditionSet => tiresCondition != null;
  bool get isRunsAndDrivesSet => runsAndDrives != null;
  bool get isColorSelected => color != null;
  bool get hasImages => images.isNotEmpty;

  List<String> getMissingFields() {
    final missing = <String>[];
    if (selectedMakeId == null) missing.add('Make');
    if (selectedModelId == null) missing.add('Model');
    if (selectedYear == null) missing.add('Year');
    if (mileage == null) missing.add('Mileage');
    if (sellingPrice == null) missing.add('Selling Price');
    if (transmission == null) missing.add('Transmission');
    if (engineSize == null) missing.add('Engine Size');
    if (paintCondition == null) missing.add('Paint Condition');
    if (bodyPanelDamage == null) missing.add('Body Panel Damage');
    if (chassisIssues == null) missing.add('Chassis Issues');
    if (mechanicalIssues == null) missing.add('Mechanical Issues');
    if (warningLights == null) missing.add('Warning Lights');
    if (tiresCondition == null) missing.add('Tires Condition');
    if (runsAndDrives == null) missing.add('Runs And Drives');
    if (color == null) missing.add('Color');
    if (images.isEmpty) missing.add('Images');
    return missing;
  }

  Map<String, dynamic> toConditionReport() {
    return {
      'chassisIssues': chassisIssues,
      'mechanicalIssues': mechanicalIssues,
      'warningLights': warningLights,
      'tiresCondition': tiresCondition,
      'paintCondition': paintCondition,
      'bodyPanelDamage': bodyPanelDamage,
      'overallNotes': description,
      'runsAndDrives': runsAndDrives,
    };
  }
}
