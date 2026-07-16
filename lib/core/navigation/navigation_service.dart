import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static NavigatorState? get navigator => navigatorKey.currentState;

  static Future<T?> push<T>(Widget page) {
    if (navigator == null) return Future.value();
    return navigator!.push<T>(MaterialPageRoute(builder: (_) => page));
  }

  static Future<T?> pushAndRemoveUntil<T>(Widget page) {
    if (navigator == null) return Future.value();
    return navigator!.pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  static void pop<T>([T? result]) {
    navigator?.pop<T>(result);
  }

  static void popUntil(bool Function(Route<dynamic>) predicate) {
    navigator?.popUntil(predicate);
  }
}
