class DeliveryAddress {
  final String id;
  final String label;
  final String street;
  final String area;
  final String block;
  final String? building;
  final String? floor;
  final String? apartment;
  final String? notes;
  final String? phone;

  const DeliveryAddress({
    required this.id,
    required this.label,
    required this.street,
    required this.area,
    required this.block,
    this.building,
    this.floor,
    this.apartment,
    this.notes,
    this.phone,
  });

  DeliveryAddress copyWith({
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
    return DeliveryAddress(
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
