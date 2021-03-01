import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data_classes/event.dart';
import 'package:mymgs/helpers/app_metadata.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

Future<String> _downloadImage(String url) async {
  final directory = await getTemporaryDirectory();
  final fileName = Uuid().v4();
  final path = '${directory.path}/$fileName.jpg';

  final response = await http.get(url);

  final file = File(path);
  await file.writeAsBytes(response.bodyBytes);
  return path;
}

class MGSChannels {
  static final channels = [
    "homework",
    "events",
    "news",
  ];

  static final pubSubTopics = [
    "school_council",
    "event_ads",
    "club_ads",
  ];

  static NotificationDetails homework({
    String subject,
    String homework,
  }) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        "homework",
        "Homework",
        "Reminds you about unfinished homework the night before.",
        importance: Importance.max,
        styleInformation: BigTextStyleInformation(
          homework,
          summaryText: "Incomplete homework",
        ),
      ),
    );
  }

  static Future<NotificationDetails> news([String image, String body]) async {
    StyleInformation styleInformation;
    IOSNotificationAttachment notificationAttachment;
    if (image != null) {
      final imagePath = await _downloadImage(image);
      styleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(imagePath),
        largeIcon: FilePathAndroidBitmap(imagePath),
        hideExpandedLargeIcon: true,
      );
      notificationAttachment = IOSNotificationAttachment(imagePath);
    } else if (body != null) {
      styleInformation = BigTextStyleInformation(body);
    }

    return NotificationDetails(
      android: AndroidNotificationDetails(
        "news",
        "News",
        "Updates and advertisements from the School Council. Open " + appName + " to customise.",
        importance: Importance.max,
        styleInformation: styleInformation,
      ),
      iOS: IOSNotificationDetails(
        attachments: notificationAttachment != null ? [notificationAttachment] : null,
      ),
    );
  }

  static String eventReminderDetails(Event event) {
    return "${event.title} — ${event.location} — ${Jiffy(event.startTime.toDate()).jm}";
  }

  static NotificationDetails event(Event event) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        "events",
        "Events",
        "Reminders for events you selected.",
        importance: Importance.max,
        styleInformation: BigTextStyleInformation(eventReminderDetails(event)),
      ),
    );
  }
}

