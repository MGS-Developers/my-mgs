import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/news.dart';
import 'package:mymgs/data_classes/news.dart';
import 'package:mymgs/screens/news/all_news.dart';
import 'package:mymgs/widgets/dashboard_cards/dashboard_card.dart';
import 'package:mymgs/widgets/news/news_preview.dart';
import 'package:mymgs/widgets/spinner.dart';

class NewsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsItem>>(
      future: getNews(3),
      builder: (BuildContext context, snapshot) {
        List<Widget> children;
        if (snapshot.connectionState == ConnectionState.waiting) {
          children = [Spinner()];
        } else if (snapshot.hasData && !snapshot.hasError) {
          if (snapshot.data.length == 0) {
            children = [Text(
              "No news found.",
              style: Theme.of(context).textTheme.bodyText1,
            )];
          } else {
            children = snapshot.data.map((item) => NewsPreview(
              key: Key(item.id),
              newsItem: item,
            )).toList();
          }
        } else {
          children = [Text(
            "Something went wrong.",
            style: Theme.of(context).textTheme.bodyText1,
          )];
        }

        return DashboardCard(
          title: "News",
          onPressed: () {
            Navigator.of(context).push(platformPageRoute(
              context: context,
              builder: (_) => AllNews(),
            ));
          },
          children: children,
        );
      },
    );
  }
}