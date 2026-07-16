import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shimmer_container.dart';

/// Wrapper that toggles between shimmer loading state and actual content.
/// Includes fade transition between states.
class ShimmerWrapper extends StatelessWidget {
  const ShimmerWrapper({
    super.key,
    required this.isLoading,
    required this.child,
    this.skeleton,
    this.delay = const Duration(milliseconds: 200),
    this.fadeDuration = const Duration(milliseconds: 300),
  });

  /// Whether to show the loading state
  final bool isLoading;

  /// The actual content widget to display when not loading
  final Widget child;

  /// Optional custom skeleton widget. If null, a generic shimmer container is used.
  final Widget? skeleton;

  /// Delay before showing shimmer to avoid flickering for quick loads
  final Duration delay;

  /// Duration of the fade transition between states
  final Duration fadeDuration;

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return AnimatedOpacity(
        opacity: 1.0,
        duration: fadeDuration,
        child: child,
      );
    }

    // If a custom skeleton is provided, use it directly with delay
    if (skeleton != null) {
      return FutureBuilder(
        future: Future.delayed(delay),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AnimatedOpacity(
              opacity: 1.0,
              duration: fadeDuration,
              child: skeleton,
            );
          }
          return const SizedBox.shrink();
        },
      );
    }

    // Default: extract dimensions from child and create matching skeleton
    return FutureBuilder(
      future: Future.delayed(delay),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AnimatedOpacity(
            opacity: 1.0,
            duration: fadeDuration,
            child: _buildDefaultSkeleton(context),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildDefaultSkeleton(BuildContext context) {
    final theme = Theme.of(context);
    
    // Try to determine if child is a container with specific dimensions
    return LayoutBuilder(
      builder: (context, constraints) {
        return ShimmerContainer(
          child: Container(
            width: constraints.hasBoundedWidth ? constraints.maxWidth : null,
            height: constraints.hasBoundedHeight ? constraints.maxHeight : null,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }
}

/// Extension for easy shimmer wrapping on AsyncValue
extension ShimmerAsyncValueExtension<T> on AsyncValue<T> {
  Widget whenWithShimmer({
    required Widget Function(T data) data,
    required Widget Function() shimmer,
    Widget Function(Object error, StackTrace? stackTrace)? error,
    Widget Function()? loading,
  }) {
    return when(
      data: data,
      error: error ??
          (err, stack) => ErrorWidget.builder(
                FlutterErrorDetails(
                  exception: err,
                  stack: stack,
                ),
              ),
      loading: loading ?? shimmer,
    );
  }
}
