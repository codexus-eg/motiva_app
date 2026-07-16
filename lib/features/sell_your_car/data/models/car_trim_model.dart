import 'package:app/features/sell_your_car/domain/entities/entities.dart';

class CarTrimModel extends CarTrim {
  const CarTrimModel({
    required super.id,
    required super.modelId,
    required super.name,
    required super.yearStart,
    required super.yearEnd,
    required super.createdAt,
  });

  factory CarTrimModel.fromJson(Map<String, dynamic> json) {
    return CarTrimModel(
      id: json['id'] as String,
      modelId: json['modelId'] as String,
      name: json['name'] as String,
      yearStart: json['yearStart'] as int,
      yearEnd: json['yearEnd'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'modelId': modelId,
      'name': name,
      'yearStart': yearStart,
      'yearEnd': yearEnd,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static List<CarTrimModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CarTrimModel.fromJson(json)).toList();
  }
}
