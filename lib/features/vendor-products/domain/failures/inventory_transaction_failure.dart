class InventoryTransactionFailure implements Exception {
  final String message;
  final String? code;

  const InventoryTransactionFailure(this.message, {this.code});

  factory InventoryTransactionFailure.unauthorized() => const InventoryTransactionFailure(
    'Unauthorized. Please login again.',
    code: '401',
  );

  factory InventoryTransactionFailure.notFound() =>
      const InventoryTransactionFailure('Transactions not found.', code: '404');

  factory InventoryTransactionFailure.validation(String details) =>
      InventoryTransactionFailure('Validation failed: $details', code: '400');

  factory InventoryTransactionFailure.serverError() => const InventoryTransactionFailure(
    'Server error. Please try again later.',
    code: '500',
  );

  factory InventoryTransactionFailure.networkError() => const InventoryTransactionFailure(
    'Network error. Please check your connection.',
    code: 'network',
  );

  factory InventoryTransactionFailure.unknown(String? message) => InventoryTransactionFailure(
    message ?? 'An unexpected error occurred.',
    code: 'unknown',
  );

  @override
  String toString() => 'InventoryTransactionFailure: $message (code: $code)';
}
