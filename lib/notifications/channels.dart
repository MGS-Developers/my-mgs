import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

  static Future<NotificationDetails> news([String image]) async {
    BigPictureStyleInformation styleInformation;
    IOSNotificationAttachment notificationAttachment;
    if (image != null) {
      final imagePath = await _downloadImage(image);
      styleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(imagePath),
      );
      notificationAttachment = IOSNotificationAttachment(imagePath);
    }

    return NotificationDetails(
      android: AndroidNotificationDetails(
        "news",
        "News",
        "Updates and advertisements from the School Council.",
        importance: Importance.max,
        styleInformation: styleInformation,
      ),
      iOS: IOSNotificationDetails(
        attachments: notificationAttachment != null ? [notificationAttachment] : null,
      ),
    );
  }
}
