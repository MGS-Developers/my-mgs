import 'package:flutter/material.dart';
import 'package:mymgs/data_classes/diary_entry.dart';
import 'package:mymgs/widgets/diary/homework_entry.dart';

class DayEntry extends StatelessWidget {
  final Future<void> Function(int _index) deleteHomework;
  final Future<void> Function(int _index) toggleHomework;
  final List<SubjectEntry> subjectEntries;
  const DayEntry({
    required this.deleteHomework,
    required this.subjectEntries,
    required this.toggleHomework,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: subjectEntries.asMap().map((key, _subjectEntry) {
          return MapEntry(
            key,
            HomeworkEntry(
              subjectEntry: _subjectEntry,
              toggle: () {
                return toggleHomework(key);
              },
              delete: () {
                return deleteHomework(key);
              },
            ),
          );
        }).values.toList(),
      )
    );
  }
}
