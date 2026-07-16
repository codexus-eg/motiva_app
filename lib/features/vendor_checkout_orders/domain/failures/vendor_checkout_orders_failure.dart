class VendorCheckoutOrdersFailure implements Exception {
  final String message;
  final String? code;

  const VendorCheckoutOrdersFailure(this.message, {this.code});

  factory VendorCheckoutOrdersFailure.unauthorized() => const VendorCheckoutOrdersFailure(
    'Unauthorized. Please login again.',
    code: '401',
  );

  factory VendorCheckoutOrdersFailure.notFound() =>
      const VendorCheckoutOrdersFailure('Order not found.', code: '404');

  factory VendorCheckoutOrdersFailure.serverError() => const VendorCheckoutOrdersFailure(
    'Server error. Please try again later.',
    code: '500',
  );

  factory VendorCheckoutOrdersFailure.networkError() => const VendorCheckoutOrdersFailure(
    'Network error. Please check your connection.',
    code: 'network',
  );

  factory VendorCheckoutOrdersFailure.unknown(String? message) => VendorCheckoutOrdersFailure(
    message ?? 'An unexpected error occurred.',
    code: 'unknown',
  );

  @override
  String toString() => 'VendorCheckoutOrdersFailure: $message (code: $code)';
}
