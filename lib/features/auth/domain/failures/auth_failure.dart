sealed class AuthFailure {
  final String message;

  const AuthFailure(this.message);

  static AuthFailure network([String? message]) =>
      NetworkFailure(message ?? 'Network error');
  static AuthFailure unauthorized([String? message]) =>
      UnauthorizedFailure(message ?? 'Unauthorized');
  static AuthFailure invalidOtp([String? message]) =>
      InvalidOtpFailure(message ?? 'Invalid OTP code');
  static AuthFailure phoneExists([String? message]) =>
      PhoneExistsFailure(message ?? 'Phone number already registered');
  static AuthFailure invalidCredentials([String? message]) =>
      InvalidCredentialsFailure(message ?? 'Invalid credentials');
  static AuthFailure tokenExpired([String? message]) =>
      TokenExpiredFailure(message ?? 'Token expired');
  static AuthFailure serverError([String? message]) =>
      ServerErrorFailure(message ?? 'Server error');
  static AuthFailure unknown([String? message]) =>
      UnknownFailure(message ?? 'Unknown error');
  static AuthFailure validation([String? message]) =>
      ValidationFailure(message ?? 'Validation error');
}

class NetworkFailure extends AuthFailure {
  const NetworkFailure(super.message);
}

class UnauthorizedFailure extends AuthFailure {
  const UnauthorizedFailure(super.message);
}

class InvalidOtpFailure extends AuthFailure {
  const InvalidOtpFailure(super.message);
}

class PhoneExistsFailure extends AuthFailure {
  const PhoneExistsFailure(super.message);
}

class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure(super.message);
}

class TokenExpiredFailure extends AuthFailure {
  const TokenExpiredFailure(super.message);
}

class ServerErrorFailure extends AuthFailure {
  const ServerErrorFailure(super.message);
}

class UnknownFailure extends AuthFailure {
  const UnknownFailure(super.message);
}

class ValidationFailure extends AuthFailure {
  const ValidationFailure(super.message);
}
