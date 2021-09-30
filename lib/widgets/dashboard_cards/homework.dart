import 'package:flutter/material.dart';
import 'package:mymgs/screens/main_navigation.dart';
import 'package:mymgs/widgets/dashboard_cards/dashboard_card.dart';
import 'package:mymgs/widgets/diary/entry_list.dart';

class HomeworkCard extends StatefulWidget {
  const HomeworkCard({
    Key? key,
  });
  _HomeworkCardState createState() => _HomeworkCardState();
}

class _HomeworkCardState extends State<HomeworkCard> {

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
          key: const Key("dashboard_homework_list"),
          date: DateTime.now(),
          isExpanded: false,
        ),
      ],
    );
  }
}
