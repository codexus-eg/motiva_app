class CarTrim {
  final String id;
  final String modelId;
  final String name;
  final int yearStart;
  final int yearEnd;
  final DateTime createdAt;

  const CarTrim({
    required this.id,
    required this.modelId,
    required this.name,
    required this.yearStart,
    required this.yearEnd,
    required this.createdAt,
  });

  CarTrim copyWith({
    String? id,
    String? modelId,
    String? name,
    int? yearStart,
    int? yearEnd,
    DateTime? createdAt,
  }) {
    return CarTrim(
      id: id ?? this.id,
      modelId: modelId ?? this.modelId,
      name: name ?? this.name,
      yearStart: yearStart ?? this.yearStart,
      yearEnd: yearEnd ?? this.yearEnd,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool isValidYear(int year) {
    return year >= yearStart && year <= yearEnd;
  }
}
