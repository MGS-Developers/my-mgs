import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mymgs/data_classes/news.dart';
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
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: MarkdownBody(
            data: newsItem.body,
            styleSheet: MarkdownStyleSheet(
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
          padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 10),
          child: Links(
            links: links,
          ),
        ),
        InfoDisclaimer(identifiable: newsItem, hPadding: 15),
      ],
    );
  }
}
