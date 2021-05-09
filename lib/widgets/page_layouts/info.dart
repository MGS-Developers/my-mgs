import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mymgs/data_classes/identifiable.dart';
import 'package:mymgs/data_classes/shareable.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/widgets/info_disclaimer.dart';
import 'package:mymgs/widgets/linkable_markdown.dart';
import 'package:mymgs/widgets/page_layouts/hero_text_appbar.dart';

class InfoScreen extends StatefulWidget {
  final String title;
  final String markdownContent;
  final Identifiable? identifier;
  final Shareable? shareable;
  final bool isFullScreen;
  const InfoScreen({
    required this.title,
    required this.markdownContent,
    this.identifier,
    this.shareable,
    this.isFullScreen = true,
  });

  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late final ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final identifier = widget.identifier;

    return Scaffold(
      appBar: widget.isFullScreen ? HeroTextAppBar(
        controller: _controller,
        title: widget.title,
        start: 20,
        end: 80,
        shareable: widget.shareable,
      ) : null,
      body: SingleChildScrollView(
        controller: _controller,
        padding: widget.isFullScreen ? EdgeInsets.symmetric(
          horizontal: Responsive(context).horizontalReaderPadding,
          vertical: 15,
        ) : EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 15),
            LinkableMarkdown(
              text: widget.markdownContent,
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 40),
            if (identifier != null) InfoDisclaimer(
              identifiable: identifier,
            ),
          ],
        ),
      ),
    );
  }
}
