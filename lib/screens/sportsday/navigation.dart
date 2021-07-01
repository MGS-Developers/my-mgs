import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymgs/screens/sportsday/events.dart';
import 'package:mymgs/screens/sportsday/feed.dart';
import 'package:mymgs/screens/sportsday/find_event.dart';
import 'package:mymgs/screens/sportsday/form_leaderboard.dart';
import 'package:mymgs/screens/sportsday/records.dart';
import 'package:mymgs/widgets/drawer/drawer_app_bar.dart';

class SportsDayNavigation extends StatefulWidget {
  const SportsDayNavigation();
  _SportsDayNavigationState createState() => _SportsDayNavigationState();
}

class _SportsDayNavigationState extends State<SportsDayNavigation> {
  int index = 2;

  static final routes = [
    const SportsDayForms(),
    SportsDayEvents(),
    SportsDayFeed(),
    const SportsDayFindEvent(),
    const SportsDayRecords(),
  ];

  static const tabs = [
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      label: "Forms",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.emoji_events),
      label: "Events",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.stream),
      label: "Feed",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: "Find event",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.stars),
      label: "Records",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          activeColor: Theme.of(context).primaryColor,
          items: tabs,
          currentIndex: index,
          onTap: (_index) {
            setState(() {
              index = _index;
            });
          },
        ),
        tabBuilder: (context, index) {
          return Scaffold(
            appBar: DrawerAppBar("Sports Day 2021"),
            body: SafeArea(
              child: routes[index],
              top: false,
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: DrawerAppBar("Sports Day 2021"),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Color(0x50000000),
        onTap: (_index) {
          setState(() {
            index = _index;
          });
        },
        items: tabs,
      ),
      body: routes[index],
    );
  }
}
