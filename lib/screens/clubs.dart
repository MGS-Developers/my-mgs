import 'package:flutter/material.dart';
import 'package:mymgs/data/clubs.dart';
import 'package:mymgs/data_classes/club.dart';
import 'package:mymgs/widgets/drawer_app_bar.dart';

class Clubs extends StatefulWidget {
  const Clubs();
  _ClubsState createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  Future<List<Club>> clubsFuture = getClubs();

  // https://stackoverflow.com/a/52300307/9043010
  @override
  void initState() {
    super.initState();
    // TODO: add logic here to get stored year group to filter clubs by
    // consider using one of these two: https://pub.dev/packages/shared_preferences or https://pub.dev/packages/hive (pal recommends the latter — much faster)
    // TODO: then, use setState() to update the `clubsFuture` Future with a new call to `getClub`, passing in the year group as an optional named parameter
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerAppBar('Clubs'),
      body: FutureBuilder<List<Club>>(
        future: clubsFuture,
        builder: (BuildContext context, snapshot) {
          // TODO: add code for GitHub issue #1 here
          // refer to FutureBuilder docs for the contents of 'snapshot'
          // snapshot.data will only be populated once the request completes, and it will be null otherwise — make sure to implement loading based on snapshot.connectionState
          return SizedBox();
        },
      ),
    );
  }
}