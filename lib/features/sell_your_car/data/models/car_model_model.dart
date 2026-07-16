import 'package:app/features/sell_your_car/domain/entities/entities.dart';

class CarModelModel extends CarModel {
  const CarModelModel({
    required super.id,
    required super.makeId,
    required super.name,
    super.bodyType,
    super.popularity,
    required super.createdAt,
  });

  factory CarModelModel.fromJson(Map<String, dynamic> json) {
    return CarModelModel(
      id: json['id'] as String,
      makeId: json['makeId'] as String,
      name: json['name'] as String,
      bodyType: json['bodyType'] != null
          ? _parseBodyType(json['bodyType'] as String)
          : null,
      popularity: json['popularity'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  static BodyType? _parseBodyType(String value) {
    return BodyType.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => BodyType.sedan,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'makeId': makeId,
      'name': name,
      'bodyType': bodyType?.name.toUpperCase(),
      'popularity': popularity,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static List<CarModelModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CarModelModel.fromJson(json)).toList();
  }
}
