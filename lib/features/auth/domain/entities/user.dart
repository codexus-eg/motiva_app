import 'package:app/features/auth/domain/entities/user_role.dart';

class User {
  final String id;
  final String phone;
  final String? email;
  final String? fullName;
  final String? avatarUrl;
  final UserRole role;
  final bool isActive;
  final bool isPhoneVerified;
  final int? loyaltyPoints;

  const User({
    required this.id,
    required this.phone,
    this.email,
    this.fullName,
    this.avatarUrl,
    required this.role,
    this.isActive = true,
    this.isPhoneVerified = false,
    this.loyaltyPoints,
  });

  User copyWith({
    String? id,
    String? phone,
    String? email,
    String? fullName,
    String? avatarUrl,
    UserRole? role,
    bool? isActive,
    bool? isPhoneVerified,
    int? loyaltyPoints,
  }) {
    return User(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'phone': phone,
    'email': email,
    'fullName': fullName,
    'avatarUrl': avatarUrl,
    'role': role.toJson(),
    'isActive': isActive,
    'isPhoneVerified': isPhoneVerified,
    'loyaltyPoints': loyaltyPoints,
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      role: UserRole.fromJson(json['role'] as String),
      isActive: json['isActive'] as bool? ?? true,
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
      loyaltyPoints: json['loyaltyPoints'] as int?,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          phone == other.phone &&
          email == other.email &&
          fullName == other.fullName &&
          avatarUrl == other.avatarUrl &&
          role == other.role &&
          isActive == other.isActive &&
          isPhoneVerified == other.isPhoneVerified &&
          loyaltyPoints == other.loyaltyPoints;

  @override
  int get hashCode => Object.hash(
    id,
    phone,
    email,
    fullName,
    avatarUrl,
    role,
    isActive,
    isPhoneVerified,
    loyaltyPoints,
  );

  @override
  String toString() =>
      'User(id: $id, phone: $phone, email: $email, fullName: $fullName, avatarUrl: $avatarUrl, role: $role, isActive: $isActive, isPhoneVerified: $isPhoneVerified, loyaltyPoints: $loyaltyPoints)';
}
