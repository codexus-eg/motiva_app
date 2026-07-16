import 'package:app/features/sell_your_car/domain/entities/entities.dart';

class CarMakeModel extends CarMake {
  const CarMakeModel({
    required super.id,
    required super.name,
    super.logoUrl,
    super.popularity,
    required super.createdAt,
  });

  factory CarMakeModel.fromJson(Map<String, dynamic> json) {
    return CarMakeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      logoUrl: json['logoUrl'] as String?,
      popularity: json['popularity'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logoUrl': logoUrl,
      'popularity': popularity,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static List<CarMakeModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CarMakeModel.fromJson(json)).toList();
  }
}
