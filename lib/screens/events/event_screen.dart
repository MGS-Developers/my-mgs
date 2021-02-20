import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mymgs/data_classes/event.dart';
import 'package:mymgs/widgets/events/event_logistics.dart';
import 'package:mymgs/widgets/events/event_reminder_button.dart';
import 'package:mymgs/widgets/hero/image_scaffold.dart';
import 'package:mymgs/widgets/links.dart';

class EventScreen extends StatelessWidget {
  final Event event;
  const EventScreen({
    @required this.event,
  });

  void _toggleReminder() {

  }

  @override
  Widget build(BuildContext context) {
    return ImageScaffold(
      title: event.title,
      appBarLabel: "Event",
      image: NetworkImage(event.imageUrl),
      children: [
        if (event.club != null) Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            title: Text(event.club.name),
            subtitle: Text(
              event.club.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              // link to club screen
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: MarkdownBody(
            data: event.description,
            selectable: true,
            styleSheet: MarkdownStyleSheet(
              p: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: EventLogistics(
            event: event,
            showFullDate: true,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: EventReminderButton(event: event),
        ),
        const SizedBox(height: 15),
        if (event.links != null) Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Links(links: event.links),
        ),
        if (event.links != null) const SizedBox(height: 10),
      ],
    );
  }
}