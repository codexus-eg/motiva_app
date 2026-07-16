import 'package:flutter/material.dart';

Widget buildPlatformImageImpl({
  required String url,
  required double width,
  required double height,
  required BoxFit fit,
  required Widget placeholder,
  BorderRadius? borderRadius,
}) {
  final image = Image.network(
    url,
    width: width,
    height: height,
    fit: fit,
    errorBuilder: (_, __, ___) => placeholder,
  );

  if (borderRadius != null) {
    return ClipRRect(borderRadius: borderRadius, child: image);
  }
  return image;
}
