import 'package:dio/dio.dart';

// Maximum number of retry attempts.
const int maxRetryAttempts = 3;

// Initial retry delay in seconds.
const int initialRetryDelaySeconds = 1;

// Backoff multiplier for exponential backoff.
const int backoffMultiplier = 2;

// Maximum retry delay in seconds (30 seconds cap).
const int maxRetryDelaySeconds = 30;

// Retryable HTTP status codes.
const List<int> retryableStatusCodes = [
  429, // Too Many Requests
  500, // Internal Server Error
  501, // Not Implemented
  502, // Bad Gateway
  503, // Service Unavailable
  504, // Gateway Timeout
  505, // HTTP Version Not Supported
  506, // Variant Also Negotiates
  507, // Insufficient Storage
  508, // Loop Detected
  509, // Bandwidth Limit Exceeded
  510, // Not Extended
  511, // Network Authentication Required
  598, // Network Read Timeout Error
  599, // Network Connect Timeout Error
];

// Retryable Dio exception types.
const List<DioExceptionType> retryableDioExceptionTypes = [
  DioExceptionType.connectionTimeout,
  DioExceptionType.sendTimeout,
  DioExceptionType.receiveTimeout,
  DioExceptionType.connectionError,
];

// Determines if a DioException should trigger a retry.
bool shouldRetry(DioException error) {
  // Check if the error type is retryable
  if (retryableDioExceptionTypes.contains(error.type)) {
    return true;
  }

  // Check if the response status code is retryable
  final statusCode = error.response?.statusCode;
  if (statusCode != null && retryableStatusCodes.contains(statusCode)) {
    return true;
  }

  return false;
}

// Calculates the delay for a retry attempt using exponential backoff.
Duration calculateDelay(int attempt, {int? retryAfterHeader}) {
  // If Retry-After header is provided, use it (respecting the max cap)
  if (retryAfterHeader != null && retryAfterHeader > 0) {
    final cappedDelay = retryAfterHeader > maxRetryDelaySeconds
        ? maxRetryDelaySeconds
        : retryAfterHeader;
    return Duration(seconds: cappedDelay);
  }

  // Calculate exponential backoff: initialDelay * (multiplier ^ attempt)
  final delaySeconds =
      initialRetryDelaySeconds * (backoffMultiplier ^ attempt);

  // Cap at max retry delay
  final cappedDelay = delaySeconds > maxRetryDelaySeconds
      ? maxRetryDelaySeconds
      : delaySeconds;

  return Duration(seconds: cappedDelay);
}
