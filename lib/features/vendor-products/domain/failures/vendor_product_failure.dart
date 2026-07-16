class VendorProductFailure implements Exception {
  final String message;
  final String? code;

  const VendorProductFailure(this.message, {this.code});

  factory VendorProductFailure.unauthorized() => const VendorProductFailure(
    'Unauthorized. Please login again.',
    code: '401',
  );

  factory VendorProductFailure.notFound() =>
      const VendorProductFailure('Product not found.', code: '404');

  factory VendorProductFailure.validation(String details) =>
      VendorProductFailure('Validation failed: $details', code: '400');

  factory VendorProductFailure.serverError() => const VendorProductFailure(
    'Server error. Please try again later.',
    code: '500',
  );

  factory VendorProductFailure.networkError() => const VendorProductFailure(
    'Network error. Please check your connection.',
    code: 'network',
  );

  factory VendorProductFailure.unknown(String? message) => VendorProductFailure(
    message ?? 'An unexpected error occurred.',
    code: 'unknown',
  );

  @override
  String toString() => 'VendorProductFailure: $message (code: $code)';
}
