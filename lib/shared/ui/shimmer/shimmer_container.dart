import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.baseColor,
    this.highlightColor,
  });

  final Widget child;
  final Duration duration;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    final disableAnimations =
        MediaQuery.of(context).disableAnimations ||
        (SchedulerBinding
            .instance
            .platformDispatcher
            .accessibilityFeatures
            .reduceMotion);

    if (disableAnimations) {
      return Container(
        decoration: BoxDecoration(
          color: baseColor ?? _getDefaultBaseColor(context),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Opacity(opacity: 0, child: child),
      );
    }

    final effectiveBaseColor = baseColor ?? _getDefaultBaseColor(context);
    final effectiveHighlightColor =
        highlightColor ?? _getDefaultHighlightColor(context);

    return RepaintBoundary(
      child: Shimmer.fromColors(
        baseColor: effectiveBaseColor,
        highlightColor: effectiveHighlightColor,
        period: duration,
        child: child,
      ),
    );
  }

  Color _getDefaultBaseColor(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  Color _getDefaultHighlightColor(BuildContext context) {
    return Theme.of(context).colorScheme.primaryContainer;
  }
}
