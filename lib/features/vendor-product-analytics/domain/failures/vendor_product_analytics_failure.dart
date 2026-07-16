class VendorProductAnalyticsFailure implements Exception {
  final String message;
  final String? code;

  const VendorProductAnalyticsFailure(this.message, {this.code});

  factory VendorProductAnalyticsFailure.unauthorized() =>
      const VendorProductAnalyticsFailure(
        'Unauthorized. Please login again.',
        code: '401',
      );

  factory VendorProductAnalyticsFailure.notFound() =>
      const VendorProductAnalyticsFailure('Analytics not found.', code: '404');

  factory VendorProductAnalyticsFailure.validation(String details) =>
      VendorProductAnalyticsFailure('Validation failed: $details', code: '400');

  factory VendorProductAnalyticsFailure.serverError() =>
      const VendorProductAnalyticsFailure(
        'Server error. Please try again later.',
        code: '500',
      );

  factory VendorProductAnalyticsFailure.networkError() =>
      const VendorProductAnalyticsFailure(
        'Network error. Please check your connection.',
        code: 'network',
      );

  factory VendorProductAnalyticsFailure.unknown(String? message) =>
      VendorProductAnalyticsFailure(
        message ?? 'An unexpected error occurred.',
        code: 'unknown',
      );

  @override
  String toString() =>
      'VendorProductAnalyticsFailure: $message (code: $code)';
}
