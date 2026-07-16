import 'package:app/features/sell_your_car/domain/entities/fast_track_settings.dart';

class FastTrackDurationOptionModel extends FastTrackDurationOption {
  const FastTrackDurationOptionModel({
    required super.hours,
    required super.discountPercentage,
    required super.price,
  });

  factory FastTrackDurationOptionModel.fromJson(Map<String, dynamic> json) {
    return FastTrackDurationOptionModel(
      hours: json['hours'] as int,
      discountPercentage: double.parse(json['discountPercentage'].toString()),
      price: double.parse(json['price'].toString()),
    );
  }
}

class FastTrackSettingsModel extends FastTrackSettings {
  const FastTrackSettingsModel({required super.options});

  factory FastTrackSettingsModel.fromJson(Map<String, dynamic> json) {
    final optionsList = json['options'] as List<dynamic>;
    return FastTrackSettingsModel(
      options: optionsList
          .map(
            (o) =>
                FastTrackDurationOptionModel.fromJson(o as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  FastTrackSettings toEntity() {
    return FastTrackSettings(
      options: options,
    );
  }
}
