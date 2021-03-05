import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data_classes/event.dart';
import 'package:mymgs/widgets/text_icon.dart';

class EventLogistics extends StatelessWidget {
  final Event event;
  final bool showFullDate;
  const EventLogistics({
    required this.event,
    this.showFullDate = false,
  });

  @override
  Widget build(BuildContext context) {
    final duration = event.endTime.toDate().difference(event.startTime.toDate());
    String durationText;
    if (duration.inMinutes < 60) {
      durationText = duration.inMinutes.toString() + " mins";
    } else {
      durationText = duration.inHours.toString() + "h";

      final remainingMinutes = duration.inMinutes.remainder(60);
      if (remainingMinutes != 0) {
        durationText += " " + remainingMinutes.toString() + "m";
      }
    }

    String locationText = event.location ?? "";
    final club = event.club;
    if (club != null) {
      locationText += " (${club.name})";
    }

    final parsedDate = Jiffy(event.startTime.toDate());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextIcon(icon: PlatformIcons(context).time),
            const SizedBox(width: 5),
            Text(
              showFullDate ? parsedDate.yMMMdjm : parsedDate.jm,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              " • ",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              durationText,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            TextIcon(icon: PlatformIcons(context).location),
            const SizedBox(width: 5),
            Text(
              locationText,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ],
    );
  }
}