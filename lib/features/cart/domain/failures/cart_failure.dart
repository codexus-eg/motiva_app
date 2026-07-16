class CartFailure implements Exception {
  final String message;
  final String? code;

  const CartFailure(this.message, {this.code});

  factory CartFailure.unauthorized() => const CartFailure(
    'Unauthorized. Please login again.',
    code: '401',
  );

  factory CartFailure.notFound() =>
      const CartFailure('Cart or item not found.', code: '404');

  factory CartFailure.validation(String details) =>
      CartFailure('Validation failed: $details', code: '400');

  factory CartFailure.serverError() => const CartFailure(
    'Server error. Please try again later.',
    code: '500',
  );

  factory CartFailure.networkError() => const CartFailure(
    'Network error. Please check your connection.',
    code: 'network',
  );

  factory CartFailure.unknown(String? message) => CartFailure(
    message ?? 'An unexpected error occurred.',
    code: 'unknown',
  );

  @override
  String toString() => 'CartFailure: $message (code: $code)';
}
