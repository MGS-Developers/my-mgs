import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data_classes/news.dart';
import 'package:mymgs/helpers/animation.dart';
import 'package:mymgs/screens/news/news_item.dart';
import 'package:mymgs/widgets/nullable_image.dart';

class NewsPreview extends StatelessWidget {
  final NewsItem newsItem;
  final String heroKey;
  NewsPreview({
    required Key key,
    required this.newsItem,
  }) : heroKey = randomHeroKey();

  @override
  Widget build(BuildContext context) {
    final String previewText = newsItem.authorName + " • " + Jiffy(newsItem.createdAt.toDate()).fromNow();

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      leading: newsItem.image.thumbnailUrl != null && newsItem.image.thumbnailUrl != '' ? Hero(
        tag: heroKey,
        transitionOnUserGestures: true,
        child: NullableImage(
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          image: newsItem.image,
        ),
      ) : null,
      title: Text(newsItem.headline),
      subtitle: Text(previewText),
      onTap: () {
        Navigator.of(context).push(platformPageRoute(
          context: context,
          builder: (_) => NewsItemScreen(
            newsItem: newsItem,
            heroKey: heroKey,
          ),
        ));
      },
    );
  }
}