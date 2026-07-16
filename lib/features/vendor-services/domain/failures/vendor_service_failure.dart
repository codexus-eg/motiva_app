class VendorServiceFailure implements Exception {
  final String message;
  final String? code;

  const VendorServiceFailure(this.message, {this.code});

  factory VendorServiceFailure.unauthorized() => const VendorServiceFailure(
    'Unauthorized. Please login again.',
    code: '401',
  );

  factory VendorServiceFailure.notFound() =>
      const VendorServiceFailure('Service not found.', code: '404');

  factory VendorServiceFailure.validation(String details) =>
      VendorServiceFailure('Validation failed: $details', code: '400');

  factory VendorServiceFailure.serverError() => const VendorServiceFailure(
    'Server error. Please try again later.',
    code: '500',
  );

  factory VendorServiceFailure.networkError() => const VendorServiceFailure(
    'Network error. Please check your connection.',
    code: 'network',
  );

  factory VendorServiceFailure.unknown(String? message) => VendorServiceFailure(
    message ?? 'An unexpected error occurred.',
    code: 'unknown',
  );

  @override
  String toString() => 'VendorServiceFailure: $message (code: $code)';
}
