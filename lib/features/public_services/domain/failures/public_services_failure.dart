class PublicServicesFailure implements Exception {
  final String message;
  final String? code;

  const PublicServicesFailure(this.message, {this.code});

  factory PublicServicesFailure.notFound() =>
      const PublicServicesFailure('Resource not found.', code: '404');

  factory PublicServicesFailure.serverError() => const PublicServicesFailure(
    'Server error. Please try again later.',
    code: '500',
  );

  factory PublicServicesFailure.networkError() => const PublicServicesFailure(
    'Network error. Please check your connection.',
    code: 'network',
  );

  factory PublicServicesFailure.unknown(String? message) =>
      PublicServicesFailure(
        message ?? 'An unexpected error occurred.',
        code: 'unknown',
      );

  @override
  String toString() => 'PublicServicesFailure: $message (code: $code)';
}
