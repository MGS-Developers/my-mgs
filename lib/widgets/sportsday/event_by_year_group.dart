import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/sportsday/year_group_events.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/data_classes/sportsday/score.dart';
import 'package:mymgs/helpers/sportsday.dart';
import 'package:mymgs/screens/sportsday/timetabled_event.dart';
import 'package:mymgs/widgets/shimmer/shimmer_builder.dart';
import 'package:mymgs/widgets/sportsday/form_position_table.dart';

class EventByYearGroup extends StatefulWidget {
  final EventGroup eventGroup;
  final int yearGroup;
  const EventByYearGroup({
    required this.eventGroup,
    required this.yearGroup,
  });

  _EventByYearGroupState createState() => _EventByYearGroupState();
}

class _EventByYearGroupState extends State<EventByYearGroup> {
  late final Iterable<int> subEventList;
  late final List<Stream<List<ScoreNode>>> scoreNodeStreamList;

  @override
  void initState() {
    subEventList = Iterable.generate(widget.eventGroup.subEventCount);
    scoreNodeStreamList = subEventList.map((subEvent) => getEventGroupScoreNodes(
      yearGroup: widget.yearGroup,
      eventGroup: widget.eventGroup,
      subEvent: subEvent
    )).toList();
    super.initState();
  }

  void _viewTimetabledEvent(int subEvent) {
    Navigator.of(context).push(platformPageRoute(
      context: context,
      builder: (_) => SportsDayTimetabledEvent(
        eventGroup: widget.eventGroup,
        subEvent: subEvent,
        yearGroup: widget.yearGroup,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final emptyPadding = const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 10);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: subEventList.map((subEvent) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      _viewTimetabledEvent(subEvent);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'Race ${subEventToString(subEvent)}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ),
                StreamBuilder<List<ScoreNode>>(
                  stream: scoreNodeStreamList[subEvent],
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Container(
                        padding: emptyPadding,
                        child: Text(
                          "Something went wrong! Please try again in a few minutes.",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      );
                    }

                    final data = snapshot.data;
                    if (data == null) {
                      return ShimmerBuilder(
                        padding: 15,
                        rows: List.filled(8, [100, double.infinity, 80]),
                        height: 30,
                      );
                    }

                    if (data.isEmpty) {
                      return Container(
                        padding: emptyPadding,
                        child: Text("No data yet", style: Theme.of(context).textTheme.bodyText1),
                      );
                    }

                    return Container(
                      width: double.infinity,
                      child: FormPositionTable<ScoreNode>(
                        isARace: subEvent == 0,
                        data: data,
                        getAbsoluteScore: (e) => e.absolute,
                        getPosition: (e) => e.position,
                        getFormId: (e) => e.formId,
                        getPoints: (e) => e.calculatedPoints ?? 0,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
