class VoucherFailure implements Exception {
  final String message;
  final String? code;

  const VoucherFailure(this.message, {this.code});

  factory VoucherFailure.invalid() => const VoucherFailure(
    'Invalid voucher code.',
    code: 'invalid',
  );

  factory VoucherFailure.expired() => const VoucherFailure(
    'Voucher code has expired.',
    code: 'expired',
  );

  factory VoucherFailure.notFound() => const VoucherFailure(
    'Voucher code not found.',
    code: 'notFound',
  );

  factory VoucherFailure.unauthorized() => const VoucherFailure(
    'Unauthorized. Please login again.',
    code: '401',
  );

  factory VoucherFailure.forbidden() => const VoucherFailure(
    'Forbidden. Customer role required.',
    code: '403',
  );

  factory VoucherFailure.networkError() => const VoucherFailure(
    'Network error. Please check your connection.',
    code: 'network',
  );

  factory VoucherFailure.unknown(String? message) => VoucherFailure(
    message ?? 'An unexpected error occurred.',
    code: 'unknown',
  );

  @override
  String toString() => 'VoucherFailure: $message (code: $code)';
}
