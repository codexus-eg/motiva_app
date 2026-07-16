enum BodyType {
  sedan,
  hatchback,
  suv,
  crossover,
  coupe,
  convertible,
  truck,
  van,
  wagon,
  minivan,
}

class CarModel {
  final String id;
  final String makeId;
  final String name;
  final BodyType? bodyType;
  final int? popularity;
  final DateTime createdAt;

  const CarModel({
    required this.id,
    required this.makeId,
    required this.name,
    this.bodyType,
    this.popularity,
    required this.createdAt,
  });

  CarModel copyWith({
    String? id,
    String? makeId,
    String? name,
    BodyType? bodyType,
    int? popularity,
    DateTime? createdAt,
  }) {
    return CarModel(
      id: id ?? this.id,
      makeId: makeId ?? this.makeId,
      name: name ?? this.name,
      bodyType: bodyType ?? this.bodyType,
      popularity: popularity ?? this.popularity,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
