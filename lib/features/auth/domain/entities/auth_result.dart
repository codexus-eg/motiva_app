import 'package:app/features/auth/domain/entities/user.dart';
import 'package:app/features/auth/domain/entities/vendor.dart';

sealed class AuthResult {
  const AuthResult();
}

class AuthSuccess extends AuthResult {
  final User user;
  final String accessToken;
  final String refreshToken;
  final Vendor? vendor;

  const AuthSuccess({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    this.vendor,
  });
}

class AuthFailure extends AuthResult {
  final String message;
  final String? code;

  const AuthFailure({required this.message, this.code});
}
