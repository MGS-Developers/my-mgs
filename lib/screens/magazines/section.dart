import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mymgs/data/magazines.dart';
import 'package:mymgs/data_classes/protobuf/magazines.pb.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/widgets/magazines/article_card.dart';
import 'package:mymgs/widgets/page_layouts/image_scaffold.dart';
import 'package:mymgs/widgets/spinner.dart';

class MagazineSectionScreen extends StatelessWidget {
  final PublicationTheme theme;
  final Section section;
  final String publicationId;
  final String seasonId;
  final String editionId;
  MagazineSectionScreen({
    Key? key,
    required this.theme,
    required this.section,
    required this.publicationId,
    required this.seasonId,
    required this.editionId,
  });

  late final _articlesFuture = getArticles(publicationId, seasonId, editionId, section.id);

  @override
  Widget build(BuildContext context) {
    return ImageScaffold(
      title: section.title,
      appBarLabel: "Section",
      image: section.hasBannerImage() ? CachedNetworkImageProvider(section.bannerImage.url) : null,
      titleStyle: parsePbTextStyle(theme.headingStyle).copyWith(
        fontSize: 28,
      ),
      children: [
        FutureBuilder<List<Article>>(
          future: _articlesFuture,
          builder: (context, snapshot) {
            final articles = snapshot.data;
            if (articles == null) {
              return Padding(
                padding: EdgeInsets.all(15),
                child: Spinner(),
              );
            }

            return StaggeredGridView.countBuilder(
              crossAxisCount: Responsive(context).triColumnCount,
              itemCount: articles.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),

              crossAxisSpacing: 15, mainAxisSpacing: 15,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ArticleCard(article: article, theme: theme);
              },
              staggeredTileBuilder: (context) => StaggeredTile.fit(1),
            );
          },
        ),
      ],
    );
  }
}
