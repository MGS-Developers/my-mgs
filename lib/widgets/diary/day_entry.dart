import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data_classes/diary_entry.dart';

class DayEntry extends StatefulWidget {
  final Future<void> Function(int _index) deleteHomework;
  final Future<void> Function(int _index) toggleHomework;
  final List<SubjectEntry> subjectEntries;
  const DayEntry({
    required this.deleteHomework,
    required this.subjectEntries,
    required this.toggleHomework,
  });

  _DayEntryState createState() => _DayEntryState();
}

class _DayEntryState extends State<DayEntry> {
  late List<int> expandedIndexes;

  @override
  void initState() {
    expandedIndexes = [];
    super.initState();
  }

  void _setExpanded(int index, bool expanded) {
    setState(() {
      if (expanded) {
        expandedIndexes.remove(index);
      } else {
        expandedIndexes.add(index);
      }
    });
  }

  void _showEntryMenu(MapEntry<int, SubjectEntry> entry) {
    showPlatformDialog(
      context: context,
      materialBarrierColor: Theme.of(context).shadowColor,
      builder: (BuildContext context) => PlatformAlertDialog(
        title: Text(entry.value.subject),
        actions: [
          PlatformDialogAction(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              }
          ),
          PlatformDialogAction(
              child: Text("Delete"),
              onPressed: () {
                widget.deleteHomework(entry.key);
                Navigator.of(context).pop();
              }
          ),
        ],
      ),
    );
  }

  void _toggleComplete(MapEntry<int, SubjectEntry> entry) async {
    await widget.toggleHomework(entry.key);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: _setExpanded,
        children: widget.subjectEntries.asMap().entries.map((entry) {
          final homeworkText = entry.value.homework;

          return ExpansionPanel(
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, _) => ListTile(
              title: Text(
                entry.value.subject,
                style: entry.value.complete ? TextStyle(
                  color: MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.black54 : Colors.white70,
                  decoration: TextDecoration.lineThrough,
                ) : null,
              ),
              onLongPress: () {
                _showEntryMenu(entry);
              },
              onTap: () {
                _setExpanded(entry.key, expandedIndexes.contains(entry.key));
              },
            ),
            isExpanded: expandedIndexes.contains(entry.key),
            body: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (homeworkText != null) Text(
                    homeworkText,
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Due: " + Jiffy(entry.value.dueDate).yMMMEd,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  OutlinedButton(
                    onPressed: () {
                      _toggleComplete(entry);
                    },
                    child: Text(
                        entry.value.complete ? "Mark incomplete" : "Mark complete"
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}