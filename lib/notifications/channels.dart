import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data_classes/club.dart';
import 'package:mymgs/data_classes/event.dart';
import 'package:mymgs/helpers/app_metadata.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

Future<String> _downloadImage(String url) async {
  final directory = await getTemporaryDirectory();
  final fileName = Uuid().v4();
  final path = '${directory.path}/$fileName.jpg';

  final response = await http.get(Uri.parse(url));

  final file = File(path);
  await file.writeAsBytes(response.bodyBytes);
  return path;
}

class _RemoteNotificationCategory {
  final String name;
  final String description;
  final String id;

  const _RemoteNotificationCategory(this.name, this.description, this.id);

  String get tracker {
    return id + "_push_notifications";
  }
}

class MGSChannels {
  static const channels = [
    "homework",
    "events",
    "news",
    "clubs",
  ];

  static const pubSubTopics = <_RemoteNotificationCategory>[
    _RemoteNotificationCategory("Updates", "News & messages from the School Council", "school_council"),
    _RemoteNotificationCategory("Club ads", "Personalised club recommendations", "club_ads"),
    _RemoteNotificationCategory("Event ads", "Personalised event/talk recommendations", "event_ads"),
    _RemoteNotificationCategory("Lost property", "Requests for lost items in your year group", "lost_property"),
    _RemoteNotificationCategory("Behaviour reminders", "Messages from HoYs about behaviour", "behaviour"),
    _RemoteNotificationCategory("Academic", "Messages about your subjects and exams", "academic"),
  ];

  static NotificationDetails homework({
    required String subject,
    required String homework,
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

  static Future<NotificationDetails> news([String? image, String? body]) async {
    StyleInformation styleInformation;
    IOSNotificationAttachment? notificationAttachment;
    if (image != null) {
      final imagePath = await _downloadImage(image);
      styleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(imagePath),
        largeIcon: FilePathAndroidBitmap(imagePath),
        hideExpandedLargeIcon: true,
      );
      notificationAttachment = IOSNotificationAttachment(imagePath);
    } else {
      styleInformation = BigTextStyleInformation(body!);
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

  static String clubReminderDetails(Club club) {
    return "${club.name} — ${club.location} — ${Jiffy(DateTime(0, 0, 0, club.time.time.hour, club.time.time.minute)).jm}";
  }

  static NotificationDetails club(Club club) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        "clubs",
        "Clubs",
        "Recurring reminders and news from clubs you're subscribed to.",
        importance: Importance.max,
        styleInformation: BigTextStyleInformation(clubReminderDetails(club)),
      ),
    );
  }
}

