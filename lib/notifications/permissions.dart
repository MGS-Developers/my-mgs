import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:mymgs/data/settings.dart';
import 'package:mymgs/notifications/channels.dart';

final _firebaseMessaging = FirebaseMessaging.instance;

Future<bool> isNotificationAllowed(String groupId) async {
  final response = await getSetting<bool?>(groupId + "_notifications");
  if (response == null) {
    return false;
  } else {
    return response;
  }
}

Future<bool> isPushTopicAllowed(String? topic) async {
  if (topic == null) return false;

  final response = await getSetting<bool?>(topic + "_push_notifications");
  if (response == null) {
    if (!kIsWeb) {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
    }

    return false;
  } else {
    if (response == false && !kIsWeb) await _firebaseMessaging.unsubscribeFromTopic(topic);
    return response;
  }
}

Future<void> initialiseNotificationConfig() async {
  await saveSetting('allow_notifications', true);

  for (final channel in MGSChannels.channels) {
    await saveSetting(channel + "_notifications", true);
  }

  for (final topic in MGSChannels.pubSubTopics) {
    await saveSetting(topic + "_push_notifications", true);
    if (!kIsWeb) {
      await _firebaseMessaging.subscribeToTopic(topic);
    }
  }

  await saveSetting('homework_reminder_time', '18:00');
}
