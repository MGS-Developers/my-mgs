import 'package:flutter/material.dart';
import 'package:mymgs/data/news.dart';
import 'package:mymgs/data_classes/news.dart';
import 'package:mymgs/widgets/dashboard_cards/dashboard_card.dart';
import 'package:mymgs/widgets/news/news_preview.dart';
import 'package:mymgs/widgets/spinner.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsItem>>(
      future: getNews(4),
      builder: (BuildContext context, snapshot) {
        return DashboardCard(
          title: "News",
          onPressed: () {

          },
          children: [
            if (snapshot.connectionState == ConnectionState.waiting) Spinner(),
            if (snapshot.connectionState == ConnectionState.done && snapshot.data?.length == 0) Text(
              "No news found.",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            if (snapshot.connectionState == ConnectionState.done && snapshot.data?.length != 0) ...snapshot.data.map(
              (item) => NewsPreview(
                key: Key(item.id),
                newsItem: item,
              )
            )
          ],
        );
      },
    );
  }
}