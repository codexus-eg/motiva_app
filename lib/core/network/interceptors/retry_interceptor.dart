import 'package:dio/dio.dart';
import 'package:app/core/services/network_info_service.dart';
import 'package:app/core/utils/retry_utils.dart';
import 'package:app/core/utils/app_logger.dart';

/// Dio interceptor that implements automatic retry logic with exponential backoff
/// for transient network failures.
///
/// Retries up to 3 times with delays: 1s → 2s → 4s (capped at 30s)
/// Only retries on timeout errors, connection errors, 5xx errors, and 429 rate limit.
/// Checks connectivity before each retry attempt.
/// Respects Retry-After header for 429 errors.
class RetryInterceptor extends Interceptor {
  final Dio _dio;
  final NetworkInfoService _networkInfo;

  RetryInterceptor({
    required Dio dio,
    required NetworkInfoService networkInfo,
  })  : _dio = dio,
        _networkInfo = networkInfo;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if this error should be retried
    if (!shouldRetry(err)) {
      handler.next(err);
      return;
    }

    // Skip retry for FormData requests — FormData is single-use and cannot be re-sent
    if (err.requestOptions.data is FormData) {
      handler.next(err);
      return;
    }

    // Get the retry attempt count from request options (0 if first attempt)
    final attempt = err.requestOptions.extra['retry_attempt'] as int? ?? 0;

    // Check if we've exceeded max retries
    if (attempt >= maxRetryAttempts) {
      AppLogger.warning(
        'Max retry attempts ($maxRetryAttempts) exceeded for ${err.requestOptions.method} ${err.requestOptions.path}',
        error: err.message,
      );
      handler.next(err);
      return;
    }

    // Check connectivity before retrying
    final isConnected = await _networkInfo.isConnected;
    if (!isConnected) {
      AppLogger.warning(
        'No network connectivity. Skipping retry for ${err.requestOptions.method} ${err.requestOptions.path}',
      );
      handler.next(err);
      return;
    }

    // Calculate delay
    final retryAfterHeader = _getRetryAfterSeconds(err.response);
    final delay = calculateDelay(attempt, retryAfterHeader: retryAfterHeader);

    // Log retry attempt
    AppLogger.info(
      'Retrying request ${err.requestOptions.method} ${err.requestOptions.path} (attempt ${attempt + 1}/$maxRetryAttempts) after ${delay.inSeconds}s delay',
    );

    // Wait for the calculated delay
    await Future.delayed(delay);

    // Recheck connectivity after the delay
    final stillConnected = await _networkInfo.isConnected;
    if (!stillConnected) {
      AppLogger.warning(
        'Lost network connectivity during retry delay. Aborting retry for ${err.requestOptions.method} ${err.requestOptions.path}',
      );
      handler.next(err);
      return;
    }

    // Create updated request options with retry attempt counter
    final updatedOptions = err.requestOptions.copyWith(
      extra: {
        ...err.requestOptions.extra,
        'retry_attempt': attempt + 1,
      },
    );

    try {
      // Retry the request
      final response = await _dio.fetch(updatedOptions);
      handler.resolve(response);
    } catch (e) {
      // If the retry fails, propagate the error
      if (e is DioException) {
        handler.next(e);
      } else {
        handler.next(err);
      }
    }
  }

  /// Extracts the Retry-After header value in seconds.
  /// Returns null if the header is not present or invalid.
  int? _getRetryAfterSeconds(Response? response) {
    if (response == null) return null;

    final retryAfter = response.headers.value('retry-after');
    if (retryAfter == null) return null;

    // Retry-After can be a delta-seconds value or an HTTP-date
    // We only handle the delta-seconds case (integer seconds)
    final seconds = int.tryParse(retryAfter);
    if (seconds != null && seconds > 0) {
      return seconds;
    }

    return null;
  }
}
