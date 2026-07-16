class FilterOptionsModel {
  final List<String> makes;
  final Map<String, List<String>> models;
  final Map<String, List<String>> trims;
  final ({int min, int max}) years;
  final List<String> transmissions;

  const FilterOptionsModel({
    required this.makes,
    required this.models,
    required this.trims,
    required this.years,
    required this.transmissions,
  });

  factory FilterOptionsModel.fromJson(Map<String, dynamic> json) {
    return FilterOptionsModel(
      makes: List<String>.from(json['makes'] ?? []),
      models: Map<String, List<String>>.from(
        (json['models'] as Map<String, dynamic>?)?.map(
              (key, value) => MapEntry(key, List<String>.from(value)),
            ) ??
            {},
      ),
      trims: Map<String, List<String>>.from(
        (json['trims'] as Map<String, dynamic>?)?.map(
              (key, value) => MapEntry(key, List<String>.from(value)),
            ) ??
            {},
      ),
      years: (
        min: (json['years']?['min'] as int?) ?? DateTime.now().year,
        max: (json['years']?['max'] as int?) ?? DateTime.now().year,
      ),
      transmissions: List<String>.from(json['transmissions'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'makes': makes,
      'models': models,
      'trims': trims,
      'years': {'min': years.min, 'max': years.max},
      'transmissions': transmissions,
    };
  }
}
