import 'package:flutter/material.dart';
import 'package:mymgs/data/sportsday/year_group_events.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/data_classes/sportsday/score.dart';
import 'package:mymgs/helpers/sportsday.dart';
import 'package:mymgs/widgets/spinner.dart';
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: subEventList.map((subEvent) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Race ${subEventToString(subEvent)}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                StreamBuilder<List<ScoreNode>>(
                  stream: scoreNodeStreamList[subEvent],
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    if (data == null) {
                      return Center(
                        child: Spinner(),
                      );
                    }

                    return Container(
                      width: double.infinity,
                      child: FormPositionTable<ScoreNode>(
                        data: data,
                        getPosition: (e) => e.position,
                        getFormName: (e) => e.form!.humanID,
                        getPoints: (e) => e.calculatedPoints ?? 0,
                        getForm: (e) => e.form!
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
