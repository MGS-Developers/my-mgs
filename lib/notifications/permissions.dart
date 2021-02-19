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

Future<void> allowAllNotifications() async {
  for (final channel in MGSChannels.channels) {
    await saveSetting(channel + "_notifications", true);
  }

  for (final topic in MGSChannels.pubSubTopics) {
    await _firebaseMessaging.subscribeToTopic(topic);
  }
}
