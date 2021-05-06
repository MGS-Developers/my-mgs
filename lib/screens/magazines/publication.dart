import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/magazines.dart';
import 'package:mymgs/data_classes/protobuf/magazines.pb.dart' hide TextStyle;
import 'package:mymgs/widgets/magazines/season_slider.dart';
import 'package:mymgs/widgets/page_layouts/image_scaffold.dart';
import 'package:mymgs/widgets/page_layouts/info.dart';

class PublicationScreen extends StatefulWidget {
  final Publication publication;
  final Image? cachedImageData;
  const PublicationScreen({
    Key? key,
    required this.publication,
    this.cachedImageData,
  });

  _PublicationScreenState createState() => _PublicationScreenState();
}

class _PublicationScreenState extends State<PublicationScreen> {
  String? coverImageUrl;
  List<Season> seasons = [];

  @override
  void initState() {
    super.initState();
    final cachedImageData = widget.cachedImageData;
    if (cachedImageData != null) {
      setState(() {
        coverImageUrl = cachedImageData.url;
      });
    } else {
      getLatestEdition(widget.publication.id).then((value) {
        setState(() {
          coverImageUrl = value.coverImage.url;
        });
      });
    }

    getSeasons(widget.publication.id).then((seasons) {
      setState(() {
        this.seasons = seasons;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ImageScaffold(
      title: widget.publication.title,
      titleStyle: parsePbTextStyle(widget.publication.theme.titleStyle).copyWith(
        fontSize: 28,
      ),
      appBarLabel: "Editions",
      image: coverImageUrl != null ? CachedNetworkImageProvider(coverImageUrl!) : null,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(platformPageRoute(
              context: context,
              builder: (_) => InfoScreen(
                title: "About " + widget.publication.title,
                markdownContent: widget.publication.description,
              ),
            ));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(
              widget.publication.caption,
              style: parsePbTextStyle(widget.publication.theme.paragraphStyle),
            ),
          ),
        ),

        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: seasons.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: SeasonSlider(
                season: seasons[index],
                theme: widget.publication.theme,
                publication: widget.publication,
              ),
            );
          }
        ),
      ],
    );
  }
}
