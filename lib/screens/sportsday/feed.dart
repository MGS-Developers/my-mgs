import 'package:flutter/material.dart';
import 'package:mymgs/data/sportsday/feed.dart';
import 'package:mymgs/data_classes/sportsday/feed_item.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/widgets/spinner.dart';
import 'package:mymgs/widgets/sportsday/feed/event_tile.dart';
import 'package:mymgs/widgets/sportsday/feed/media_tile.dart';

class SportsDayFeed extends StatelessWidget {
  final stream = getScoreNodeStream();
  SportsDayFeed();

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
                final media = item.media;

                if (event != null) {
                  return EventFeedTile(event: event, timestamp: item.timestamp);
                } else if (media != null) {
                  return MediaFeedTile(media: media, timestamp: item.timestamp);
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
