import 'package:app/core/utils/app_logger.dart';
import 'package:app/core/utils/constants.dart';
import 'package:flutter/material.dart';

class CoverImageWidget extends StatelessWidget {
  final String? imageUrl;
  final String fallbackAsset;
  final double height;
  final double? width;
  final BoxFit fit;
  final Color? gradientColor;
  final double gradientOpacity;
  final Widget? overlay;
  final BorderRadius? borderRadius;

  const CoverImageWidget({
    super.key,
    required this.imageUrl,
    required this.fallbackAsset,
    this.height = 300,
    this.width,
    this.fit = BoxFit.cover,
    this.gradientColor = Colors.black,
    this.gradientOpacity = 0.3,
    this.overlay,
    this.borderRadius,
  });

  String _resolveImageUrl(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }
    final baseUrl = ApiConstants.baseUrl;
    final normalizedPath = url.startsWith('/') ? url : '/$url';
    return '$baseUrl$normalizedPath';
  }

  @override
  Widget build(BuildContext context) {
    final effectiveUrl = (imageUrl != null && imageUrl!.isNotEmpty)
        ? _resolveImageUrl(imageUrl!)
        : null;

    Widget imageWidget;

    if (effectiveUrl != null) {
      imageWidget = Image.network(
        effectiveUrl,
        fit: fit,
        height: height,
        width: width,
        errorBuilder: (context, error, stackTrace) {
          AppLogger.error(
            'Failed to load cover image: $effectiveUrl',
            error: error,
            stackTrace: stackTrace,
          );
          return _buildFallbackImage();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: const Color(0xFF2B2C33),
              borderRadius: borderRadius,
            ),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
                color: const Color(0xFFE28C37),
              ),
            ),
          );
        },
      );
    } else {
      imageWidget = _buildFallbackImage();
    }

    final stackChildren = [
      Positioned.fill(child: imageWidget),
      if (gradientOpacity > 0)
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  (gradientColor ?? Colors.black).withValues(
                    alpha: gradientOpacity * 0.5,
                  ),
                  (gradientColor ?? Colors.black).withValues(alpha: gradientOpacity),
                ],
              ),
            ),
          ),
        ),
      if (overlay != null) Positioned.fill(child: overlay!),
    ];

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: SizedBox(
          height: height,
          width: width,
          child: Stack(fit: StackFit.expand, children: stackChildren),
        ),
      );
    }

    return SizedBox(
      height: height,
      width: width,
      child: Stack(fit: StackFit.expand, children: stackChildren),
    );
  }

  Widget _buildFallbackImage() {
    return Image.asset(
      fallbackAsset,
      fit: fit,
      height: height,
      width: width,
      errorBuilder: (context, error, stackTrace) {
        AppLogger.error(
          'Failed to load fallback asset: $fallbackAsset',
          error: error,
          stackTrace: stackTrace,
        );
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: const Color(0xFF2B2C33),
            borderRadius: borderRadius,
          ),
          child: const Center(
            child: Icon(
              Icons.image_not_supported,
              color: Colors.white54,
              size: 48,
            ),
          ),
        );
      },
    );
  }
}
