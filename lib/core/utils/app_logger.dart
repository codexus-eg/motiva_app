import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error }

class AppLogger {
  static void _log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    final timestamp = DateTime.now().toIso8601String();
    final levelTag = level.name.toUpperCase();

    if (kDebugMode) {
      debugPrint('[$timestamp] [$levelTag] $message');
      if (error != null) {
        debugPrint('  Error: $error');
        debugPrint('  Type: ${error.runtimeType}');
      }
      if (stackTrace != null) {
        debugPrint('  StackTrace:\n$stackTrace');
      }
      debugPrint('─' * 80);
    }
  }

  static void debug(String message) => _log(LogLevel.debug, message);

  static void info(String message) => _log(LogLevel.info, message);

  static void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) => _log(LogLevel.warning, message, error: error, stackTrace: stackTrace);

  static void error(String message, {Object? error, StackTrace? stackTrace}) =>
      _log(LogLevel.error, message, error: error, stackTrace: stackTrace);
}
