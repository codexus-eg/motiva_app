sealed class ReviewsFailure {
  final String message;

  const ReviewsFailure(this.message);

  static ReviewsFailure network([String? message]) =>
      NetworkFailure(message ?? 'Network error');
  static ReviewsFailure unauthorized([String? message]) =>
      UnauthorizedFailure(message ?? 'Unauthorized');
  static ReviewsFailure forbidden([String? message]) =>
      ForbiddenFailure(message ?? 'Forbidden');
  static ReviewsFailure notFound([String? message]) =>
      NotFoundFailure(message ?? 'Not found');
  static ReviewsFailure alreadyReviewed([String? message]) =>
      AlreadyReviewedFailure(message ?? 'Already reviewed');
  static ReviewsFailure validation([String? message]) =>
      ValidationFailure(message ?? 'Validation error');
  static ReviewsFailure unknown([String? message]) =>
      UnknownFailure(message ?? 'Unknown error');
}

class NetworkFailure extends ReviewsFailure {
  const NetworkFailure(super.message);
}

class UnauthorizedFailure extends ReviewsFailure {
  const UnauthorizedFailure(super.message);
}

class ForbiddenFailure extends ReviewsFailure {
  const ForbiddenFailure(super.message);
}

class NotFoundFailure extends ReviewsFailure {
  const NotFoundFailure(super.message);
}

class AlreadyReviewedFailure extends ReviewsFailure {
  const AlreadyReviewedFailure(super.message);
}

class ValidationFailure extends ReviewsFailure {
  const ValidationFailure(super.message);
}

class UnknownFailure extends ReviewsFailure {
  const UnknownFailure(super.message);
}
