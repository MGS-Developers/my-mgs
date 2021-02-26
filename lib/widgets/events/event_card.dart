import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data_classes/event.dart';
import 'package:mymgs/screens/events/event_screen.dart';
import 'package:mymgs/widgets/events/event_logistics.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({
    Key key,
    @required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = event.imageUrl != null && event.imageUrl != '';

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(platformPageRoute(
            context: context,
            builder: (_) => EventScreen(event: event),
          ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImage) Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.only(
                bottom: 10,
              ),
              child: Image(
                image: CachedNetworkImageProvider(event.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            if (!hasImage) const SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 1),
                  Text(
                    event.summary,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 5),
                  EventLogistics(event: event),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}