import 'package:flutter/material.dart';
import 'package:mymgs/data_classes/club.dart';
import 'package:mymgs/widgets/clubs/club_logistics.dart';
import 'package:mymgs/widgets/clubs/club_subscription_button.dart';
import 'package:mymgs/widgets/content_markdown.dart';
import 'package:mymgs/widgets/hero/hero_text_appbar.dart';
import 'package:mymgs/widgets/links.dart';

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
    _controller = ScrollController();
    super.initState();
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

    return Scaffold(
      appBar: HeroTextAppBar(
        controller: _controller,
        title: widget.club.name,
        start: 20,
        end: 70,
      ),
      body: SingleChildScrollView(
        controller: _controller,
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 30),
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
            ClubSubscriptionButton(club: widget.club),
            if (links != null) Links(
              links: links
            ),
            const SizedBox(height: 20),
          ],
        )
      ),
    );
  }
}