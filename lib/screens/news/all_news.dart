import 'package:flutter/material.dart';
import 'package:mymgs/data/news.dart';
import 'package:mymgs/data_classes/news.dart';
import 'package:mymgs/screens/news/news_item.dart';
import 'package:mymgs/widgets/page_layouts/master_detail.dart';
import 'package:mymgs/widgets/news/news_preview.dart';
import 'package:mymgs/widgets/spinner.dart';

class AllNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsItem>>(
      future: getNews(100),
      builder: (BuildContext context, snapshot) {
        final data = snapshot.data;
        return MasterDetailScreen(
          masterTitle: 'News',
          masterBuilder: (context, selectedIndex, onTap) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Spinner(),
              );
            }

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
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemBuilder: (BuildContext context, int index) {
                final newsItem = data[index];
                return NewsPreview(
                  key: Key(newsItem.id),
                  newsItem: newsItem,
                  onTap: () => onTap(index),
                  selected: index == selectedIndex,
                );
              },
            );
          },
          detailBuilder: (context, selectedIndex, isNewScreen, [_]) {
            if (data == null) return SizedBox();
            return NewsItemScreen(newsItem: data[selectedIndex], isFullScreen: isNewScreen);
          }
        );
      },
    );
  }
}