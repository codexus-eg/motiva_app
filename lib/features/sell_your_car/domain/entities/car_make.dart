class CarMake {
  final String id;
  final String name;
  final String? logoUrl;
  final int? popularity;
  final DateTime createdAt;

  const CarMake({
    required this.id,
    required this.name,
    this.logoUrl,
    this.popularity,
    required this.createdAt,
  });

  CarMake copyWith({
    String? id,
    String? name,
    String? logoUrl,
    int? popularity,
    DateTime? createdAt,
  }) {
    return CarMake(
      id: id ?? this.id,
      name: name ?? this.name,
      logoUrl: logoUrl ?? this.logoUrl,
      popularity: popularity ?? this.popularity,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
