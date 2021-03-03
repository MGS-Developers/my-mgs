import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mymgs/data/local_database.dart';
import 'package:sembast/sembast.dart';

final _firebaseMessaging = FirebaseMessaging();
final store = StoreRef<String, dynamic>('settings');

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

  final db = await getDb();
  await store.record(key).put(db, value);
}

Stream<T> watchSetting<T>(String key) async* {
  final db = await getDb();
  yield* store.record(key).onSnapshot(db).map((event) => event?.value);
}

Future<T> getSetting<T>(String key) async {
  final db = await getDb();
  final value = await store.record(key).get(db);
  return value as T;
}

final _signOutController = StreamController<bool>();
void signOutNotify() {
  _signOutController.add(true);
}

StreamSubscription<bool> listenToSignOut(void Function() callback) {
  return _signOutController.stream.listen((event) {
    if (event == true) {
      callback();
    }
  });
}
