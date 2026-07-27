class VendorCarFailure implements Exception {
  final String message;
  final int? statusCode;

  VendorCarFailure(this.message, {this.statusCode});

  factory VendorCarFailure.unauthorized() {
    return VendorCarFailure('Unauthorized access', statusCode: 401);
  }

  factory VendorCarFailure.notFound() {
    return VendorCarFailure('Car not found', statusCode: 404);
  }

  factory VendorCarFailure.validation(String message) {
    return VendorCarFailure(message, statusCode: 400);
  }

  factory VendorCarFailure.serverError() {
    return VendorCarFailure('Server error occurred', statusCode: 500);
  }

  factory VendorCarFailure.networkError() {
    return VendorCarFailure('Network error occurred');
  }

  factory VendorCarFailure.unknown(String message) {
    return VendorCarFailure(message);
  }

  @override
  String toString() => 'VendorCarFailure: $message';
}
