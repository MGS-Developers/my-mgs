import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mymgs/data_classes/event.dart';
import 'package:mymgs/widgets/events/event_logistics.dart';
import 'package:mymgs/widgets/hero/image_scaffold.dart';

class EventScreen extends StatelessWidget {
  final Event event;
  const EventScreen({
    @required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return ImageScaffold(
      title: event.title,
      appBarLabel: "Event",
      image: NetworkImage(event.imageUrl),
      children: [
        Padding(
          padding: EdgeInsets.all(15).copyWith(bottom: 10),
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
          padding: EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 20),
          child: EventLogistics(event: event),
        ),
      ],
    );
  }
}