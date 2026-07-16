import 'package:flutter/material.dart';

import 'platform_image_stub.dart'
    if (dart.library.html) 'platform_image_web.dart';

/// Displays a network image using the best strategy for each platform:
/// - Mobile/Desktop: uses [Image.network]
/// - Web: uses a native <img> element to bypass CORS canvas restrictions
Widget buildPlatformImage({
  required String url,
  required double width,
  required double height,
  required BoxFit fit,
  required Widget placeholder,
  BorderRadius? borderRadius,
}) {
  return buildPlatformImageImpl(
    url: url,
    width: width,
    height: height,
    fit: fit,
    placeholder: placeholder,
    borderRadius: borderRadius,
  );
}
