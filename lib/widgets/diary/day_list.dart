import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:infinite_listview/infinite_listview.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data/diary.dart';
import 'package:mymgs/data_classes/diary_entry.dart';
import 'package:mymgs/widgets/diary/day_entry.dart';

class DiaryDayList extends StatelessWidget {
  final void Function(DateTime _date) focusOnDay;
  const DiaryDayList({
    required this.focusOnDay,
  });

  DateTime _getDateForIndex(int index) {
    return DateTime.now().add(Duration(days: index));
  }

  @override
  Widget build(BuildContext context) {
    return InfiniteListView.builder(
      itemBuilder: (context, index) {
        final date = _getDateForIndex(index);
        final controller = DiaryEntryController.forDay(date);
        return InkWell(
          onTap: () {
            focusOnDay(date);
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Jiffy(date).yMMMEd,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                StreamBuilder<DiaryEntry>(
                  stream: controller.stream,
                  builder: (context, snapshot) {
                    final data = snapshot.data;

                    if (data == null || data.subjectEntries.length == 0) {
                      return Container(
                        child: Text(
                          'No homework',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: DayEntry(
                        deleteHomework: controller.deleteHomework,
                        subjectEntries: data.subjectEntries,
                        toggleHomework: controller.toggleHomework,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
