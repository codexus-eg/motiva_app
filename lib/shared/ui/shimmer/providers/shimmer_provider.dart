import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for synchronizing shimmer animations across the app.
/// This ensures all shimmer instances animate in unison for a polished effect.
final shimmerAnimationControllerProvider = Provider<AnimationController>((ref) {
  throw UnimplementedError(
    'This provider must be overridden with an AnimationController from a TickerProvider. '
    'Use shimmerAnimationControllerFamily with a TickerProviderMixin.',
  );
});

/// Family provider that creates a synchronized shimmer animation controller.
/// Pass a TickerProvider (like from a StatefulWidget with TickerProviderStateMixin)
/// to create a properly initialized controller.
final shimmerAnimationControllerFamily =
    Provider.family<AnimationController, TickerProvider>((ref, tickerProvider) {
      final controller = AnimationController(
        vsync: tickerProvider,
        duration: const Duration(milliseconds: 1500),
      );

      controller.repeat();

      ref.onDispose(() {
        controller.dispose();
      });

      return controller;
    });

/// A widget that provides synchronized shimmer animation to its descendants.
/// Wrap your screen or widget tree with this to enable synchronized shimmer effects.
class ShimmerAnimationProvider extends ConsumerStatefulWidget {
  const ShimmerAnimationProvider({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<ShimmerAnimationProvider> createState() =>
      _ShimmerAnimationProviderState();
}

class _ShimmerAnimationProviderState
    extends ConsumerState<ShimmerAnimationProvider>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        shimmerAnimationControllerProvider.overrideWithValue(_controller),
      ],
      child: widget.child,
    );
  }
}

/// Provider to track global shimmer enabled state (for accessibility)
final shimmerEnabledProvider = StateProvider<bool>((ref) => true);

/// Provider for shimmer duration (can be adjusted globally)
final shimmerDurationProvider = StateProvider<Duration>(
  (ref) => const Duration(milliseconds: 1500),
);
