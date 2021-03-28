import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mymgs/helpers/deep_link.dart';
import 'package:mymgs/notifications/channels.dart';
import 'package:mymgs/notifications/permissions.dart';
import 'package:mymgs/notifications/scoping.dart';

final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final _scoping = NotificationScoping();

Future<void> pushHandler(RemoteMessage message) async {
  if (!(await isNotificationAllowed("news"))) return;

  final data = message.data;
  final String? title = data["title"];
  final String? body = data["body"];
  final String? imageUrl = data["imageUrl"];
  final String? topic = data["topic"];
  final String? resource = data["resourceType"];
  final String? id = data["resourceId"];
  final String? scope = data["scope"];

  if (!(await isPushTopicAllowed(topic))) return;
  if (title == null || body == null) return;

  if (scope != null) {
    final scopeAllowed = await _scoping.isScopeAllowed(scope);
    if (!scopeAllowed) {
      return;
    }
  }

  String? deepLinkString;
  if (resource != null && id != null) {
    final deepLink = DeepLink(DeepLinkResource.values[int.parse(resource)], id);
    deepLinkString = deepLink.toPayloadString();
  }

  _flutterLocalNotificationsPlugin.show(
    Random().nextInt(10000),
    title,
    body,
    await MGSChannels.news(imageUrl, body),
    payload: deepLinkString,
  );
}
