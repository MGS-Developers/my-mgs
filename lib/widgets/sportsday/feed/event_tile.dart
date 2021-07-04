import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/data_classes/sportsday/feed_item.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/helpers/sportsday.dart';
import 'package:mymgs/screens/sportsday/event_group.dart';
import 'package:mymgs/widgets/sportsday/feed/tile_time.dart';

class EventFeedTile extends StatelessWidget {
  final EventFeedItem event;
  final Timestamp timestamp;
  const EventFeedTile({
    Key? key,
    required this.event,
    required this.timestamp,
  });

  void _openEvent(BuildContext context) {
    final eventGroup = EventGroup(
      id: event.groupId,
      name: event.name,
      subEventCount: event.subEventCount,
      scoreSpecId: event.scoreSpecId,
    );

    Navigator.of(context).push(platformPageRoute(
      context: context,
      builder: (_) => SportsDayEvent(
        eventGroup: eventGroup,
        initialYearGroup: event.yearGroup,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        _openEvent(context);
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: Responsive(context).horizontalPadding,
        vertical: 10,
      ),
      title: Text(
        "${event.name} — Year ${event.yearGroup} — Race ${subEventToString(event.subEvent)}",
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
          fontSize: 20,
        ),
      ),
      subtitle: TileTimer(time: timestamp),
    );
  }
}
