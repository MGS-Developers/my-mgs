import 'package:flutter/material.dart';
import 'package:mymgs/data/clubs.dart';
import 'package:mymgs/data/setup.dart';
import 'package:mymgs/data_classes/club.dart';
import 'package:mymgs/data_classes/club_time.dart';
import 'package:mymgs/helpers/enum_helpers.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/widgets/clubs/club_card.dart';
import 'package:mymgs/widgets/drawer/drawer_app_bar.dart';
import 'package:mymgs/widgets/spinner.dart';

class Clubs extends StatefulWidget {
  const Clubs();

  _ClubsState createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  Future<List<Club>>? clubsFuture;

  // https://stackoverflow.com/a/52300307/9043010
  @override
  void initState() {
    // this function gets which year group the user has said they're in
    getYearGroup().then((value) {
      // once we've found out, we need to update the `clubsFuture` state variable with a call to `getClubs`, passing in the year group
      // see the `getClubs` function for how this filtering works
      setState(() {
        clubsFuture = getClubs(yearGroup: value);
      });
    });

    super.initState();
  }

  List<Club> filterForDay(List<Club> clubs, DayOfWeek day) {
    List<Club> returnList = [];
    for (Club club in clubs) {
      if (club.time.dayOfWeek == day) {
        returnList.add(club);
      }
    }
    return returnList;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: DayOfWeek.values.length,
      child: Scaffold(
        appBar: DrawerAppBar(
          'Clubs',
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              for (final day in DayOfWeek.values) Tab(text: EnumHelper.getStringValue(day))
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive(context).horizontalListPadding,
          ),
          width: double.infinity,
          child: FutureBuilder<List<Club>>(
            //When the class is initialised a Future<List<Club>> is commenced, which will make a database query and return a list of clubs depending on the user's yeargroup
            future: clubsFuture,
            builder: (BuildContext context, snapshot) {
              // refer to FutureBuilder docs for the contents of 'snapshot'
              // snapshot.data will only be populated once the request completes, and it will be null otherwise — make sure to implement loading based on snapshot.connectionState
              // once populated, snapshot.data will contain a `List` of `Club` class instances
              // refer to this doc for how to make lists for data: https://flutter.dev/docs/cookbook/lists/long-lists#2-convert-the-data-source-into-widgets

              final data = snapshot.data;
              if (snapshot.connectionState != ConnectionState.done) {
                //Checks the status of the future. If the value has not yet been returned then the Spinner Widget is displayed
                return Center(child: Spinner());
              } else if (snapshot.hasError || data == null) {
                //Checks for errors and null. A list of clubs is now safe and ready to use.
                return Text("An error occurred");
              }

              return TabBarView(
                children: [
                  for (final day in DayOfWeek.values)
                    Builder(
                      builder: (context) {
                        final filteredList = filterForDay(data, day);
                        if (filteredList.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "There are no clubs for your year on this day",
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shrinkWrap: true,
                            itemCount: filteredList.length,
                            itemBuilder: (context, index) {
                              final club = filteredList[index];
                              return ClubCard(club: club);
                            },
                          );
                        }
                      },
                    ),
                ],
              );

            },
          ),
        ),
      ),
    );
  }
}
