import 'package:flutter/material.dart';
import 'package:mymgs/data/news.dart';
import 'package:mymgs/data_classes/news.dart';
import 'package:mymgs/widgets/news/news_preview.dart';
import 'package:mymgs/widgets/spinner.dart';

class AllNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: FutureBuilder<List<NewsItem>>(
        future: getNews(100),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Spinner(),
            );
          }

          final data = snapshot.data;
          if (data == null || snapshot.hasError) {
            return Center(
              child: Text(
                "Something went wrong.",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final newsItem = data[index];
              return NewsPreview(
                key: Key(newsItem.id),
                newsItem: newsItem,
              );
            },
          );
        },
      ),
    );
  }
}