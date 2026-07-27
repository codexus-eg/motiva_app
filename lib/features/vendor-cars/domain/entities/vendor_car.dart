class VendorCar {
  final String id;
  final String vendorId;
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
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const VendorCar({
    required this.id,
    required this.vendorId,
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
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  VendorCar copyWith({
    String? id,
    String? vendorId,
    String? make,
    String? model,
    int? year,
    String? trim,
    String? color,
    String? vin,
    int? mileage,
    String? engineSize,
    String? transmission,
    String? conditionStatus,
    double? askingPrice,
    String? currency,
    List<String>? images,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VendorCar(
      id: id ?? this.id,
      vendorId: vendorId ?? this.vendorId,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      trim: trim ?? this.trim,
      color: color ?? this.color,
      vin: vin ?? this.vin,
      mileage: mileage ?? this.mileage,
      engineSize: engineSize ?? this.engineSize,
      transmission: transmission ?? this.transmission,
      conditionStatus: conditionStatus ?? this.conditionStatus,
      askingPrice: askingPrice ?? this.askingPrice,
      currency: currency ?? this.currency,
      images: images ?? this.images,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VendorCar &&
        other.id == id &&
        other.vendorId == vendorId &&
        other.make == make &&
        other.model == model &&
        other.year == year &&
        other.trim == trim &&
        other.color == color &&
        other.vin == vin &&
        other.mileage == mileage &&
        other.engineSize == engineSize &&
        other.transmission == transmission &&
        other.conditionStatus == conditionStatus &&
        other.askingPrice == askingPrice &&
        other.currency == currency &&
        _listEquals(other.images, images) &&
        other.isActive == isActive &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => Object.hash(
        id,
        vendorId,
        make,
        model,
        year,
        trim,
        color,
        vin,
        mileage,
        engineSize,
        transmission,
        conditionStatus,
        askingPrice,
        currency,
        Object.hashAll(images),
        isActive,
        createdAt,
        updatedAt,
      );

  static bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  String toString() {
    return 'VendorCar(id: $id, make: $make, model: $model, year: $year, price: $askingPrice $currency, mileage: $mileage, condition: $conditionStatus, isActive: $isActive)';
  }
}
