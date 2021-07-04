import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mymgs/data_classes/sportsday/feed_item.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/widgets/sportsday/feed/tile_time.dart';

class MediaFeedTile extends StatelessWidget {
  final MediaFeedItem media;
  final Timestamp timestamp;

  const MediaFeedTile({
    Key? key,
    required this.media,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive(context).horizontalPadding,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: "Update from "
                ),
                TextSpan(
                  text: media.author,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: " — ",
                ),
                WidgetSpan(
                  child: TileTimer(time: timestamp),
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                ),
              ],
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            media.text,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
