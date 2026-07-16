import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemUiWrapper extends StatelessWidget {
  final Widget child;
  final Color? statusBarColor;

  const SystemUiWrapper({
    super.key,
    required this.child,
    this.statusBarColor,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = statusBarColor ?? Theme.of(context).scaffoldBackgroundColor;
    final isDark = ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light, // iOS
        systemNavigationBarColor: backgroundColor,
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
      child: child,
    );
  }
}