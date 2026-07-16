class LoyaltyFailure implements Exception {
  final String message;
  final String? code;

  const LoyaltyFailure(this.message, {this.code});

  factory LoyaltyFailure.unauthorized() => const LoyaltyFailure(
    'Unauthorized. Please login again.',
    code: '401',
  );

  factory LoyaltyFailure.notFound() =>
      const LoyaltyFailure('Resource not found.', code: '404');

  factory LoyaltyFailure.validation(String details) =>
      LoyaltyFailure('Validation failed: $details', code: '400');

  factory LoyaltyFailure.serverError() => const LoyaltyFailure(
    'Server error. Please try again later.',
    code: '500',
  );

  factory LoyaltyFailure.networkError() => const LoyaltyFailure(
    'Network error. Please check your connection.',
    code: 'network',
  );

  factory LoyaltyFailure.unknown(String? message) => LoyaltyFailure(
    message ?? 'An unexpected error occurred.',
    code: 'unknown',
  );

  @override
  String toString() => 'LoyaltyFailure: $message (code: $code)';
}
