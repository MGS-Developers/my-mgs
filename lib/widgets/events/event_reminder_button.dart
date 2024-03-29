import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/analytics.dart';
import 'package:mymgs/data_classes/event.dart';
import 'package:mymgs/helpers/class_serializers.dart';
import 'package:mymgs/notifications/channels.dart';
import 'package:mymgs/notifications/permissions.dart';
import 'package:mymgs/notifications/reminders.dart';
import 'package:mymgs/notifications/scoping.dart';
import 'package:mymgs/screens/settings/notifications.dart';
import 'package:mymgs/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _scoping = NotificationScoping();

class EventReminderButton extends StatefulWidget {
  final Event event;
  const EventReminderButton({
    required this.event,
  });

  _EventReminderButtonState createState() => _EventReminderButtonState();
}

class _EventReminderButtonState extends State<EventReminderButton> {
  bool reminderScheduled = false;

  void _getReminderSet() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final _reminderScheduled = sharedPreferences.getBool("reminder-${widget.event.id}");

    if (_reminderScheduled != null && _reminderScheduled) {
      setState(() {
        reminderScheduled = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getReminderSet();
  }

  void _toggleReminder() async {
    if (!(await isNotificationAllowed("events"))) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please allow event notifications"),
        action: SnackBarAction(
          label: "Configure",
          onPressed: () {
            Navigator.of(context).push(platformPageRoute(
              context: context,
              builder: (_) => NotificationSettings(),
            ));
          },
        ),
      ));
      return;
    }

    setState(() {
      reminderScheduled = !reminderScheduled;
    });

    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool("reminder-${widget.event.id}", reminderScheduled);

    final id = stringToInt(widget.event.id);

    if (reminderScheduled) {
      scheduleReminder(
        id,
        title: "Event starting soon!",
        subtitle: MGSChannels.eventReminderDetails(widget.event),
        notificationDetails: MGSChannels.event(widget.event),
        when: widget.event.startTime.toDate().subtract(Duration(minutes: 30)),
      );

      await _scoping.subscribeToScope(widget.event);
      await AnalyticsEvents.eventRemind(widget.event.id);
    } else {
      cancelReminder(id);
      await _scoping.unsubscribeFromScope(widget.event);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: MGSButton(
        onPressed: _toggleReminder,
        label: reminderScheduled ? 'Cancel reminder' : 'Remind me!',
      )
    );
  }
}