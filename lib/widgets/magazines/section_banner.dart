import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/magazines.dart';
import 'package:mymgs/data_classes/protobuf/magazines.pb.dart';
import 'package:mymgs/screens/magazines/section.dart';
import 'package:mymgs/widgets/magazines/article_card.dart';

class SectionBanner extends StatelessWidget {
  final PublicationTheme theme;
  final Section section;
  final String editionId;
  final String seasonId;
  final String publicationId;
  SectionBanner({
    Key? key,
    required this.theme,
    required this.section,
    required this.editionId,
    required this.seasonId,
    required this.publicationId,
  });

  late final _articlesFuture = getArticles(publicationId, seasonId, editionId, section.id);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          if (section.hasBannerColor()) Positioned.fill(
            child: Container(color: parsePbColor(section.bannerColor)),
          ),
          if (section.hasBannerImage()) Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(section.displayTitleInBanner ? 0.4 : 0), BlendMode.srcOver),
              child: CachedNetworkImage(
                imageUrl: section.bannerImage.url,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.white.withOpacity(0.4),
                  onTap: () {
                    Navigator.of(context).push(platformPageRoute(
                      context: context,
                      builder: (_) => MagazineSectionScreen(
                        theme: theme,
                        section: section,
                        publicationId: publicationId,
                        seasonId: seasonId,
                        editionId: editionId,
                      ),
                    ));
                  },
                ),
              )
          ),

          if (section.displayTitleInBanner) Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FutureBuilder<List<Article>>(
                    future: _articlesFuture,
                    builder: (context, snapshot) {
                      final articles = snapshot.data;
                      if (articles == null) return SizedBox();

                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 15).copyWith(top: 15),
                        scrollDirection: Axis.horizontal,
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          final article = articles[index];
                          return Container(
                            width: 200,
                            padding: EdgeInsets.only(right: 10),
                            child: ArticleCard(article: article, theme: theme, compressed: true),
                          );
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),

                IgnorePointer(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      section.title,
                      style: parsePbTextStyle(section.hasHeadingStyle() ? section.headingStyle : theme.headingStyle).copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
