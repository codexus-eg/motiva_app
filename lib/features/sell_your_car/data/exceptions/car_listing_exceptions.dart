sealed class CarListingException implements Exception {
  final String message;

  const CarListingException(this.message);

  factory CarListingException.network([String? message]) =
      NetworkListingException;
  factory CarListingException.serverError([String? message]) =
      ServerErrorListingException;
  factory CarListingException.unauthorized([String? message]) =
      UnauthorizedListingException;
  factory CarListingException.notFound([String? message]) =
      NotFoundListingException;
  factory CarListingException.validation([String? message]) =
      ValidationListingException;
  factory CarListingException.unknown([String? message]) =
      UnknownListingException;
}

class NetworkListingException extends CarListingException {
  const NetworkListingException([String? message])
    : super(message ?? 'Network error. Please check your connection.');
}

class ServerErrorListingException extends CarListingException {
  const ServerErrorListingException([String? message])
    : super(message ?? 'Server error. Please try again later.');
}

class UnauthorizedListingException extends CarListingException {
  const UnauthorizedListingException([String? message])
    : super(message ?? 'Unauthorized. Please login again.');
}

class NotFoundListingException extends CarListingException {
  const NotFoundListingException([String? message])
    : super(message ?? 'Resource not found.');
}

class ValidationListingException extends CarListingException {
  const ValidationListingException([String? message])
    : super(message ?? 'Validation error. Please check your input.');
}

class UnknownListingException extends CarListingException {
  const UnknownListingException([String? message])
    : super(message ?? 'An unexpected error occurred.');
}
