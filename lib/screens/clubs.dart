import 'package:flutter/material.dart';
import 'package:mymgs/data/clubs.dart';
import 'package:mymgs/data/setup.dart';
import 'package:mymgs/data_classes/club.dart';
import 'package:mymgs/data_classes/club_time.dart';
import 'package:mymgs/helpers/enum_helpers.dart';
import 'package:mymgs/widgets/clubs/club_card.dart';
import 'package:mymgs/widgets/drawer/drawer_app_bar.dart';
import 'package:mymgs/widgets/spinner.dart';

class Clubs extends StatefulWidget {
  const Clubs();

  _ClubsState createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  Future<List<Club>>? clubsFuture;

  //Stored the day currently selected by the user. First value in the DayOfWeek enum by default (currently Monday)
  DayOfWeek selectedDay = DayOfWeek.values[DateTime.now().weekday - 1];

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
    return Scaffold(
      appBar: DrawerAppBar('Clubs'),
      body: Container(
        padding: const EdgeInsets.only(
          top: 15,
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

            final List<Club> filteredList = filterForDay(data, selectedDay);

            //This column stores the dropdown widget and the container for the scrollable list
            //The Expanded widgets are so we can have a fixed ratio (1:8 at time of writing) between the dropdown box and scrollable list.
            //This ensures that the app looks the same, no matter the device (hopefully, haven't tested)
            return Column(
              children: [
                //Expanded widget holding the dropdown menu
                DropdownButton<DayOfWeek>(
                  dropdownColor: Theme.of(context).backgroundColor,
                  items: DayOfWeek.values.map((day) => DropdownMenuItem(
                    child: Text(EnumHelper.getStringValue(day)),
                    value: day,
                  )).toList(),
                  value: selectedDay,
                  onChanged: (DayOfWeek? newValue) {
                    if (newValue == null) return;
                    setState(() {
                      selectedDay = newValue;
                    });
                  },
                ),
                if (filteredList.isEmpty)
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "There are no clubs for your year on this day",
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (filteredList.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 10),
                      shrinkWrap: true,
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final club = filteredList[index];
                        return ClubCard(club: club);
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
