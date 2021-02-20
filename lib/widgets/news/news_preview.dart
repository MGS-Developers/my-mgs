import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data_classes/news.dart';
import 'package:mymgs/screens/news/news_item.dart';

class NewsPreview extends StatelessWidget {
  final NewsItem newsItem;
  const NewsPreview({
    @required Key key,
    @required this.newsItem,
  });

  @override
  Widget build(BuildContext context) {
    final String previewText = newsItem.authorName + " • " + Jiffy(newsItem.createdAt.toDate()).fromNow();

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      leading: Image(
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        image: CachedNetworkImageProvider(newsItem.image.thumbnailUrl),
      ),
      title: Text(newsItem.headline),
      subtitle: Text(previewText),
      onTap: () {
        Navigator.of(context).push(platformPageRoute(
          context: context,
          builder: (_) => NewsItemScreen(newsItem: newsItem),
        ));
      },
    );
  }
}