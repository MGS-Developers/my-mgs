import 'package:mymgs/data/local_database.dart';
import 'package:mymgs/data_classes/sportsday/event.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/helpers/class_serializers.dart';
import 'package:mymgs/notifications/channels.dart';
import 'package:mymgs/notifications/reminders.dart';
import 'package:sembast/sembast.dart';

final store = StoreRef<String, bool>('sportsday_reminders');

class SportsDayReminders {
  static String eventId(EventGroup eventGroup, int subEvent, int yearGroup) {
    return "${eventGroup.id}-$subEvent-$yearGroup";
  }

  static Future<bool> isReminderSet(String reminderId) async {
    final db = await getDb();
    return await store.record(reminderId).get(db) ?? false;
  }

  // returns the new state of the reminder
  static Future<bool> toggleReminder(EventGroup eventGroup, Event event) async {
    final reminderId = eventId(eventGroup, event.subEvent, event.yearGroup);

    final db = await getDb();
    final isSet = await isReminderSet(reminderId);
    if (isSet) {
      await store.record(reminderId).delete(db);
      _cancelReminder(eventGroup, event);
    } else {
      await store.record(reminderId).put(db, true);
      _scheduleReminder(eventGroup, event);
    }

    return !isSet;
  }

  static void _scheduleReminder(EventGroup eventGroup, Event event) {
    final reminderId = stringToInt(eventId(eventGroup, event.subEvent, event.yearGroup));
    final timetable = event.timetable;
    if (timetable == null) return;

    scheduleReminder(reminderId,
      title: "Sports Day event in 10 minutes!",
      subtitle: MGSChannels.sportsDayReminderDetails(eventGroup, timetable),
      notificationDetails: MGSChannels.sportsDay(eventGroup, timetable),
      when: timetable.startTime.toDate().subtract(Duration(minutes: 10)),
    );
  }

  static void _cancelReminder(EventGroup eventGroup, Event event) {
    final reminderId = stringToInt(eventId(eventGroup, event.subEvent, event.yearGroup));
    cancelReminder(reminderId);
  }
}
