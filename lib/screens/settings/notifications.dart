import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data/settings.dart';
import 'package:mymgs/notifications/channels.dart';
import 'package:mymgs/notifications/reminders.dart';
import 'package:mymgs/widgets/date_picker.dart';
import 'package:mymgs/widgets/settings/key_value.dart';
import 'package:mymgs/widgets/settings/toggle.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings();
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool _allowNotifications = true;
  bool _allowNews = true;
  bool _allowHomework = true;

  void _selectHomeworkTime() async {
    final currentReminderTime = await getHomeworkReminderTime();
    final selectedTime = await showDateTimePicker(
      context: context,
      mode: DateTimePickerMode.time,
      initialDateTime: DateTime(0, 0, 0, currentReminderTime[0], currentReminderTime[1]),
    );
    if (selectedTime == null) return;

    await saveSetting(
      'homework_reminder_time',
      Jiffy(selectedTime).Hm,
    );
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
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ).copyWith(bottom: 20, top: 5),
            child: Text(
              "Please note: all notification settings (including reminder times) only apply to notifications scheduled in the future.",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),

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
            description: "Notify about incomplete homework.",
            tracker: "homework_notifications",
            requirement: _allowNotifications,
            callback: (on) {
              setState(() {
                _allowHomework = on;
              });
            },
          ),
          KeyValueSetting(
            indented: true,
            name: "Time to notify",
            description: "Time the day before to send homework reminder notifications.",
            tracker: "homework_reminder_time",
            onTap: _selectHomeworkTime,
            requirement: _allowHomework,
          ),

          ToggleSetting(
            name: "Events",
            description: "Attendance reminders before events.",
            tracker: "events_notifications",
            requirement: _allowNotifications,
          ),
          ToggleSetting(
            name: "Clubs",
            description: "Attendance reminders before clubs, and related updates.",
            tracker: "clubs_notifications",
            requirement: _allowNotifications,
          ),

          ToggleSetting(
            name: "Remote",
            description: "Push notifications that maintain your anonymity.",
            tracker: "news_notifications",
            requirement: kIsWeb ? false : _allowNotifications,
            enabled: !kIsWeb,
            callback: (on) {
              setState(() {
                _allowNews = on;
              });
            },
          ),

          for (final category in MGSChannels.pubSubTopics)
            ToggleSetting(
              name: category.name,
              description: category.description,
              tracker: category.tracker,
              requirement: _allowNews,
              indented: true,
            ),
        ],
      ),
    );
  }
}
