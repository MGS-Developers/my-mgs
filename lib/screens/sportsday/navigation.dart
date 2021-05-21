import 'package:flutter/material.dart';
import 'package:mymgs/screens/sportsday/commentary.dart';
import 'package:mymgs/screens/sportsday/events.dart';
import 'package:mymgs/screens/sportsday/find_event.dart';
import 'package:mymgs/screens/sportsday/form_leaderboard.dart';
import 'package:mymgs/widgets/drawer/drawer_app_bar.dart';

class SportsDayNavigation extends StatefulWidget {
  const SportsDayNavigation();
  _SportsDayNavigationState createState() => _SportsDayNavigationState();
}

class _SportsDayNavigationState extends State<SportsDayNavigation> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerAppBar("Sports Day 2021"),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        onTap: (_index) {
          setState(() {
            index = _index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Forms",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: "Events",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.closed_caption),
            label: "Commentary",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Find event",
          ),
        ],
      ),
      body: IndexedStack(
        index: index,
        children: [
          SportsDayForms(),
          SportsDayEvents(),
          SportsDayCommentary(),
          SportsdayFindEvent(),
        ],
      ),
    );
  }
}
