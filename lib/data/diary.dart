import 'dart:async';
import 'dart:convert';

import 'package:mymgs/data/local_database.dart';
import 'package:mymgs/data_classes/diary_entry.dart';
import 'package:mymgs/notifications/channels.dart';
import 'package:mymgs/notifications/permissions.dart';
import 'package:mymgs/notifications/reminders.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _dayToKey(DateTime date) {
  return date.year.toString() + "-" + date.month.toString() + "-" + date.day.toString();
}

String _stringify(DiaryEntry diaryEntry) {
  return jsonEncode(diaryEntry.toJson());
}

DiaryEntry _parse(String entry) {
  if (entry == null) {
    return DiaryEntry()
      ..subjectEntries = [];
  }

  return DiaryEntry.fromJson(jsonDecode(entry));
}

Future<DiaryEntry> _getEntryForDay(DateTime date) async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final existingEntry = _parse(sharedPreferences.getString(_dayToKey(date)));
  if (existingEntry == null) {
    return DiaryEntry()
      ..day = date
      ..subjectEntries = [];
  } else {
    return existingEntry;
  }
}

class DiaryEntryController {
  TransformedStreamController<DiaryEntry> streamController;
  DateTime date;

  DiaryEntryController(this.date);

  void dispose() {
    streamController.dispose();
  }

  Future<void> write(DiaryEntry newEntry) async {
    return set(_dayToKey(date), newEntry, _stringify);
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
  diaryEntryController.streamController = watch<DiaryEntry>(
      _dayToKey(day),
      parser: _parse,
      placeholderValue: DiaryEntry()
        ..day = day
        ..subjectEntries = []
  );
  return diaryEntryController;
}