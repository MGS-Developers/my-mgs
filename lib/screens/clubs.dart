import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mymgs/data/clubs.dart';
import 'package:mymgs/data/setup.dart';
import 'package:mymgs/data_classes/club.dart';
import 'package:mymgs/data_classes/club_time.dart';
import 'package:mymgs/widgets/drawer_app_bar.dart';
import 'package:mymgs/widgets/spinner.dart';

class Clubs extends StatefulWidget {
  const Clubs();

  _ClubsState createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  Future<List<Club>> clubsFuture;
  //Stored the day currently selected by the user. First value in the DayOfWeek enum by default (currently Monday)
  DayOfWeek selectedDay = DayOfWeek.values.first;

  // https://stackoverflow.com/a/52300307/9043010
  @override
  void initState() {
    super.initState();
    // this function gets which year group the user has said they're in
    getYearGroup().then((value) {
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
        //When the class is initialised a Future<List<Club>> is commenced, which will make a database query and return a list of clubs depending on the user's yeargroup
        future: clubsFuture,
        builder: (BuildContext context, snapshot) {
          // TODO: add code for GitHub issue #1 here
          // refer to FutureBuilder docs for the contents of 'snapshot'
          // snapshot.data will only be populated once the request completes, and it will be null otherwise — make sure to implement loading based on snapshot.connectionState
          // once populated, snapshot.data will contain a `List` of `Club` class instances
          // refer to this doc for how to make lists for data: https://flutter.dev/docs/cookbook/lists/long-lists#2-convert-the-data-source-into-widgets

          if (snapshot.connectionState != ConnectionState.done) {
            //Checks the status of the future. If the value has not yet been returned then the Spinner Widget is displayed
            return new Center(child: new Spinner());
          } else if (snapshot.hasError || snapshot.data == null) {
            //Checks for errors and null. A list of clubs is now safe and ready to use.
            return new Text("An error occurred");
          }
          //This is the outmost container and makes sure that the list of clubs isn't pressing against the sides of the screen
          return new Container(
            //This column stores the dropdown widget and the container for the scrollable list
            //The Expanded widgets are so we can have a fixed ratio (1:8 at time of writing) between the dropdown box and scrollable list.
            //This ensures that the app looks the same, no matter the device (hopefully, haven't tested)
            child: new Column(
              //I don't know why mainAxisSize is here or what is does.
              mainAxisSize: MainAxisSize.max,
              children: [
                new Expanded(
                  //Expanded widget holding the dropdown menu
                  flex: 1,
                  child: new DropdownButton<DayOfWeek>(
                      items: DayOfWeek.values
                          .map((day) => DropdownMenuItem(
                                child: Text(describeEnum(day)),
                                value: day,
                              ))
                          .toList(),
                      value: selectedDay,
                      onChanged: (DayOfWeek newValue) {
                        setState(() {
                          selectedDay = newValue;
                        });
                      }),
                ),
                new Expanded(
                    flex: 8,
                    child: new Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          border: Border(
                              left: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 4),
                              right: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 4))),
                      margin: EdgeInsets.all(15),
                      child: () {
                        List<Club> filteredList =
                            filterForDay(snapshot.data, selectedDay);
                        Widget scrollbar = Scrollbar(
                            child: new ListView(children: [
                          ...filteredList
                              .map((club) => new Container(
                                  margin: EdgeInsets.all(25),
                                  decoration: new BoxDecoration(
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Theme.of(context).primaryColor),
                                  child: Column(children: [
                                    new Text(club.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            fontSize: 20)),
                                    new Text(
                                      club.time.getDisplayTime(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontSize: 16),
                                    )
                                  ])))
                              .toList(),
                        ]));
                        Widget emptyText = new Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: new Text(
                              "There are no clubs for your year on this day",
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.center,
                            ));

                        if (filteredList.isEmpty) {
                          return emptyText;
                        }
                        return scrollbar;
                      }(),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }

  List<Club> filterForDay(List<Club> clubs, DayOfWeek day) {
    List<Club> returnList = new List<Club>();
    for (Club club in clubs) {
      if (club.time.dayOfWeek == day) {
        returnList.add(club);
      }
    }
    return returnList;
  }
}
