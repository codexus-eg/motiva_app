import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'app_logger.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class ErrorDisplay {
  static void showSnackBar(
    BuildContext context,
    Object error, {
    StackTrace? stackTrace,
  }) {
    AppLogger.error('UI Error displayed', error: error, stackTrace: stackTrace);

    if (!context.mounted) return;

    final message = formatErrorMessage(error);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SelectableText(message),
        backgroundColor: Colors.red.shade800,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'DISMISS',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  static void showErrorDialog(
    BuildContext context,
    Object error, {
    StackTrace? stackTrace,
  }) {
    AppLogger.error(
      'UI Error dialog shown',
      error: error,
      stackTrace: stackTrace,
    );

    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F2128),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Error', style: TextStyle(color: Colors.red)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                formatErrorMessage(error),
                style: const TextStyle(color: Colors.white70),
              ),
              if (stackTrace != null && kDebugMode) ...[
                const Gap(AppSpacing.md),
                const Text(
                  'Stack Trace:',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(AppSpacing.sm),
                SelectableText(
                  stackTrace.toString(),
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK', style: TextStyle(color: Color(0xFFDC8735))),
          ),
        ],
      ),
    );
  }

  static String formatErrorMessage(Object error) {
    final errorStr = error.toString();
    if (errorStr.contains(': ')) {
      return errorStr.substring(errorStr.indexOf(': ') + 2);
    }
    return errorStr;
  }
}
