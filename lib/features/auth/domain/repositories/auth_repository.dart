import 'package:app/features/auth/domain/entities/auth_result.dart';
import 'package:app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<void> sendOtp({required String phone, String userType = 'customer'});

  Future<String> verifyOtp({
    required String phone,
    required String code,
    String userType = 'customer',
  });

  Future<AuthResult> registerCustomer({
    required String verificationToken,
    required String phone,
    required String password,
    String? fullName,
    String? email,
  });

  Future<AuthResult> registerVendor({
    required String verificationToken,
    required String phone,
    required String password,
    required String businessName,
    String? fullName,
    String? email,
    String? commercialLicenseNo,
    required String categoryId,
  });

  Future<AuthResult> login({required String phone, required String password});

  Future<String> refreshAccessToken({required String refreshToken});

  Future<void> logout({required String refreshToken});

  Future<User?> getCurrentUser();

  Future<bool> isAuthenticated();

  Future<User?> validateTokenAndGetUser();

  Future<void> clearSession();

  Future<User> updateProfile({String? email});

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<void> deleteAccount();
}
