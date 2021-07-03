import 'package:flutter/material.dart';
import 'package:mymgs/data/diary.dart';
import 'package:mymgs/screens/main_navigation.dart';
import 'package:mymgs/widgets/dashboard_cards/dashboard_card.dart';
import 'package:mymgs/widgets/diary/entry_list.dart';

class HomeworkCard extends StatefulWidget {
  final Key key;
  const HomeworkCard(this.key);
  _HomeworkCardState createState() => _HomeworkCardState();
}

class _HomeworkCardState extends State<HomeworkCard> {
  late DiaryEntryController _diaryEntryController;

  @override
  void initState() {
    _diaryEntryController = getControllerForDay(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: "Homework",
      titleMargin: 10,
      onPressed: () {
        DrawerSwitcher.of(context)?.switchTo("diary");
      },
      children: [
        EntryList(
          diaryEntryController: _diaryEntryController,
          showNewButton: false,
        ),
      ],
    );
  }
}
