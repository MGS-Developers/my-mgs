import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/diary.dart';
import 'package:mymgs/data_classes/diary_entry.dart';
import 'package:mymgs/screens/diary/add_entry.dart';
import 'package:mymgs/widgets/button.dart';
import 'package:mymgs/widgets/diary/day_entry.dart';

class EntryList extends StatefulWidget {
  final DiaryEntryController diaryEntryController;
  // When false, hides 'Add new' button and illustration
  final bool isExpanded;
  const EntryList({
    required this.diaryEntryController,
    this.isExpanded = true,
  });

  _EntryList createState() => _EntryList();
}

class _EntryList extends State<EntryList> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DiaryEntry>(
      stream: widget.diaryEntryController.stream,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }

        final data = snapshot.data;

        if (snapshot.hasError || data == null || data.subjectEntries.length == 0) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                if (widget.isExpanded) const Image(
                  image: AssetImage("assets/diary_empty.png"),
                  height: 100,
                ),
                if (widget.isExpanded) const SizedBox(height: 30),
                Text(
                  "No homework entries",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 10),
                if (widget.isExpanded) MGSButton(
                  label: "Add new",
                  outlined: true,
                  onPressed: () {
                    Navigator.of(context).push(platformPageRoute(
                      context: context,
                      fullscreenDialog: true,
                      builder: (_) => AddDiaryEntry(
                        diaryEntryController: widget.diaryEntryController,
                      ),
                    ));
                  },
                )
              ],
            ),
          );
        }

        return DayEntry(
          deleteHomework: widget.diaryEntryController.deleteHomework,
          subjectEntries: data.subjectEntries,
          toggleHomework: widget.diaryEntryController.toggleHomework,
        );
      }
    );
  }
}