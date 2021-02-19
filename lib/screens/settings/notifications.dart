import 'package:flutter/material.dart';
import 'package:mymgs/notifications/permissions.dart';
import 'package:mymgs/widgets/settings/toggle.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings();
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool _allowNotifications = false;

  @override
  void initState() {
    allowAllNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 15
        ),
        children: [
          ToggleSetting(
            name: "Allow notifications",
            tracker: "allow_notifications",
            callback: (on) {
              setState(() {
                _allowNotifications = on;
              });
            }
          ),
          ToggleSetting(
            name: "Homework",
            description: "Notify about incomplete homework the night before",
            tracker: "homework_notifications",
            requirement: _allowNotifications,
          ),
          ToggleSetting(
            name: "Events",
            description: "Attendance reminders before events",
            tracker: "event_notifications",
            requirement: _allowNotifications,
          ),
          ToggleSetting(
            name: "News",
            description: "Updates from the School Council",
            tracker: "news_notifications",
            requirement: _allowNotifications,
          ),
        ],
      ),
    );
  }
}