import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mymgs/data_classes/news.dart';
import 'package:mymgs/widgets/hero/image_scaffold.dart';
import 'package:mymgs/widgets/links.dart';

class NewsItemScreen extends StatelessWidget {
  final NewsItem newsItem;
  const NewsItemScreen({
    @required this.newsItem,
    Key key,
  });

  @override
  Widget build(BuildContext context) {
    return ImageScaffold(
      appBarLabel: "Article",
      title: newsItem.headline,
      image: CachedNetworkImageProvider(newsItem.image.fullUrl),
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: MarkdownBody(
            data: newsItem.body,
            styleSheet: MarkdownStyleSheet(
              p: TextStyle(
                fontSize: 17,
                fontFamily: "Newsreader",
                fontWeight: FontWeight.normal,
                height: 1.2,
              ),
            ),
          ),
        ),
        if (newsItem.links != null) Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Links(
            links: newsItem.links,
          ),
        )
      ],
    );
  }
}
