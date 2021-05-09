import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/magazines.dart';
import 'package:mymgs/data_classes/protobuf/magazines.pb.dart' hide Color;
import 'package:mymgs/screens/magazines/section.dart';
import 'package:mymgs/widgets/magazines/article_card.dart';
import 'package:mymgs/widgets/spinner.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 140,
          width: double.infinity,
          decoration: const BoxDecoration(),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              if (section.hasBannerColor()) Positioned.fill(
                child: Container(color: parsePbColor(section.bannerColor)),
              ),
              if (section.hasBannerImage()) Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: section.bannerImage.url,
                  fit: BoxFit.cover,
                ),
              ),

              if (section.displayTitleInBanner) Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color(0x90000000),
                        Color(0x00000000),
                      ],
                    ),
                  ),
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    section.title,
                    style: parsePbTextStyle(theme.headingStyle).copyWith(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),

              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.white.withOpacity(0.5),
                    onTap: () {
                      Navigator.of(context).push(platformPageRoute(
                        context: context,
                        builder: (_) => MagazineSectionScreen(
                            theme: theme,
                            section: section,
                            publicationId: publicationId,
                            seasonId: seasonId,
                            editionId: editionId
                        ),
                      ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 15),

        SizedBox(
          height: 180,
          child: FutureBuilder<List<Article>>(
              future: _articlesFuture,
              builder: (context, snapshot) {
                final articles = snapshot.data;
                if (articles == null) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: EdgeInsets.all(15),
                      child: Spinner(),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("Something went wrong."),
                    );
                  }
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: articles.length,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 5).copyWith(bottom: 5),
                      width: 300,
                      child: ArticleCard(
                        article: article,
                        theme: theme,
                        compressed: true,
                      ),
                    );
                  },
                );
              }
          ),
        ),
      ],
    );
  }
}
