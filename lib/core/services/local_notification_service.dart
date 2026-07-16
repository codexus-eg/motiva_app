import 'package:app/core/navigation/navigation_service.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class LocalNotificationService {
  // static void showBasicNotification(RemoteMessage message) async {
  //   final context = NavigationService.navigatorKey.currentContext;
  //   if (context == null) return;
  //   final theme = Theme.of(context);
  // 
  //   toastification.show(
  //     type: ToastificationType.success,
  //     style: ToastificationStyle.flat,
  //     autoCloseDuration: const Duration(seconds: 5),
  //     title: Text(message.notification?.title ?? ''),
  //     description: RichText(
  //       text: TextSpan(text: message.notification?.body ?? ''),
  //     ),
  //     alignment: Alignment.topRight,
  //     direction: TextDirection.ltr,
  //     animationDuration: const Duration(milliseconds: 300),
  //     animationBuilder: (context, animation, alignment, child) {
  //       return FadeTransition(opacity: animation, child: child);
  //     },
  //     showIcon: false,
  //     backgroundColor: theme.colorScheme.surface,
  //     foregroundColor: theme.colorScheme.onSurface,
  //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
  //     margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //     borderRadius: BorderRadius.circular(12),
  //     showProgressBar: true,
  //     closeOnClick: false,
  //     pauseOnHover: true,
  //     dragToClose: true,
  //     applyBlurEffect: true,
  //     onHoverMouseCursor: SystemMouseCursors.click,
  //   );
  // }
}
