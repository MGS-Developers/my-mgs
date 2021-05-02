import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/magazines.dart';
import 'package:mymgs/data_classes/protobuf/magazines.pb.dart';
import 'package:mymgs/screens/magazines/article.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final PublicationTheme theme;
  final bool compressed;
  const ArticleCard({
    required this.article,
    required this.theme,
    this.compressed = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        elevation: compressed ? 0 : 2,
        color: Theme.of(context).backgroundColor,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: compressed ? 50 : 80,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: article.image.url,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(compressed ? 10 : 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        style: parsePbTextStyle(theme.headingStyle).copyWith(
                          fontSize: compressed ? 15 : 16,
                          color: Theme.of(context).textTheme.headline4?.color,
                        ),
                        maxLines: compressed ? 3 : 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (!compressed) Text(
                        article.authors.map((e) => e.name).join(", "),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.black.withOpacity(0.2),
                  onTap: () {
                    Navigator.of(context).push(platformPageRoute(
                      context: context,
                      builder: (_) => ArticleScreen(article: article, theme: theme),
                    ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
