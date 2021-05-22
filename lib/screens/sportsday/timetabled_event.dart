import 'package:flutter/material.dart' hide Form;
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data/sportsday/form_events.dart';
import 'package:mymgs/data_classes/sportsday/event.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/data_classes/sportsday/form.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/widgets/button.dart';
import 'package:mymgs/widgets/shimmer_builder.dart';

class SportsDayTimetabledEvent extends StatefulWidget {
  final EventGroup eventGroup;
  final int subEvent;
  final Form form;
  late final _eventFuture = getEventFromComponents(eventGroup, subEvent, form);
  SportsDayTimetabledEvent({
    Key? key,
    required this.eventGroup,
    required this.subEvent,
    required this.form,
  });
  _SportsDayTimetabledEventState createState() => _SportsDayTimetabledEventState();
}

class _SportsDayTimetabledEventState extends State<SportsDayTimetabledEvent> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final padding = EdgeInsets.symmetric(horizontal: responsive.horizontalPadding);

    return Scaffold(
      appBar: AppBar(
        title: Text('Event details — ${widget.eventGroup.name}'),
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

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 15),
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
                  child: MGSButton(
                    label: "Remind me",
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
