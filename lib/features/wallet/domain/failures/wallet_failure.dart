class WalletFailure implements Exception {
  final String message;
  final String? code;

  const WalletFailure(this.message, {this.code});

  factory WalletFailure.unauthorized() => const WalletFailure(
    'Unauthorized. Please login again.',
    code: '401',
  );

  factory WalletFailure.notFound() =>
      const WalletFailure('Resource not found.', code: '404');

  factory WalletFailure.validation(String details) =>
      WalletFailure('Validation failed: $details', code: '400');

  factory WalletFailure.serverError() => const WalletFailure(
    'Server error. Please try again later.',
    code: '500',
  );

  factory WalletFailure.networkError() => const WalletFailure(
    'Network error. Please check your connection.',
    code: 'network',
  );

  factory WalletFailure.insufficientBalance() => const WalletFailure(
    'Insufficient wallet balance.',
    code: 'insufficient_balance',
  );

  factory WalletFailure.unknown(String? message) => WalletFailure(
    message ?? 'An unexpected error occurred.',
    code: 'unknown',
  );

  @override
  String toString() => 'WalletFailure: $message (code: $code)';
}
