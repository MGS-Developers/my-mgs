import 'package:flutter/material.dart';
import 'package:mymgs/data/magazines.dart';
import 'package:mymgs/data_classes/protobuf/magazines.pbserver.dart';
import 'package:mymgs/widgets/magazines/edition_cover.dart';
import 'package:mymgs/widgets/magazines/section_banner.dart';
import 'package:mymgs/widgets/spinner.dart';

class MagazineEdition extends StatefulWidget {
  final Edition edition;
  final PublicationTheme theme;
  final Publication publication;
  final Season season;
  const MagazineEdition({
    Key? key,
    required this.edition,
    required this.theme,
    required this.publication,
    required this.season,
  });

  _MagazineEditionState createState() => _MagazineEditionState();
}

class _MagazineEditionState extends State<MagazineEdition> {
  late final sectionsFuture = getSections(widget.publication.id, widget.season.id, widget.edition.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            EditionCover(edition: widget.edition, theme: widget.theme, publicationTitle: widget.publication.title),
            const SizedBox(height: 0),
            FutureBuilder<List<Section>>(
              future: sectionsFuture,
              builder: (context, snapshot) {
                final sections = snapshot.data;
                if (sections == null) {
                  return Padding(
                    padding: EdgeInsets.all(15),
                    child: Spinner(),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.only(top: 15),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    final section = sections[index];

                    return Padding(
                      child: SectionBanner(
                        theme: widget.theme,
                        section: section,
                        editionId: widget.edition.id,
                        seasonId: widget.season.id,
                        publicationId: widget.publication.id,
                      ),
                      padding: EdgeInsets.only(bottom: 20),
                    );
                  }
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
