import 'dart:developer';

// import 'package:app/core/services/local_notification_service.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  // static final FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    log("NotificationService.init() called: Firebase is disabled for App Store upload.");
    // await messaging.requestPermission();
    // try {
    //   String? token = await messaging.getToken();
    //   log("Token: $token");
    // } catch (e) {
    //   log("Error getting token: $e");
    // }
    // FirebaseMessaging.onBackgroundMessage(handlerBackgroundMessage);
    // handlerForegroundMessage();
  }

  // static Future<void> handlerBackgroundMessage(RemoteMessage message) async {
  //   await Firebase.initializeApp();
  //   log(message.notification?.title ?? 'null');
  // }

  // static void handlerForegroundMessage() {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     LocalNotificationService.showBasicNotification(message);
  //   });
  // }
}
