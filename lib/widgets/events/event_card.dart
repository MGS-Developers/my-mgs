import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data_classes/event.dart';
import 'package:mymgs/helpers/animation.dart';
import 'package:mymgs/screens/events/event_screen.dart';
import 'package:mymgs/widgets/events/event_logistics.dart';
import 'package:mymgs/widgets/nullable_image.dart';

typedef _HeroKeyCallback = void Function(String heroKey);

class EventCard extends StatelessWidget {
  final Event event;
  final String heroKey;
  final _HeroKeyCallback? onTap;
  final bool selected;
  final bool showImage;
  EventCard({
    Key? key,
    required this.event,
    this.onTap,
    this.selected = false,
    this.showImage = true,
  }) : heroKey = randomHeroKey();

  @override
  Widget build(BuildContext context) {
    final _showImage = event.imageUrl != null && event.imageUrl != '' && showImage;
    final summary = event.summary;
    final _callback = onTap;

    return Card(
      color: selected ? Theme.of(context).colorScheme.primary : null,
      child: InkWell(
        onTap: _callback != null ? () => _callback(heroKey) : () {
          Navigator.of(context).push(platformPageRoute(
            context: context,
            builder: (_) => EventScreen(
              event: event,
              heroKey: heroKey,
            ),
          ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_showImage) Hero(
              tag: heroKey,
              transitionOnUserGestures: true,
              child: Container(
                height: 120,
                width: double.infinity,
                padding: EdgeInsets.only(
                  bottom: 10,
                ),
                child: NullableImage(
                  url: event.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (!_showImage) const SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: selected ? Colors.white : null,
                    ),
                  ),
                  const SizedBox(height: 1),
                  if (summary != null) Text(
                    summary,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: selected ? Colors.white70 : null,
                    ),
                  ),
                  const SizedBox(height: 5),
                  EventLogistics(
                    event: event,
                    forceLightText: selected,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}