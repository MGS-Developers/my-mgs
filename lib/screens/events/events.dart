import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data/events.dart';
import 'package:mymgs/data/setup.dart';
import 'package:mymgs/data_classes/event.dart';
import 'package:mymgs/widgets/drawer_app_bar.dart';
import 'package:mymgs/widgets/events/event_card.dart';
import 'package:mymgs/widgets/grouped_list_separator.dart';
import 'package:mymgs/widgets/spinner.dart';

class Events extends StatefulWidget {
  const Events();
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  Future<List<Event>> _eventsFuture;

  @override
  void initState() {
    super.initState();

    getYearGroup()
    .then((yearGroup) {
      setState(() {
        _eventsFuture = getEvents(
          yearGroup: yearGroup,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerAppBar('Talks & events'),
      body: Builder(
        builder: (context) {
          if (_eventsFuture == null) return Container();

          return FutureBuilder<List<Event>>(
            future: _eventsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Spinner(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Something went wrong.",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data.length == 0) {
                return Center(
                  child: Text(
                    "No events found.",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                );
              }

              return GroupedListView<Event, String>(
                elements: snapshot.data,
                groupBy: (e) => Jiffy(e.startTime.toDate()).yMMMEd,
                itemBuilder: (context, event) {
                  return EventCard(event: event);
                },
                groupSeparatorBuilder: (date) => GroupedListSeparator(label: date),
              );
            }
          );
        },
      )
    );
  }
}