import 'package:app/features/vendor-cars/domain/entities/vendor_car.dart';

class VendorCarModel {
  final VendorCar vendorCar;

  VendorCarModel(this.vendorCar);

  factory VendorCarModel.fromJson(Map<String, dynamic> json) {
    return VendorCarModel(
      VendorCar(
        id: json['id'] as String? ?? '',
        vendorId: json['vendorId'] as String? ?? '',
        make: json['make'] as String? ?? '',
        model: json['model'] as String? ?? '',
        year: (json['year'] as num?)?.toInt() ?? 0,
        trim: json['trim'] as String?,
        color: json['color'] as String?,
        vin: json['vin'] as String?,
        mileage: (json['mileage'] as num?)?.toInt() ?? 0,
        engineSize: json['engineSize'] as String?,
        transmission: json['transmission'] as String?,
        conditionStatus: json['conditionStatus'] as String? ?? 'good',
        askingPrice: (json['askingPrice'] as num?)?.toDouble(),
        currency: json['currency'] as String? ?? 'KWD',
        images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [],
        isActive: json['isActive'] as bool? ?? true,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'] as String)
            : DateTime.now(),
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'] as String)
            : DateTime.now(),
      ),
    );
  }

  static List<VendorCar> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => VendorCarModel.fromJson(json as Map<String, dynamic>).vendorCar)
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': vendorCar.id,
      'vendorId': vendorCar.vendorId,
      'make': vendorCar.make,
      'model': vendorCar.model,
      'year': vendorCar.year,
      if (vendorCar.trim != null) 'trim': vendorCar.trim,
      if (vendorCar.color != null) 'color': vendorCar.color,
      if (vendorCar.vin != null) 'vin': vendorCar.vin,
      'mileage': vendorCar.mileage,
      if (vendorCar.engineSize != null) 'engineSize': vendorCar.engineSize,
      if (vendorCar.transmission != null) 'transmission': vendorCar.transmission,
      'conditionStatus': vendorCar.conditionStatus,
      if (vendorCar.askingPrice != null) 'askingPrice': vendorCar.askingPrice,
      'currency': vendorCar.currency,
      'images': vendorCar.images,
      'isActive': vendorCar.isActive,
      'createdAt': vendorCar.createdAt.toIso8601String(),
      'updatedAt': vendorCar.updatedAt.toIso8601String(),
    };
  }
}
