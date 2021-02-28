import 'dart:async';

import 'package:mymgs/data_classes/diary_entry.dart';
import 'package:mymgs/notifications/channels.dart';
import 'package:mymgs/notifications/permissions.dart';
import 'package:mymgs/notifications/reminders.dart';
import 'package:sembast/sembast.dart';
import 'package:mymgs/data/local_database.dart';

final store = StoreRef<String, Map<String, dynamic>>('diary');

String _dayToKey(DateTime date) {
  return date.year.toString() + "-" + date.month.toString() + "-" + date.day.toString();
}

Future<DiaryEntry> _getEntryForDay(DateTime date) async {
  final db = await getDb();
  final rawEntry = await store.record(_dayToKey(date)).get(db);
  if (rawEntry == null) {
    return DiaryEntry()
        ..day = date
        ..subjectEntries = [];
  } else {
    return DiaryEntry.fromJson(rawEntry);
  }
}

Stream<DiaryEntry> _getStreamForDay(DateTime day) async* {
  final db = await getDb();
  yield* store.record(_dayToKey(day)).onSnapshot(db)
      .map((e) => e?.value)
      .map((e) => DiaryEntry.fromJson(e));
}

class DiaryEntryController {
  Stream<DiaryEntry> stream;
  DateTime date;

  DiaryEntryController(this.date);

  Future<void> write(DiaryEntry newEntry) async {
    final db = await getDb();
    return store.record(_dayToKey(date)).put(db, newEntry.toJson());
  }

  void _createHomeworkReminder(SubjectEntry subjectEntry) async {
    if (!(await isNotificationAllowed("homework"))) return;

    final dueDate = subjectEntry.dueDate;
    final scheduleTime = DateTime(
      dueDate.year,
      dueDate.month,
      dueDate.day - 1,
      18,
      00,
    );

    final reminderId = subjectEntry.hashCode;
    scheduleReminder(
      reminderId,
      when: scheduleTime,
      title: subjectEntry.subject + " is due tomorrow",
      subtitle: subjectEntry.homework,
      notificationDetails: MGSChannels.homework(
        subject: subjectEntry.subject,
        homework: subjectEntry.homework,
      ),
    );
  }

  void _deleteHomeworkReminder(SubjectEntry subjectEntry) {
    final reminderId = subjectEntry.hashCode;
    cancelReminder(reminderId);
  }

  Future<void> addHomework({
    String subject,
    String homework,
    DateTime dueDate,
  }) async {
    final dayEntry = await _getEntryForDay(date);
    final SubjectEntry subjectEntry = SubjectEntry()
      ..subject = subject
      ..homework = homework
      ..dueDate = dueDate;

    if (dayEntry.subjectEntries == null) {
      dayEntry.subjectEntries = [];
    }

    dayEntry.subjectEntries.add(subjectEntry);
    _createHomeworkReminder(subjectEntry);
    await write(dayEntry);
  }

  Future<void> deleteHomework(int index) async {
    final dayEntry = await _getEntryForDay(date);
    if (!dayEntry.subjectEntries.asMap().containsKey(index)) return;

    _deleteHomeworkReminder(dayEntry.subjectEntries[index]);
    dayEntry.subjectEntries.removeAt(index);
    await write(dayEntry);
  }

  Future<void> toggleHomework(int index) async {
    final dayEntry = await _getEntryForDay(date);
    if (!dayEntry.subjectEntries.asMap().containsKey(index)) return;

    if (dayEntry.subjectEntries[index].complete == null) {
      dayEntry.subjectEntries[index].complete = true;
    } else {
      dayEntry.subjectEntries[index].complete = !dayEntry.subjectEntries[index].complete;
    }

    if (dayEntry.subjectEntries[index].complete) {
      _deleteHomeworkReminder(dayEntry.subjectEntries[index]);
    } else {
      _createHomeworkReminder(dayEntry.subjectEntries[index]);
    }

    await write(dayEntry);
  }
}

DiaryEntryController getControllerForDay(DateTime day) {
  final diaryEntryController = DiaryEntryController(day);
  diaryEntryController.stream = _getStreamForDay(day);
  return diaryEntryController;
}