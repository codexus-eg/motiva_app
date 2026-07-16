class PublicMarketplaceFailure implements Exception {
  final String message;
  final String? code;

  const PublicMarketplaceFailure(this.message, {this.code});

  factory PublicMarketplaceFailure.notFound() =>
      const PublicMarketplaceFailure('Product not found.', code: '404');

  factory PublicMarketplaceFailure.serverError() => const PublicMarketplaceFailure(
    'Server error. Please try again later.',
    code: '500',
  );

  factory PublicMarketplaceFailure.networkError() => const PublicMarketplaceFailure(
    'Network error. Please check your connection.',
    code: 'network',
  );

  factory PublicMarketplaceFailure.unknown(String? message) =>
      PublicMarketplaceFailure(
        message ?? 'An unexpected error occurred.',
        code: 'unknown',
      );

  @override
  String toString() => 'PublicMarketplaceFailure: $message (code: $code)';
}
