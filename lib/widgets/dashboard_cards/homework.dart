import 'package:flutter/material.dart';
import 'package:mymgs/data/diary.dart';
import 'package:mymgs/screens/main_navigation.dart';
import 'package:mymgs/widgets/dashboard_cards/dashboard_card.dart';
import 'package:mymgs/widgets/diary/entry_list.dart';

class HomeworkCard extends StatefulWidget {
  const HomeworkCard();
  _HomeworkCardState createState() => _HomeworkCardState();
}

class _HomeworkCardState extends State<HomeworkCard> {
  DiaryEntryController _diaryEntryController;

  @override
  void initState() {
    _diaryEntryController = getControllerForDay(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    _diaryEntryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      title: "Homework",
      titleMargin: 10,
      onPressed: () {
        DrawerSwitcher.of(context).switchTo(3);
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
