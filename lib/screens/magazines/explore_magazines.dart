import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/magazines.dart';
import 'package:mymgs/data_classes/protobuf/magazines.pb.dart';
import 'package:mymgs/helpers/gridview_cross_count.dart';
import 'package:mymgs/screens/magazines/publication.dart';
import 'package:mymgs/widgets/drawer/drawer_app_bar.dart';
import 'package:mymgs/widgets/magazines/publication_card.dart';
import 'package:mymgs/widgets/spinner.dart';

class ExploreMagazines extends StatefulWidget {
  const ExploreMagazines();
  _ExploreMagazinesState createState() => _ExploreMagazinesState();
}

class _ExploreMagazinesState extends State<ExploreMagazines> {
  final publicationsFuture = getPublications();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerAppBar("Magazines"),
      body: FutureBuilder<List<Publication>>(
        future: publicationsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text("Something went wrong."),
            );
          }

          final data = snapshot.data;
          if (data == null) {
            return Center(
              child: Spinner(),
            );
          }

          final crossCount = getGridViewCrossCount(MediaQuery.of(context).size.width);
          return GridView.count(
            padding: const EdgeInsets.all(15),
            crossAxisCount: crossCount,
            children: [
              for (final publication in data)
                PublicationCard(
                  publication: publication,
                  onTap: (cachedImageData) {
                    Navigator.of(context).push(platformPageRoute(
                      context: context,
                      builder: (_) => PublicationScreen(
                        publication: publication,
                        cachedImageData: cachedImageData,
                      ),
                    ));
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
