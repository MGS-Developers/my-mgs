import 'package:flutter/material.dart';
import 'package:mymgs/data/events.dart';
import 'package:mymgs/data_classes/event.dart';
import 'package:mymgs/screens/main_navigation.dart';
import 'package:mymgs/widgets/dashboard_cards/dashboard_card.dart';
import 'package:mymgs/widgets/events/event_card.dart';
import 'package:mymgs/widgets/spinner.dart';

class TodaysEventsCard extends StatelessWidget {
  final Key key;
  TodaysEventsCard(this.key);

  final _future = getTodaysEvents();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Event>>(
      future: _future,
      builder: (context, snapshot) {
        final data = snapshot.data;

        List<Widget> children;
        if (snapshot.connectionState == ConnectionState.waiting) {
          children = [Spinner()];
        } else if (data == null || data.length == 0) {
          children = [Text(
            "No events today.",
            style: Theme.of(context).textTheme.bodyText1,
          )];
        } else {
          children = data.map((event) => EventCard(
            event: event,
          )).toList();
        }

        return DashboardCard(
          title: "Events",
          titleMargin: 10,
          children: children,
          onPressed: () {
            DrawerSwitcher.of(context)?.switchTo("events");
          },
        );
      }
    );
  }
}