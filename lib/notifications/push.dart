import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mymgs/helpers/deep_link.dart';
import 'package:mymgs/notifications/channels.dart';
import 'package:mymgs/notifications/permissions.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> pushHandler(Map<String, dynamic> message) async {
  if (!(await isNotificationAllowed("news"))) return;

  final data = message["data"];
  final String title = data["title"];
  final String body = data["body"];
  final String imageUrl = data["imageUrl"];
  final String topic = data["topic"];
  final String resource = data["resourceType"];
  final String id = data["resourceId"];

  if (!(await isPushTopicAllowed(topic))) return;
  if (title == null || body == null) return;

  String deepLinkString;
  if (resource != null && id != null) {
    final deepLink = DeepLink(DeepLinkResource.values[int.parse(resource)], id);
    deepLinkString = deepLink.toPayloadString();
  }

  flutterLocalNotificationsPlugin.show(
    Random().nextInt(10000),
    title,
    body,
    await MGSChannels.news(imageUrl, body),
    payload: deepLinkString,
  );
}
