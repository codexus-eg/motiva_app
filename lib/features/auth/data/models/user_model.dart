import 'package:app/features/auth/domain/entities/user.dart';
import 'package:app/features/auth/domain/entities/user_role.dart';

class UserModel {
  final User user;

  const UserModel(this.user);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      User(
        id: json['id'] as String,
        phone: json['phone'] as String,
        email: json['email'] as String?,
        fullName: json['fullName'] as String?,
        avatarUrl: json['avatarUrl'] as String?,
        role: UserRole.fromJson(json['role'] as String),
        isActive: json['isActive'] as bool? ?? true,
        isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
        loyaltyPoints: json['loyaltyPoints'] as int?,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': user.id,
    'phone': user.phone,
    'email': user.email,
    'fullName': user.fullName,
    'avatarUrl': user.avatarUrl,
    'role': user.role.toJson(),
    'isActive': user.isActive,
    'isPhoneVerified': user.isPhoneVerified,
    'loyaltyPoints': user.loyaltyPoints,
  };
}
