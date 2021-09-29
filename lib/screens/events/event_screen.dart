import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/analytics.dart';
import 'package:mymgs/data_classes/event.dart';
import 'package:mymgs/screens/clubs/club.dart';
import 'package:mymgs/widgets/content_markdown.dart';
import 'package:mymgs/widgets/events/event_logistics.dart';
import 'package:mymgs/widgets/events/event_reminder_button.dart';
import 'package:mymgs/widgets/page_layouts/image_scaffold.dart';
import 'package:mymgs/widgets/info_disclaimer.dart';
import 'package:mymgs/widgets/links.dart';

class EventScreen extends StatefulWidget {
  final Event event;
  final String? heroKey;
  final bool showAppBar;
  const EventScreen({
    required this.event,
    this.heroKey,
    this.showAppBar = true,
  });

  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  void initState() {
    super.initState();
    AnalyticsEvents.view(widget.event, widget.event.title);
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final description = event.description;
    final links = event.links;
    final imageUrl = event.imageUrl;
    final club = event.club;
    final clubDescription = club?.description;

    final padding = 15.0;
    final edgeInset = EdgeInsets.symmetric(horizontal: padding);

    return ImageScaffold(
      title: event.title,
      appBarLabel: "Event",
      image: imageUrl != null ? CachedNetworkImageProvider(imageUrl) : null,
      heroKey: widget.heroKey,
      shareable: event,
      showAppBar: widget.showAppBar,
      children: [
        if (club != null) Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            contentPadding: edgeInset,
            title: Text(club.name),
            subtitle: clubDescription != null ? Text(
              clubDescription,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ) : null,
            onTap: () {
              Navigator.of(context).push(platformPageRoute(
                context: context,
                builder: (_) => ClubScreen(club: club),
              ));
            },
            trailing: Icon(
              PlatformIcons(context).rightChevron,
            ),
          ),
        ),
        if (event.club == null) const SizedBox(height: 10),
        if (description != null) Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: padding),
          child: ContentMarkdown(content: description),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: edgeInset,
          child: EventLogistics(
            event: event,
            showFullDate: true,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: edgeInset,
          child: EventReminderButton(event: event),
        ),
        if (links != null) Padding(
          padding: edgeInset,
          child: Links(links: links),
        ),
        if (event.links != null) const SizedBox(height: 10),
        InfoDisclaimer(hPadding: padding, identifiable: event),
      ],
    );
  }
}
