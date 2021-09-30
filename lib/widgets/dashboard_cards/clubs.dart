import 'package:flutter/material.dart';
import 'package:mymgs/data/clubs.dart';
import 'package:mymgs/data/setup.dart';
import 'package:mymgs/data_classes/club.dart';
import 'package:mymgs/screens/main_navigation.dart';
import 'package:mymgs/widgets/clubs/club_card.dart';
import 'package:mymgs/widgets/dashboard_cards/dashboard_card.dart';

import '../spinner.dart';

class ClubsCard extends StatelessWidget {
  final Future<List<Club>> clubsFuture;
  ClubsCard({
    Key? key,
  }) : clubsFuture = getYearGroup().then((y) => getClubs(
    yearGroup: y,
    todayOnly: true,
    limit: 3,
  ));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Club>>(
      future: clubsFuture,
      builder: (context, snapshot) {
        bool loading = false;
        bool failed = false;

        final data = snapshot.data;

        if (snapshot.connectionState == ConnectionState.waiting) {
          loading = true;
        } else if (snapshot.hasError || data?.length == 0) {
          failed = true;
        }

        return DashboardCard(
          title: "Clubs",
          onPressed: () {
            DrawerSwitcher.of(context)?.switchTo("clubs");
          },
          children: [
            if (loading) Spinner(),
            if (failed) Text(
              'No clubs today.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            if (!failed && !loading && data != null)
              for (final club in data)
                ClubCard(club: club)
          ]
        );
      }
    );
  }
}