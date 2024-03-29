import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mymgs/data/analytics.dart';
import 'package:mymgs/data_classes/news.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/widgets/linkable_markdown.dart';
import 'package:mymgs/widgets/page_layouts/image_scaffold.dart';
import 'package:mymgs/widgets/info_disclaimer.dart';
import 'package:mymgs/widgets/links.dart';
import 'package:mymgs/widgets/nullable_image.dart';

class NewsItemScreen extends StatefulWidget {
  final NewsItem newsItem;
  final String? heroKey;
  final bool isFullScreen;
  const NewsItemScreen({
    required this.newsItem,
    this.heroKey,
    this.isFullScreen = true,
    Key? key,
  });

  _NewsItemScreenState createState() => _NewsItemScreenState();
}

class _NewsItemScreenState extends State<NewsItemScreen> {
  @override
  void initState() {
    super.initState();
    AnalyticsEvents.view(widget.newsItem, widget.newsItem.headline);
  }

  @override
  Widget build(BuildContext context) {
    final newsItem = widget.newsItem;
    final links = newsItem.links;

    return ImageScaffold(
      showAppBar: widget.isFullScreen,
      appBarLabel: "Article",
      title: newsItem.headline,
      image: nullableImageProvider(url: newsItem.image.fullUrl),
      heroKey: widget.heroKey,
      shareable: newsItem,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.isFullScreen ? Responsive(context).horizontalReaderPadding : 20,
            vertical: 15,
          ).copyWith(top: 30),
          child: LinkableMarkdown(
            text: newsItem.body,
            styleSheet: MarkdownStyleSheet(
              blockSpacing: 15,
              p: const TextStyle(
                fontSize: 17,
                fontFamily: "Newsreader",
                fontWeight: FontWeight.normal,
                height: 1.2,
              ),
            ),
          ),
        ),
        if (links != null) Padding(
          padding: EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 10),
          child: Links(
            links: links,
          ),
        ),
        InfoDisclaimer(identifiable: newsItem, hPadding: 15),
      ],
    );
  }
}
