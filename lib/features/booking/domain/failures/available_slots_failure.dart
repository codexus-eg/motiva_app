class AvailableSlotsFailure implements Exception {
  final String message;
  final String? code;

  const AvailableSlotsFailure(this.message, {this.code});

  factory AvailableSlotsFailure.unauthorized() => const AvailableSlotsFailure(
    'Unauthorized. Please login again.',
    code: '401',
  );

  factory AvailableSlotsFailure.notFound() =>
      const AvailableSlotsFailure('Service not found.', code: '404');

  factory AvailableSlotsFailure.serverError() => const AvailableSlotsFailure(
    'Server error. Please try again later.',
    code: '500',
  );

  factory AvailableSlotsFailure.networkError() => const AvailableSlotsFailure(
    'Network error. Please check your connection.',
    code: 'network',
  );

  factory AvailableSlotsFailure.unknown(String? message) => AvailableSlotsFailure(
    message ?? 'An unexpected error occurred.',
    code: 'unknown',
  );

  @override
  String toString() => 'AvailableSlotsFailure: $message (code: $code)';
}
