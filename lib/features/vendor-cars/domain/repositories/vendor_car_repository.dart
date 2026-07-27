import 'package:app/features/vendor-cars/domain/entities/vendor_car.dart';

abstract class VendorCarRepository {
  Future<List<VendorCar>> getCars({int page, int limit});
  Future<VendorCar> getCar(String id);
  Future<VendorCar> createCar(CreateCarParams params);
  Future<VendorCar> updateCar(String id, UpdateCarParams params);
  Future<VendorCar> deleteCar(String id);
}

class CreateCarParams {
  final String make;
  final String model;
  final int year;
  final String? trim;
  final String? color;
  final String? vin;
  final int mileage;
  final String? engineSize;
  final String? transmission;
  final String conditionStatus;
  final double? askingPrice;
  final String currency;
  final List<String> images;

  const CreateCarParams({
    required this.make,
    required this.model,
    required this.year,
    this.trim,
    this.color,
    this.vin,
    required this.mileage,
    this.engineSize,
    this.transmission,
    required this.conditionStatus,
    this.askingPrice,
    this.currency = 'KWD',
    required this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'make': make,
      'model': model,
      'year': year,
      if (trim != null) 'trim': trim,
      if (color != null) 'color': color,
      if (vin != null) 'vin': vin,
      'mileage': mileage,
      if (engineSize != null) 'engineSize': engineSize,
      if (transmission != null) 'transmission': transmission,
      'conditionStatus': conditionStatus,
      if (askingPrice != null) 'askingPrice': askingPrice,
      'currency': currency,
      'images': images,
    };
  }
}

class UpdateCarParams {
  final String? make;
  final String? model;
  final int? year;
  final String? trim;
  final String? color;
  final String? vin;
  final int? mileage;
  final String? engineSize;
  final String? transmission;
  final String? conditionStatus;
  final double? askingPrice;
  final String? currency;
  final List<String>? images;

  const UpdateCarParams({
    this.make,
    this.model,
    this.year,
    this.trim,
    this.color,
    this.vin,
    this.mileage,
    this.engineSize,
    this.transmission,
    this.conditionStatus,
    this.askingPrice,
    this.currency,
    this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      if (make != null) 'make': make,
      if (model != null) 'model': model,
      if (year != null) 'year': year,
      if (trim != null) 'trim': trim,
      if (color != null) 'color': color,
      if (vin != null) 'vin': vin,
      if (mileage != null) 'mileage': mileage,
      if (engineSize != null) 'engineSize': engineSize,
      if (transmission != null) 'transmission': transmission,
      if (conditionStatus != null) 'conditionStatus': conditionStatus,
      if (askingPrice != null) 'askingPrice': askingPrice,
      if (currency != null) 'currency': currency,
      if (images != null) 'images': images,
    };
  }
}
