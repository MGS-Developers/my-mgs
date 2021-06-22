import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data/sportsday/feed.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/data_classes/sportsday/feed_item.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/helpers/sportsday.dart';
import 'package:mymgs/screens/sportsday/event_group.dart';
import 'package:mymgs/widgets/spinner.dart';

class SportsDayFeed extends StatelessWidget {
  final stream = getScoreNodeStream();
  SportsDayFeed();

  void _openEvent(BuildContext context, EventFeedItem event) async {
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
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: StreamBuilder<List<FeedItem>>(
          stream: stream,
          builder: (context, snapshot) {
            final data = snapshot.data;

            if (snapshot.error != null) {
              return Center(
                child: Text("Something went wrong!"),
              );
            }

            if (data == null) {
              return Center(
                child: Spinner(),
              );
            }

            if (data.length == 0) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive(context).horizontalReaderPadding, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/sports_day_empty_feed.png",
                      height: 150,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Coming soon",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Sports Day starts at 9:20 on Wednesday 7th July",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                final event = item.event;

                if (event != null) {
                  return ListTile(
                    onTap: () {
                      _openEvent(context, event);
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
                    subtitle: Text(
                      Jiffy(item.timestamp.toDate()).fromNow(),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
