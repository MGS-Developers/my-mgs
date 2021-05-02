import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
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
      titleStyle: GoogleFonts.getFont(widget.publication.theme.titleStyle.font, textStyle: TextStyle(
          fontSize: 28,
          color: parsePbColor(widget.publication.theme.titleStyle.color)
      )),
      appBarLabel: "Editions",
      image: coverImageUrl != null ? CachedNetworkImageProvider(coverImageUrl!) : null,
      heroKey: coverImageUrl,
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
              style: GoogleFonts.getFont(widget.publication.theme.paragraphStyle.font),
            ),
          ),
        ),

        for (final season in seasons)
          SeasonSlider(
            season: season,
            theme: widget.publication.theme,
            publication: widget.publication,
          ),
      ],
    );
  }
}
