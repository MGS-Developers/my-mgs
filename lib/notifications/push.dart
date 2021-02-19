import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mymgs/notifications/channels.dart';
import 'package:mymgs/notifications/permissions.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> pushHandler(Map<String, dynamic> message) async {
  if (!(await isNotificationAllowed("news"))) return;

  final String title = message["title"];
  final String body = message["body"];
  final String imageUrl = message["imageUrl"];

  if (title == null || body == null) return;

  flutterLocalNotificationsPlugin.show(
    Random().nextInt(10000),
    title,
    body,
    await MGSChannels.news(imageUrl),
  );
}
