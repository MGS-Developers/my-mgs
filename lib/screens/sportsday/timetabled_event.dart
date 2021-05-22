import 'package:flutter/material.dart' hide Form;
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data/local_database.dart';
import 'package:mymgs/data/sportsday/form_events.dart';
import 'package:mymgs/data/sportsday/reminders.dart';
import 'package:mymgs/data/sportsday/year_group_events.dart';
import 'package:mymgs/data_classes/sportsday/event.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/data_classes/sportsday/score.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/helpers/sportsday.dart';
import 'package:mymgs/widgets/button.dart';
import 'package:mymgs/widgets/shimmer_builder.dart';
import 'package:mymgs/widgets/sportsday/form_position_table.dart';

class SportsDayTimetabledEvent extends StatefulWidget {
  final EventGroup eventGroup;
  final int subEvent;
  final int yearGroup;
  late final _eventFuture = getEventFromComponents(eventGroup, subEvent, yearGroup);
  SportsDayTimetabledEvent({
    Key? key,
    required this.eventGroup,
    required this.subEvent,
    required this.yearGroup,
  });
  _SportsDayTimetabledEventState createState() => _SportsDayTimetabledEventState();
}

class _SportsDayTimetabledEventState extends State<SportsDayTimetabledEvent> {
  bool reminderSet = false;
  final dbFuture = getDb();

  // generates an ID unique to the event without getting the event
  String get _eventId {
    return SportsDayReminders.eventId(widget.eventGroup, widget.subEvent, widget.yearGroup);
  }

  void _initReminderSet() async {
    final _reminderSet = await SportsDayReminders.isReminderSet(_eventId);
    setState(() {
      reminderSet = _reminderSet;
    });
  }

  void _toggleReminder(Event event) async {
    final _reminderSet = await SportsDayReminders.toggleReminder(widget.eventGroup, event);
    setState(() {
      reminderSet = _reminderSet;
    });
  }

  @override
  void initState() {
    super.initState();
    _initReminderSet();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final padding = EdgeInsets.symmetric(horizontal: responsive.horizontalPadding);

    return Scaffold(
      appBar: AppBar(
        title: Text('Event details — ${widget.eventGroup.name} (${subEventToString(widget.subEvent)})'),
      ),
      body: FutureBuilder<Event?>(
        future: widget._eventFuture,
        builder: (context, snapshot) {
          final data = snapshot.data;
          final timetable = data?.timetable;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerBuilder();
          }

          if (data == null || timetable == null) {
            return Container();
          }

          final isSufficientlyInFuture = timetable.startTime.toDate().subtract(Duration(minutes: 10)).isAfter(DateTime.now());
          final isInPast = timetable.startTime.toDate().isBefore(DateTime.now());

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: padding,
                  child: Text(
                    '${timetable.locationString} at ${Jiffy(timetable.startTime.toDate()).Hm}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: padding,
                  child: isInPast ? Text(
                    "Event has already started/finished",
                    style: Theme.of(context).textTheme.bodyText1,
                  ) : MGSButton(
                    label: reminderSet ? "Cancel reminder" : "Remind me",
                    onPressed: () {
                      _toggleReminder(data);
                    },
                    enabled: isSufficientlyInFuture,
                    tooltip: !isSufficientlyInFuture ? "Event is already <10 minutes away" : "10 minutes before event",
                  ),
                ),
                const SizedBox(height: 10),
                if (isInPast) StreamBuilder<List<ScoreNode>>(
                  stream: getEventGroupScoreNodes(
                    yearGroup: widget.yearGroup,
                    eventGroup: widget.eventGroup,
                    subEvent: widget.subEvent,
                    eventId: data.id,
                  ),
                  builder: (context, snapshot) {
                    final scoreNodes = snapshot.data;
                    if (scoreNodes == null) {
                      return Container();
                    }

                    return FormPositionTable<ScoreNode>(
                      data: scoreNodes,
                      isARace: widget.subEvent == 0,
                      getAbsoluteScore: (e) => e.absolute,
                      getPosition: (e) => e.position,
                      getFormName: (e) => e.form!.humanID,
                      getPoints: (e) => e.calculatedPoints ?? 0,
                      getForm: (e) => e.form!,
                    );
                  }
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
