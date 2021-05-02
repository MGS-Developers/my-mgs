import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymgs/data/magazines.dart';
import 'package:mymgs/data_classes/protobuf/magazines.pb.dart' hide TextStyle;
import 'package:mymgs/widgets/magazines/edition_card.dart';
import 'package:mymgs/widgets/spinner.dart';

class SeasonSlider extends StatefulWidget {
  final Season season;
  final Publication publication;
  final PublicationTheme theme;

  const SeasonSlider({
    required this.season,
    required this.theme,
    required this.publication,
  });
  _SeasonSliderState createState() => _SeasonSliderState();
}

class _SeasonSliderState extends State<SeasonSlider> {
  late final Future<List<Edition>> editionsFuture;
  @override
  void initState() {
    super.initState();
    editionsFuture = getEditions(widget.season.publicationId, widget.season.id);
  }

  @override
  Widget build(BuildContext context) {
    const cardHeight = 160.0;

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(15).copyWith(top: 25),
            child: Text(
              "Series " + widget.season.sequenceNumber.toString(),
              style: GoogleFonts.getFont(widget.theme.headingStyle.font, textStyle: TextStyle(
                fontSize: 20,
              )),
            )
          ),
          FutureBuilder<List<Edition>>(
            future: editionsFuture,
            builder: (context, snapshot) {
              final editions = snapshot.data;
              if (editions == null) {
                return Padding(
                  padding: EdgeInsets.all(15),
                  child: Spinner(),
                );
              }

              return SizedBox(
                height: cardHeight,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  scrollDirection: Axis.horizontal,
                  itemCount: editions.length,
                  itemBuilder: (context, index) {
                    final edition = editions[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: EditionCard(
                        edition: edition,
                        theme: widget.theme,
                        height: cardHeight,
                        publication: widget.publication,
                        season: widget.season,
                      ),
                    );
                  }
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
