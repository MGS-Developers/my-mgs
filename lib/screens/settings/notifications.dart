import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mymgs/widgets/settings/toggle.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings();
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool _allowNotifications = false;
  bool _allowNews = false;

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
            tracker: "events_notifications",
            requirement: _allowNotifications,
          ),
          ToggleSetting(
            name: "Remote",
            description: "Push notifications",
            tracker: "news_notifications",
            requirement: kIsWeb ? false : _allowNotifications,
            enabled: !kIsWeb,
            callback: (on) {
              setState(() {
                _allowNews = on;
              });
            },
          ),
          ToggleSetting(
            name: "Updates",
            description: "News & messages from the School Council",
            tracker: "school_council_push_notifications",
            requirement: _allowNews,
            indented: true,
          ),
          ToggleSetting(
            name: "Club ads",
            description: "Personalised club recommendations",
            tracker: "club_ads_push_notifications",
            requirement: _allowNews,
            indented: true,
          ),
          ToggleSetting(
            name: "Event ads",
            description: "Personalised event/talk recommendations",
            tracker: "event_ads_push_notifications",
            requirement: _allowNews,
            indented: true,
          ),
        ],
      ),
    );
  }
}