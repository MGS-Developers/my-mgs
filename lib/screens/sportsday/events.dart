import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/sportsday/metadata.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/screens/sportsday/event_group.dart';
import 'package:mymgs/widgets/spinner.dart';

class SportsDayEvents extends StatelessWidget {
  final eventsFuture = getEventGroups();
  SportsDayEvents();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<EventGroup>>(
        future: eventsFuture,
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data == null) {
            return Center(
              child: Spinner(),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final eventGroup = data[index];
              return ListTile(
                title: Text(eventGroup.name),
                onTap: () {
                  Navigator.of(context).push(platformPageRoute(
                    context: context,
                    builder: (_) => SportsDayEvent(eventGroup: eventGroup),
                  ));
                },
              );
            },
          );
        },
      ),
    );
  }
}