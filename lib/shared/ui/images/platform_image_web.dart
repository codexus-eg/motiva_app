import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

Widget buildPlatformImageImpl({
  required String url,
  required double width,
  required double height,
  required BoxFit fit,
  required Widget placeholder,
  BorderRadius? borderRadius,
}) {
  return _WebImage(
    url: url,
    width: width,
    height: height,
    fit: fit,
    placeholder: placeholder,
    borderRadius: borderRadius,
  );
}

class _WebImage extends StatefulWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget placeholder;
  final BorderRadius? borderRadius;

  const _WebImage({
    required this.url,
    required this.width,
    required this.height,
    required this.fit,
    required this.placeholder,
    this.borderRadius,
  });

  @override
  State<_WebImage> createState() => _WebImageState();
}

class _WebImageState extends State<_WebImage> {
  late final String _viewType;
  bool _hasError = false;

  static int _counter = 0;

  @override
  void initState() {
    super.initState();
    _viewType = 'web-img-${widget.url.hashCode}-${++_counter}';
    _register();
  }

  void _register() {
    // ignore: undefined_prefixed_name
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      final element = html.ImageElement()
        ..src = widget.url
        ..style.width = '100%'
        ..style.height = '100%';

      final objectFit = switch (widget.fit) {
        BoxFit.cover => 'cover',
        BoxFit.contain => 'contain',
        BoxFit.fill => 'fill',
        BoxFit.fitWidth => 'contain',
        BoxFit.fitHeight => 'contain',
        _ => 'cover',
      };
      element.style.objectFit = objectFit;

      if (widget.borderRadius != null) {
        final r = widget.borderRadius!;
        element.style.borderRadius =
            '${r.topLeft.x}px ${r.topRight.x}px ${r.bottomRight.x}px ${r.bottomLeft.x}px';
      }

      element.onError.listen((_) {
        if (mounted) {
          setState(() => _hasError = true);
        }
      });

      return element;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: widget.placeholder,
      );
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: HtmlElementView(viewType: _viewType),
    );
  }
}
