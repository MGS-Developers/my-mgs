import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
const androidInitializationSettings = AndroidInitializationSettings('ic_launcher');
const iosInitializationSettings = IOSInitializationSettings();
const InitializationSettings initializationSettings = InitializationSettings(
  android: androidInitializationSettings,
  iOS: iosInitializationSettings,
);

Future<void> setupNotifications() async {
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  print("init complete");
}
