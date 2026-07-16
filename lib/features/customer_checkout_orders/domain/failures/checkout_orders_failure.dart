class CheckoutOrdersFailure implements Exception {
  final String message;
  final String? code;

  const CheckoutOrdersFailure(this.message, {this.code});

  factory CheckoutOrdersFailure.unauthorized() => const CheckoutOrdersFailure(
    'Unauthorized. Please login again.',
    code: '401',
  );

  factory CheckoutOrdersFailure.notFound() =>
      const CheckoutOrdersFailure('Order not found.', code: '404');

  factory CheckoutOrdersFailure.serverError() => const CheckoutOrdersFailure(
    'Server error. Please try again later.',
    code: '500',
  );

  factory CheckoutOrdersFailure.networkError() => const CheckoutOrdersFailure(
    'Network error. Please check your connection.',
    code: 'network',
  );

  factory CheckoutOrdersFailure.unknown(String? message) => CheckoutOrdersFailure(
    message ?? 'An unexpected error occurred.',
    code: 'unknown',
  );

  @override
  String toString() => 'CheckoutOrdersFailure: $message (code: $code)';
}
