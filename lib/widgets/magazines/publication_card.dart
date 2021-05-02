import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:mymgs/data/magazines.dart';
import 'package:mymgs/data_classes/protobuf/magazines.pb.dart' hide TextStyle, Color;

typedef ImageCachingCallback = void Function(Image? cachedImageData);

class PublicationCard extends StatefulWidget {
  final Publication publication;
  final ImageCachingCallback? onTap;
  const PublicationCard({
    Key? key,
    required this.publication,
    this.onTap,
  });

  _PublicationCardState createState() => _PublicationCardState();
}

class _PublicationCardState extends State<PublicationCard> {
  late final Future<Edition> latestEditionFuture;
  @override
  void initState() {
    super.initState();
    latestEditionFuture = getLatestEdition(widget.publication.id);
  }

  @override
  Widget build(BuildContext context) {
    const height = 250.0;
    final publication = widget.publication;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: FutureBuilder<Edition>(
        future: latestEditionFuture,
        builder: (context, snapshot) {
          final edition = snapshot.data;

          return Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: parsePbColor(publication.theme.primaryColor),
                ),
              ),
              if (edition != null) Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: edition.coverImage.url,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: double.infinity,
                height: height,
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0x7E000000),
                      Color(0x00000000),
                    ]
                  ),
                ),
                child: publication.theme.hasLogo() ? CachedNetworkImage(
                  imageUrl: publication.theme.logo.url,
                ) : Text(
                  publication.title,
                  style: parsePbTextStyle(publication.theme.titleStyle).copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      widget.onTap?.call(edition?.coverImage);
                    },
                    splashColor: Colors.white.withOpacity(0.4),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
