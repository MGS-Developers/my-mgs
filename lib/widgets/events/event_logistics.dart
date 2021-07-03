import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data_classes/event.dart';
import 'package:mymgs/widgets/text_icon.dart';

class EventLogistics extends StatelessWidget {
  final Event event;
  final bool showFullDate;
  final bool forceLightText;
  const EventLogistics({
    required this.event,
    this.showFullDate = false,
    this.forceLightText = false,
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

    final textStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
      color: forceLightText ? Colors.white70 : null,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(
          style: textStyle,
          children: [
            TextIconSpan(
              icon: PlatformIcons(context).time,
              forceLightIcon: forceLightText,
            ),
            const WidgetSpan(child: SizedBox(width: 5)),
            TextSpan(
              text: showFullDate ? parsedDate.yMMMdjm : parsedDate.jm,
            ),
            TextSpan(
              text: " • "
            ),
            TextSpan(
              text: durationText,
            )
          ]
        )),
        const SizedBox(height: 5),
        Text.rich(TextSpan(
          style: textStyle,
          children: [
            TextIconSpan(
              icon: PlatformIcons(context).location,
              forceLightIcon: forceLightText,
            ),
            const WidgetSpan(child: SizedBox(width: 5)),
            TextSpan(
              text: locationText,
            ),
          ]
        )),
      ],
    );
  }
}