import 'package:flutter/material.dart';
import 'shimmer_container.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

/// Utility class with pre-built shimmer skeleton layouts.
class ShimmerSkeletons {
  const ShimmerSkeletons._();

  /// Card skeleton - 161px height, full width
  /// Use case: Service cards, order cards
  static Widget cardSkeleton({double? width, double height = 161}) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return ShimmerContainer(
          child: Container(
            width: width ?? double.infinity,
            height: height,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }

  /// List item skeleton - ~80px height
  /// Use case: List items with image + text
  static Widget listItemSkeleton({
    double height = 80,
    bool showLeadingCircle = true,
    double? width,
  }) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return ShimmerContainer(
          child: Container(
            width: width ?? double.infinity,
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                if (showLeadingCircle) ...[
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Gap(AppSpacing.md),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 16,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const Gap(AppSpacing.sm),
                      Container(
                        width: 120,
                        height: 12,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Grid item skeleton - GridView with 4 columns, 8 items
  /// Use case: Grid items (popular services)
  static Widget gridItemSkeleton() {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return ShimmerContainer(
          child: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 20,
            crossAxisSpacing: 10,
            childAspectRatio: 0.75,
            children: List.generate(8, (index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }

  /// Text skeleton - configurable width/height
  /// Use case: Text lines, headers
  static Widget textSkeleton({
    double width = 100,
    double height = 14,
    BorderRadius? borderRadius,
  }) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return ShimmerContainer(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: borderRadius ?? BorderRadius.circular(4),
            ),
          ),
        );
      },
    );
  }

  /// Circle skeleton - configurable diameter
  /// Use case: Avatars, icons
  static Widget circleSkeleton({double diameter = 56}) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return ShimmerContainer(
          child: Container(
            width: diameter,
            height: diameter,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  /// Screen skeleton - full screen layout
  /// Use case: Initial page load
  static Widget screenSkeleton() {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return ShimmerContainer(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header placeholder
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const Gap(AppSpacing.lg),
                // Text placeholders
                for (int i = 0; i < 3; i++) ...[
                  Container(
                    width: i == 0 ? 150 : double.infinity,
                    height: i == 0 ? 24 : 16,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Gap(AppSpacing.md),
                ],
                const Gap(AppSpacing.md),
                // Card placeholders
                for (int i = 0; i < 3; i++) ...[
                  Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const Gap(AppSpacing.md),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  /// Header skeleton - ~350px height
  /// Use case: Page headers with cover image
  static Widget headerSkeleton({double height = 350}) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return ShimmerContainer(
          child: Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Chip/Tag skeleton - rounded rectangle
  /// Use case: Time slots, filter chips
  static Widget chipSkeleton({double width = 80, double height = 36}) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return ShimmerContainer(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        );
      },
    );
  }

  /// Row of chip skeletons
  static Widget chipRowSkeleton({
    int count = 5,
    double chipWidth = 80,
    double chipHeight = 36,
    double spacing = 8,
  }) {
    return Builder(
      builder: (context) {
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(
            count,
            (index) => chipSkeleton(width: chipWidth, height: chipHeight),
          ),
        );
      },
    );
  }

  /// Button skeleton - full width rounded rectangle
  /// Use case: Loading state for CTA buttons
  static Widget buttonSkeleton({double height = 54, double borderRadius = 12}) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return ShimmerContainer(
          child: Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        );
      },
    );
  }
}
