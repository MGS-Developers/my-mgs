import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data/events.dart';
import 'package:mymgs/data/setup.dart';
import 'package:mymgs/data_classes/event.dart';
import 'package:mymgs/screens/events/event_screen.dart';
import 'package:mymgs/widgets/events/event_card.dart';
import 'package:mymgs/widgets/grouped_list_separator.dart';
import 'package:mymgs/widgets/master_detail.dart';
import 'package:mymgs/widgets/spinner.dart';

class Events extends StatefulWidget {
  const Events();
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  Future<List<Event>>? _eventsFuture;

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
    if (_eventsFuture == null) return SizedBox();

    return FutureBuilder<List<Event>>(
      future: _eventsFuture,
      builder: (context, snapshot) {
        final data = snapshot.data;

        return MasterDetailScreen(
          masterTitle: 'Talks & events',
          masterWidth: 350,
          useDrawerAppBar: true,
          masterBuilder: (context, selectedIndex, onTap) {
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

            if (data == null || data.length == 0) {
              return Center(
                child: Text(
                  "No events found.",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              );
            }

            return GroupedListView<Event, String>(
              padding: EdgeInsets.only(bottom: 20),
              elements: data,
              groupBy: (e) => Jiffy(e.startTime.toDate()).yMMMEd,
              itemBuilder: (context, event) {
                final index = data.indexOf(event);
                return EventCard(
                  key: Key(event.id),
                  event: event,
                  onTap: (heroKey) => onTap(index, heroKey),
                  selected: index == selectedIndex,
                );
              },
              groupSeparatorBuilder: (date) => GroupedListSeparator(label: date),
            );
          },
          detailBuilder: (context, selectedIndex, isNewScreen, [heroKey]) {
            if (data == null) return SizedBox();
            return EventScreen(
              event: data[selectedIndex],
              showAppBar: isNewScreen,
              heroKey: heroKey,
            );
          },
        );
      },
    );
  }
}
