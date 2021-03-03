import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mymgs/data/settings.dart';
import 'package:mymgs/notifications/channels.dart';

final _firebaseMessaging = FirebaseMessaging();

Future<bool> isNotificationAllowed(String groupId) async {
  final response = await getSetting<bool>(groupId + "_notifications");
  if (response == null) {
    return false;
  } else {
    return response;
  }
}

Future<bool> isPushTopicAllowed(String topic) async {
  final response = await getSetting<bool>(topic + "_push_notifications");
  if (response == null) {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    return false;
  } else {
    if (response == false) await _firebaseMessaging.unsubscribeFromTopic(topic);
    return response;
  }
}

Future<void> allowAllNotifications() async {
  for (final channel in MGSChannels.channels) {
    await saveSetting(channel + "_notifications", true);
  }

  for (final topic in MGSChannels.pubSubTopics) {
    await saveSetting(topic + "_push_notifications", true);
    await _firebaseMessaging.subscribeToTopic(topic);
  }
}
