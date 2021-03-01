import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mymgs/helpers/deep_link.dart';
import 'package:mymgs/notifications/push.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
const androidInitializationSettings = AndroidInitializationSettings('ic_launcher');
const iosInitializationSettings = IOSInitializationSettings();
const InitializationSettings initializationSettings = InitializationSettings(
  android: androidInitializationSettings,
  iOS: iosInitializationSettings,
);

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

Future<void> setupNotifications() async {
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (payload) async {
      // ignore: close_sinks
      final controller = getLinkController();
      final deepLink = DeepLink.fromPayloadString(payload);
      if (deepLink != null) {
        controller.add(deepLink);
      }
    }
  );

  _firebaseMessaging.configure(
    onMessage: pushHandler,
    onBackgroundMessage: pushHandler,
  );
}
