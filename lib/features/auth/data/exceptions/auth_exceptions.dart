class AuthException implements Exception {
  final String message;
  final String? code;

  const AuthException(this.message, [this.code]);

  factory AuthException.unauthorized([String? message]) = UnauthorizedException;
  factory AuthException.invalidOtp([String? message]) = InvalidOtpException;
  factory AuthException.phoneExists([String? message]) = PhoneExistsException;
  factory AuthException.invalidCredentials([String? message]) =
      InvalidCredentialsException;
  factory AuthException.tokenExpired([String? message]) = TokenExpiredException;
  factory AuthException.serverError([String? message]) = ServerErrorException;
  factory AuthException.network([String? message]) = NetworkException;
  factory AuthException.unknown([String? message]) = UnknownException;
  factory AuthException.validation([String? message]) = ValidationException;
  factory AuthException.accountInactive([String? message]) =
      AccountInactiveException;

  @override
  String toString() => 'AuthException: $message';
}

class UnauthorizedException extends AuthException {
  const UnauthorizedException([String? message])
    : super(message ?? 'Unauthorized');
}

class InvalidOtpException extends AuthException {
  const InvalidOtpException([String? message])
    : super(message ?? 'Invalid OTP code');
}

class PhoneExistsException extends AuthException {
  const PhoneExistsException([String? message])
    : super(message ?? 'Phone number already registered');
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException([String? message])
    : super(message ?? 'Invalid phone number or password');
}

class TokenExpiredException extends AuthException {
  const TokenExpiredException([String? message])
    : super(message ?? 'Token expired');
}

class ServerErrorException extends AuthException {
  const ServerErrorException([String? message])
    : super(message ?? 'Server error');
}

class NetworkException extends AuthException {
  const NetworkException([String? message]) : super(message ?? 'Network error');
}

class UnknownException extends AuthException {
  const UnknownException([String? message]) : super(message ?? 'Unknown error');
}

class ValidationException extends AuthException {
  const ValidationException([String? message])
    : super(message ?? 'Validation error');
}

class AccountInactiveException extends AuthException {
  const AccountInactiveException([String? message])
    : super(message ?? 'Account is pending approval');
}
