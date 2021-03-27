import 'package:flutter/material.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/widgets/sportsday/event_by_year_group.dart';

class SportsDayEvent extends StatelessWidget {
  final EventGroup eventGroup;
  final int initialYearGroup;
  const SportsDayEvent({
    required this.eventGroup,
    this.initialYearGroup = 7,
  });

  @override
  Widget build(BuildContext context) {
    const yearGroups = [7, 8, 9, 10];

    return DefaultTabController(
      length: 4,
      initialIndex: yearGroups.indexOf(initialYearGroup),
      child: Scaffold(
        appBar: AppBar(
          title: Text(eventGroup.name),
          bottom: TabBar(
            tabs: yearGroups.map((year) => Tab(
              text: 'Year $year',
            )).toList(),
          ),
        ),
        body: TabBarView(
          children: yearGroups.map((year) => EventByYearGroup(
            eventGroup: eventGroup,
            yearGroup: year,
          )).toList(),
        ),
      ),
    );
  }
}
