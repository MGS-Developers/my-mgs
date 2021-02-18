import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mymgs/notifications/channels.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void scheduleReminder(int id, {
  @required String title,
  @required String subtitle,
  @required NotificationDetails notificationDetails,
  @required DateTime when,
}) {
  tz.initializeTimeZones();
  final location = tz.getLocation("Europe/London");
  tz.setLocalLocation(location);

  final scheduleTime = tz.TZDateTime.from(when, location);
  if (scheduleTime.isBefore(tz.TZDateTime.now(location))) {
    return;
  }

  flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    subtitle,
    scheduleTime,
    notificationDetails,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
  );
}

void cancelReminder(int id) {
  flutterLocalNotificationsPlugin.cancel(id);
}