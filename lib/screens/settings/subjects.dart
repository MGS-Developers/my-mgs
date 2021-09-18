import 'package:flutter/material.dart';
import 'package:mymgs/data/settings.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/widgets/diary/select_subject.dart';

class SelectSubjects extends StatefulWidget {
  const SelectSubjects();
  _SelectSubjectsState createState() => _SelectSubjectsState();
}

class _SelectSubjectsState extends State<SelectSubjects> {
  final stream = watchSetting<List?>('subjects');

  Future<List> _get() async {
    final existingValue = await getSetting<List?>('subjects');
    if (existingValue != null) {
      return List.from(existingValue);
    } else {
      return [];
    }
  }

  void _push(String subject) async {
    final currentValue = await _get();
    currentValue.add(subject);
    await saveSetting('subjects', currentValue);
  }

  void _remove(String subject) async {
    final currentValue = await _get();
    currentValue.remove(subject);
    await saveSetting('subjects', currentValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select subjects"),
      ),
      body: StreamBuilder<List?>(
        stream: stream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];
          final subjects = SUBJECTS.where((s) => s != "Other...");

          bool isSelected(int index) {
            if (index < 0) {
              return false;
            }

            if (index >= subjects.length) {
              return false;
            }

            return data.contains(subjects.elementAt(index));
          }

          final radius = Radius.circular(20);
          final zero = Radius.zero;

          return ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive(context).horizontalListPadding,
              vertical: 20,
            ),
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final subject = subjects.elementAt(index);
              final selected = data.contains(subject);

              final previousSelected = isSelected(index - 1);
              final nextSelected = isSelected(index + 1);

              return ListTile(
                title: Text(
                  subject,
                  style: TextStyle(
                    color: selected ? Colors.white : null,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: selected ? BorderRadius.only(
                    topLeft: previousSelected ? zero : radius,
                    topRight: previousSelected ? zero : radius,
                    bottomLeft: nextSelected ? zero : radius,
                    bottomRight: nextSelected ? zero : radius,
                  ) : BorderRadius.circular(20),
                ),
                tileColor: selected ? Theme.of(context).colorScheme.primary : null,
                onTap: () {
                  if (selected) {
                    _remove(subject);
                  } else {
                    _push(subject);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
