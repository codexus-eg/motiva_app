import '../../domain/entities/delivery_address.dart';

class DeliveryAddressModel extends DeliveryAddress {
  const DeliveryAddressModel({
    required super.id,
    required super.label,
    required super.street,
    required super.area,
    required super.block,
    super.building,
    super.floor,
    super.apartment,
    super.notes,
    super.phone,
  });

  factory DeliveryAddressModel.fromEntity(DeliveryAddress entity) {
    return DeliveryAddressModel(
      id: entity.id,
      label: entity.label,
      street: entity.street,
      area: entity.area,
      block: entity.block,
      building: entity.building,
      floor: entity.floor,
      apartment: entity.apartment,
      notes: entity.notes,
      phone: entity.phone,
    );
  }

  factory DeliveryAddressModel.fromJson(Map<String, dynamic> json) {
    return DeliveryAddressModel(
      id: json['id'] as String? ?? '',
      label: json['label'] as String? ?? '',
      street: json['street'] as String? ?? '',
      area: json['area'] as String? ?? '',
      block: json['block'] as String? ?? '',
      building: json['building'] as String?,
      floor: json['floor'] as String?,
      apartment: json['apartment'] as String?,
      notes: json['notes'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'street': street,
      'area': area,
      'block': block,
      'building': building,
      'floor': floor,
      'apartment': apartment,
      'notes': notes,
      'phone': phone,
    };
  }

  DeliveryAddressModel copyWithModel({
    String? id,
    String? label,
    String? street,
    String? area,
    String? block,
    String? building,
    String? floor,
    String? apartment,
    String? notes,
    String? phone,
  }) {
    return DeliveryAddressModel(
      id: id ?? this.id,
      label: label ?? this.label,
      street: street ?? this.street,
      area: area ?? this.area,
      block: block ?? this.block,
      building: building ?? this.building,
      floor: floor ?? this.floor,
      apartment: apartment ?? this.apartment,
      notes: notes ?? this.notes,
      phone: phone ?? this.phone,
    );
  }
}
