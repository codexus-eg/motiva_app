sealed class CarListingFailure {
  final String message;

  const CarListingFailure(this.message);

  factory CarListingFailure.network([String? message]) = NetworkListingFailure;
  factory CarListingFailure.serverError([String? message]) =
      ServerErrorListingFailure;
  factory CarListingFailure.unauthorized([String? message]) =
      UnauthorizedListingFailure;
  factory CarListingFailure.notFound([String? message]) =
      NotFoundListingFailure;
  factory CarListingFailure.validation([String? message]) =
      ValidationListingFailure;
  factory CarListingFailure.unknown([String? message]) = UnknownListingFailure;
}

class NetworkListingFailure extends CarListingFailure {
  const NetworkListingFailure([String? message])
    : super(message ?? 'Network error. Please check your connection.');
}

class ServerErrorListingFailure extends CarListingFailure {
  const ServerErrorListingFailure([String? message])
    : super(message ?? 'Server error. Please try again later.');
}

class UnauthorizedListingFailure extends CarListingFailure {
  const UnauthorizedListingFailure([String? message])
    : super(message ?? 'Unauthorized. Please login again.');
}

class NotFoundListingFailure extends CarListingFailure {
  const NotFoundListingFailure([String? message])
    : super(message ?? 'Resource not found.');
}

class ValidationListingFailure extends CarListingFailure {
  const ValidationListingFailure([String? message])
    : super(message ?? 'Validation error. Please check your input.');
}

class UnknownListingFailure extends CarListingFailure {
  const UnknownListingFailure([String? message])
    : super(message ?? 'An unexpected error occurred.');
}
