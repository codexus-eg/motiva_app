import 'package:app/core/utils/app_logger.dart';
import 'package:app/core/utils/constants.dart';
import 'package:app/shared/ui/images/platform_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Skeleton placeholder for images during loading state
class SkeletonImage extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  const SkeletonImage({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    final shimmerBaseColor = baseColor ?? const Color(0xFF2B2C33);
    final shimmerHighlightColor = highlightColor ?? const Color(0xFF3A3B42);

    Widget child = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: shimmerBaseColor,
        borderRadius: borderRadius,
      ),
    );

    return Shimmer.fromColors(
      baseColor: shimmerBaseColor,
      highlightColor: shimmerHighlightColor,
      child: borderRadius != null
          ? ClipRRect(borderRadius: borderRadius!, child: child)
          : child,
    );
  }
}

class NetworkImageWidget extends StatelessWidget {
  final String? imageUrl;
  final String fallbackAsset;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final bool useSkeletonPlaceholder;

  /// Cache dimensions for 2x display density optimization
  static const int cacheWidth = 640;
  static const int cacheHeight = 640;

  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    required this.fallbackAsset,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.backgroundColor,
    this.useSkeletonPlaceholder = false,
  });

  String _resolveImageUrl(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }
    final baseUrl = ApiConstants.baseUrl;
    final normalizedPath = url.startsWith('/') ? url : '/$url';
    return '$baseUrl$normalizedPath';
  }

  String _getEffectiveUrl() {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return '';
    }
    if (imageUrl!.startsWith('assets/')) {
      return '';
    }
    return _resolveImageUrl(imageUrl!);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveUrl = _getEffectiveUrl();

    if (effectiveUrl.isEmpty) {
      return _buildAssetImage();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final resolvedWidth = width ?? constraints.maxWidth;
        final resolvedHeight = height ?? constraints.maxHeight;

        if (resolvedWidth.isFinite &&
            resolvedHeight.isFinite &&
            resolvedWidth > 0 &&
            resolvedHeight > 0) {
          return buildPlatformImage(
            url: effectiveUrl,
            width: resolvedWidth,
            height: resolvedHeight,
            fit: fit,
            placeholder: _buildAssetImage(),
            borderRadius: borderRadius,
          );
        }

        return _buildNetworkImage(effectiveUrl);
      },
    );
  }

  Widget _buildNetworkImage(String effectiveUrl) {
    // Use skeleton placeholder if enabled, otherwise simple loading indicator
    Widget loadingWidget;
    if (useSkeletonPlaceholder) {
      loadingWidget = SkeletonImage(
        width: width,
        height: height,
        borderRadius: borderRadius,
      );
    } else {
      loadingWidget = Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? const Color(0xFF2B2C33),
          borderRadius: borderRadius,
        ),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: const Color(0xFFE28C37),
            ),
          ),
        ),
      );
    }

    final image = Image.network(
      effectiveUrl,
      fit: fit,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      errorBuilder: (context, error, stackTrace) {
        AppLogger.error(
          'Failed to load network image: $effectiveUrl',
          error: error,
          stackTrace: stackTrace,
        );
        return _buildAssetImage();
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return loadingWidget;
      },
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: SizedBox(width: width, height: height, child: image),
      );
    }

    return SizedBox(width: width, height: height, child: image);
  }

  Widget _buildAssetImage() {
    final image = Image.asset(
      fallbackAsset,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        AppLogger.error(
          'Failed to load fallback asset: $fallbackAsset',
          error: error,
          stackTrace: stackTrace,
        );
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor ?? const Color(0xFF2B2C33),
            borderRadius: borderRadius,
          ),
          child: Icon(
            Icons.image_not_supported,
            color: Colors.white54,
            size: (width != null && height != null)
                ? ((width! + height!) / 2) * 0.3
                : 32,
          ),
        );
      },
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: SizedBox(width: width, height: height, child: image),
      );
    }

    return SizedBox(width: width, height: height, child: image);
  }
}

class CircleNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final String fallbackAsset;
  final double radius;
  final Color? backgroundColor;
  final String? placeholderText;

  const CircleNetworkImage({
    super.key,
    required this.imageUrl,
    required this.fallbackAsset,
    required this.radius,
    this.backgroundColor,
    this.placeholderText,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? const Color(0xFFE28C37);

    final isAssetPath = imageUrl != null && imageUrl!.startsWith('assets/');

    if (imageUrl == null || imageUrl!.isEmpty || isAssetPath) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: bgColor,
        child: placeholderText != null
            ? Text(
                placeholderText!,
                style: TextStyle(
                  fontSize: radius * 0.8,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            : ClipOval(
                child: Image.asset(
                  isAssetPath ? imageUrl! : fallbackAsset,
                  fit: BoxFit.cover,
                  width: radius * 2,
                  height: radius * 2,
                  errorBuilder: (_, _, _) =>
                      Icon(Icons.person, size: radius, color: Colors.white),
                ),
              ),
      );
    }

    final effectiveUrl =
        imageUrl!.startsWith('http://') || imageUrl!.startsWith('https://')
        ? imageUrl!
        : '${ApiConstants.baseUrl}${imageUrl!.startsWith('/') ? '' : '/'}$imageUrl';

    return CircleAvatar(
      radius: radius,
      backgroundColor: bgColor,
      backgroundImage: NetworkImage(effectiveUrl),
      onBackgroundImageError: (exception, stackTrace) {
        AppLogger.error(
          'Failed to load circle avatar image: $effectiveUrl',
          error: exception,
          stackTrace: stackTrace,
        );
      },
      child: placeholderText != null
          ? Text(
              placeholderText!,
              style: TextStyle(
                fontSize: radius * 0.8,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
