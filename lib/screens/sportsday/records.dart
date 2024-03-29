import 'package:flutter/material.dart';
import 'package:mymgs/widgets/sportsday/records_by_year_group.dart';

class SportsDayRecords extends StatefulWidget {
  const SportsDayRecords();
  _SportsDayRecordsState createState() => _SportsDayRecordsState();
}

const _yearGroups = [7, 8, 9, 10];
class _SportsDayRecordsState extends State<SportsDayRecords> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).colorScheme.primary,
              child: TabBar(
                tabs: _yearGroups.map((e) => Tab(
                  text: "Year $e",
                )).toList(),
              ),
            ),

            Expanded(
              child: TabBarView(
                children: _yearGroups.map((e) {
                  return RecordsByYearGroup(
                    yearGroup: e,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
