import 'package:dio/dio.dart';

/// Holds user-friendly error information extracted from a [DioException].
class DioErrorInfo {
  /// Human-readable error message suitable for displaying to the user.
  final String message;

  /// HTTP status code (null for network/timeout errors).
  final int? statusCode;

  /// The original DioException type for specialized handling.
  final DioExceptionType type;

  const DioErrorInfo({
    required this.message,
    this.statusCode,
    required this.type,
  });

  @override
  String toString() => 'DioErrorInfo(message: $message, statusCode: $statusCode, type: $type)';
}

/// Centralized utility for extracting user-friendly error messages from
/// [DioException] responses.
///
/// The backend (NestJS) can return `message` as either:
/// - A single `String`: `{"message": "Unauthorized"}`
/// - An array of `String`s (class-validator): `{"message": ["year must not be greater than 2027"]}`
/// - Null/missing: `{"error": "Bad Request"}`
///
/// This handler normalizes all cases into a single human-readable [String].
class DioErrorHandler {
  DioErrorHandler._();

  /// Extracts a [DioErrorInfo] from a [DioException].
  ///
  /// The [message] field is guaranteed to be a non-empty, user-friendly string.
  /// Priority order for message extraction:
  /// 1. `response.data['message']` (handles both `String` and `List<String>`)
  /// 2. `response.data['error']` (handles both `String` and `List<String>`)
  /// 3. Status-code-based fallback message
  /// 4. Connection/timeout-specific fallback message
  /// 5. Generic fallback: "An unexpected error occurred"
  static DioErrorInfo handle(DioException e) {
    final response = e.response;
    final statusCode = response?.statusCode;
    final data = response?.data;

    // Try to extract message from response data, handling List and String types
    final message = _extractMessage(data) ??
        _statusCodeFallback(statusCode) ??
        _connectionFallback(e.type) ??
        'An unexpected error occurred';

    return DioErrorInfo(
      message: message,
      statusCode: statusCode,
      type: e.type,
    );
  }

  /// Extracts a user-friendly message string from the response data map.
  ///
  /// Checks `data['message']` first, then `data['error']`, handling both
  /// `String` and `List<String>` types for each.
  static String? _extractMessage(dynamic data) {
    if (data is! Map<String, dynamic>) return null;

    // Try 'message' field first
    final messageValue = data['message'];
    final messageStr = _normalizeMessageValue(messageValue);
    if (messageStr != null && messageStr.isNotEmpty) return messageStr;

    // Fall back to 'error' field
    final errorValue = data['error'];
    final errorStr = _normalizeMessageValue(errorValue);
    if (errorStr != null && errorStr.isNotEmpty) return errorStr;

    return null;
  }

  /// Normalizes a message value that could be a String, List, or other type.
  ///
  /// - `List` joined with ", "
  /// - `String` returned as-is
  /// - Any other type returns null
  static String? _normalizeMessageValue(dynamic value) {
    if (value is String) return value;
    if (value is List) {
      return value.map((e) => e?.toString() ?? '').join(', ');
    }
    return null;
  }

  /// Returns a user-friendly fallback message based on HTTP status code.
  static String? _statusCodeFallback(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Please check your input and try again';
      case 401:
        return 'Session expired. Please log in again';
      case 403:
        return 'You don\'t have permission to perform this action';
      case 404:
        return 'The requested resource was not found';
      case 409:
        return 'A conflict occurred. Please refresh and try again';
      case 429:
        return 'Too many requests. Please try again later';
      case 500:
        return 'Server error. Please try again later';
      case 502:
      case 503:
      case 504:
        return 'Service temporarily unavailable. Please try again later';
      default:
        return null;
    }
  }

  /// Returns a user-friendly message for connection/timeout error types.
  static String? _connectionFallback(DioExceptionType type) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please try again';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network';
      case DioExceptionType.badResponse:
        return null; // Handled by status code fallback
      case DioExceptionType.badCertificate:
        return 'Certificate verification failed. Please check your connection';
      case DioExceptionType.cancel:
        return 'Request was cancelled';
      case DioExceptionType.unknown:
        return 'An unexpected error occurred';
    }
  }
}