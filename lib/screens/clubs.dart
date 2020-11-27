import 'package:flutter/material.dart';
import 'package:mymgs/data/clubs.dart';
import 'package:mymgs/data/setup.dart';
import 'package:mymgs/data_classes/club.dart';
import 'package:mymgs/widgets/drawer_app_bar.dart';

class Clubs extends StatefulWidget {
  const Clubs();
  _ClubsState createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  Future<List<Club>> clubsFuture;

  // https://stackoverflow.com/a/52300307/9043010
  @override
  void initState() {
    super.initState();
    // this function gets which year group the user has said they're in
    getYearGroup()
      .then((value) {
        // once we've found out, we need to update the `clubsFuture` state variable with a call to `getClubs`, passing in the year group
        // see the `getClubs` function for how this filtering works
        setState(() {
          clubsFuture = getClubs(yearGroup: value);
        });
      });
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
          // once populated, snapshot.data will contain a `List` of `Club` class instances
          // refer to this doc for how to make lists for data: https://flutter.dev/docs/cookbook/lists/long-lists#2-convert-the-data-source-into-widgets
          return SizedBox();
        },
      ),
    );
  }
}