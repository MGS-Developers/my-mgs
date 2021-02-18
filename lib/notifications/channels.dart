import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MGSChannels {
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
}

