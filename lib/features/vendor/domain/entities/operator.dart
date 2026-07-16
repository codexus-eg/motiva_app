class Operator {
  final String id;
  final String userId;
  final String vendorId;
  final String name;
  final String phone;
  final String email;
  final String? avatarUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Operator({
    required this.id,
    required this.userId,
    required this.vendorId,
    required this.name,
    required this.phone,
    required this.email,
    this.avatarUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  Operator copyWith({
    String? id,
    String? userId,
    String? vendorId,
    String? name,
    String? phone,
    String? email,
    String? avatarUrl,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Operator(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      vendorId: vendorId ?? this.vendorId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Operator && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Operator(id: $id, name: $name, phone: $phone, isActive: $isActive)';
}

class CreateOperatorParams {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String? avatarUrl;
  final String? vendorId;

  const CreateOperatorParams({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    this.avatarUrl,
    this.vendorId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      if (vendorId != null) 'vendorId': vendorId,
    };
  }
}
