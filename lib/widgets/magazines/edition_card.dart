import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymgs/data_classes/protobuf/magazines.pb.dart' hide Color, TextStyle;

class EditionCard extends StatelessWidget {
  final Edition edition;
  final PublicationTheme theme;
  final double height;
  const EditionCard({
    required this.edition,
    required this.theme,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: edition.coverImage.url,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0x3B000000),
                    Colors.transparent,
                  ],
                ),
              ),
            )
          ),
          SizedBox(
            height: height,
            width: 120,
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.bottomLeft,
              child: Text(
                edition.title,
                style: GoogleFonts.getFont(theme.titleStyle.font, textStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                )),
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {

                },
                splashColor: Colors.white.withOpacity(0.3),
              ),
            )
          ),
        ],
      ),
    );
  }
}
