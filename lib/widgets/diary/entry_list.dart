import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data/diary.dart';
import 'package:mymgs/data_classes/diary_entry.dart';
import 'package:mymgs/screens/diary/add_entry.dart';

class EntryList extends StatefulWidget {
  final DiaryEntryController diaryEntryController;
  const EntryList({
    @required this.diaryEntryController,
  });

  _EntryList createState() => _EntryList();
}

class _EntryList extends State<EntryList> {
  List<int> expandedIndexes;
  void _setExpanded(int index, bool expanded) {
    setState(() {
      if (expanded) {
        expandedIndexes.remove(index);
      } else {
        expandedIndexes.add(index);
      }
    });
  }

  @override
  void initState() {
    setState(() {
      expandedIndexes = [];
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.diaryEntryController.dispose();
    super.dispose();
  }

  void _showEntryMenu(MapEntry<int, SubjectEntry> entry) {
    showPlatformDialog(
      context: context,
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
              widget.diaryEntryController.deleteHomework(entry.key);
              Navigator.of(context).pop();
            }
          ),
        ],
      ),
    );
  }

  void _toggleComplete(MapEntry<int, SubjectEntry> entry) async {
    await widget.diaryEntryController.toggleHomework(entry.key);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DiaryEntry>(
      stream: widget.diaryEntryController.streamController.stream,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data.subjectEntries.length == 0) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  "No homework entries.",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 10),
                PlatformButton(
                  child: Text("Add new"),
                  onPressed: () {
                    Navigator.of(context).push(platformPageRoute(
                        context: context,
                        builder: (_) => AddDiaryEntry(
                          diaryEntryController: widget.diaryEntryController,
                        )
                    ));
                  },
                )
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: ExpansionPanelList(
            expansionCallback: _setExpanded,
            children: snapshot.data.subjectEntries.asMap().entries.map((entry) => ExpansionPanel(
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
                    Text(
                      entry.value.homework,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "Due: " + Jiffy(entry.value.dueDate).yMMMEd,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
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
            )).toList(),
          ),
        );
      }
    );
  }
}