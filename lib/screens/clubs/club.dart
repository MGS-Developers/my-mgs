import 'package:flutter/material.dart';
import 'package:mymgs/data/analytics.dart';
import 'package:mymgs/data_classes/club.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/widgets/clubs/club_logistics.dart';
import 'package:mymgs/widgets/clubs/club_subscription_button.dart';
import 'package:mymgs/widgets/content_markdown.dart';
import 'package:mymgs/widgets/info_disclaimer.dart';
import 'package:mymgs/widgets/page_layouts/hero_text_appbar.dart';
import 'package:mymgs/widgets/links.dart';
import 'package:mymgs/widgets/tutorial/tutorial_show_once.dart';

class ClubScreen extends StatefulWidget {
  final Club club;
  const ClubScreen({
    required this.club,
  });

  _ClubScreenState createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    AnalyticsEvents.view(widget.club, widget.club.name);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final description = widget.club.description;
    final links = widget.club.links;

    final padding = Responsive(context).horizontalReaderPadding;

    return Scaffold(
      appBar: HeroTextAppBar(
        controller: _controller,
        title: widget.club.name,
        start: 20,
        end: 70,
        shareable: widget.club,
      ),
      body: SingleChildScrollView(
        controller: _controller,
        padding: EdgeInsets.symmetric(horizontal: padding).copyWith(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.club.name,
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 5),
            ClubLogistics(
              club: widget.club,
              showFullTime: true,
              interactiveStaffName: true,
              showLocation: true,
            ),
            const SizedBox(height: 20),
            if (description != null) ContentMarkdown(content: description),
            const SizedBox(height: 20),
            TutorialShowOnce(
              tutorialKey: "club_subscribe",
              padding: EdgeInsets.only(bottom: 10),
              enabled: false,
              children: [
                Text(
                  "Subscribe to a club",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10),
                Text(
                  "Get reminders, notifications, events, and more when you subscribe to " + widget.club.name + ".",
                )
              ]
            ),
            ClubSubscriptionButton(club: widget.club),
            if (links != null) Links(
              links: links
            ),
            const SizedBox(height: 30),
            InfoDisclaimer(identifiable: widget.club),
          ],
        )
      ),
    );
  }
}