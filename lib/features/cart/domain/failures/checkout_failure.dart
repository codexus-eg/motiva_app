class CheckoutFailure implements Exception {
  final String message;
  final String? code;

  const CheckoutFailure(this.message, {this.code});

  factory CheckoutFailure.unauthorized() => const CheckoutFailure(
    'Unauthorized. Please login again.',
    code: '401',
  );

  factory CheckoutFailure.validation(String details) =>
      CheckoutFailure('Validation failed: $details', code: '400');

  factory CheckoutFailure.serverError() => const CheckoutFailure(
    'Server error. Please try again later.',
    code: '500',
  );

  factory CheckoutFailure.networkError() => const CheckoutFailure(
    'Network error. Please check your connection.',
    code: 'network',
  );

  factory CheckoutFailure.unknown(String? message) => CheckoutFailure(
    message ?? 'An unexpected error occurred.',
    code: 'unknown',
  );

  factory CheckoutFailure.forbidden() => const CheckoutFailure(
    'Forbidden. Customer role required.',
    code: '403',
  );

  @override
  String toString() => 'CheckoutFailure: $message (code: $code)';
}
