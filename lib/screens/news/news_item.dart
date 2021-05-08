import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mymgs/data_classes/news.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/widgets/linkable_markdown.dart';
import 'package:mymgs/widgets/page_layouts/image_scaffold.dart';
import 'package:mymgs/widgets/info_disclaimer.dart';
import 'package:mymgs/widgets/links.dart';
import 'package:mymgs/widgets/nullable_image.dart';

class NewsItemScreen extends StatelessWidget {
  final NewsItem newsItem;
  final String? heroKey;
  const NewsItemScreen({
    required this.newsItem,
    this.heroKey,
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    final links = newsItem.links;

    return ImageScaffold(
      appBarLabel: "Article",
      title: newsItem.headline,
      image: nullableImageProvider(url: newsItem.image.fullUrl),
      heroKey: heroKey,
      shareable: newsItem,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive(context).horizontalReaderPadding,
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
          padding: EdgeInsets.symmetric(horizontal: Responsive(context).horizontalReaderPadding).copyWith(bottom: 10),
          child: Links(
            links: links,
          ),
        ),
        InfoDisclaimer(identifiable: newsItem, hPadding: 15),
      ],
    );
  }
}
