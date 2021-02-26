import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mymgs/data/local_database.dart';

final _firebaseMessaging = FirebaseMessaging();

Future<void> saveSetting(String key, dynamic value) async {
  if (value is bool) {
    if (key.endsWith("push_notifications")) {
      final topicName = key.replaceFirst('_push_notifications', '');
      if (value) {
        await _firebaseMessaging.subscribeToTopic(topicName);
      } else {
        await _firebaseMessaging.unsubscribeFromTopic(topicName);
      }
    }
  }
  await set(key, value);
}

TransformedStreamController<T> watchSetting<T>(String key) {
  return watch<T>(key);
}

Future<T> getSetting<T>(String key) async {
  return get<T>(key);
}