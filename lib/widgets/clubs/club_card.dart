import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data_classes/club.dart';
import 'package:mymgs/screens/clubs/club.dart';
import 'package:mymgs/widgets/clubs/club_logistics.dart';

class ClubCard extends StatelessWidget {
  final Club club;
  const ClubCard({
    required this.club,
  });

  @override
  Widget build(BuildContext context) {
    final description = club.description;

    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(platformPageRoute(
              context: context,
              builder: (_) => ClubScreen(
                club: club,
              ),
            ));
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  club.name,
                  style: Theme.of(context).textTheme.headline6,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (description != null) Text(
                  description,
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                ClubLogistics(club: club),
              ],
            ),
          ),
        ),
      ),
    );
  }
}