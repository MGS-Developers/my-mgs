import 'dart:async';
import 'dart:convert';

import 'package:mymgs/data_classes/diary_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _dayToKey(DateTime date) {
  return date.year.toString() + "-" + date.month.toString() + "-" + date.day.toString();
}

String _stringify(DiaryEntry diaryEntry) {
  return jsonEncode(diaryEntry.toJson());
}

DiaryEntry _parse(String entry) {
  if (entry == null) {
    return null;
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
  StreamController<DiaryEntry> streamController;
  DateTime date;

  DiaryEntryController(this.date) : streamController = StreamController<DiaryEntry>();

  void dispose() {
    streamController.close();
  }

  Future<void> write(DiaryEntry newEntry) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_dayToKey(date), _stringify(newEntry));
    streamController.add(newEntry);
  }

  Future<void> addHomework({
    String subject,
    String homework,
  }) async {
    final dayEntry = await _getEntryForDay(date);
    final SubjectEntry subjectEntry = SubjectEntry()
      ..subject = subject
      ..homework = homework;

    if (dayEntry.subjectEntries == null) {
      dayEntry.subjectEntries = [];
    }

    dayEntry.subjectEntries.add(subjectEntry);
    await write(dayEntry);
  }

  Future<void> deleteHomework(int index) async {
    final dayEntry = await _getEntryForDay(date);
    dayEntry.subjectEntries.removeAt(index);
    await write(dayEntry);
  }
}

DiaryEntryController getControllerForDay(DateTime day) {
  final diaryEntryController = DiaryEntryController(day);

  final initialEntry = _getEntryForDay(day);
  if (initialEntry == null) {
    diaryEntryController.streamController.close();
    return diaryEntryController;
  }

  diaryEntryController.streamController.addStream(initialEntry.asStream());
  return diaryEntryController;
}