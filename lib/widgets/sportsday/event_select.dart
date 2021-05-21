import 'package:flutter/material.dart';
import 'package:mymgs/data/sportsday/all_events.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/widgets/shimmer_builder.dart';

typedef Callback = void Function(EventGroup eventGroup);

class EventSelect extends StatelessWidget {
  final eventGroupsFuture = getEventGroups();
  final EventGroup? selectedEventGroup;
  final Callback onChange;
  EventSelect({
    Key? key,
    this.selectedEventGroup,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EventGroup>>(
      future: eventGroupsFuture,
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data == null) {
          return SizedShimmer(height: 40);
        }

        data.sort((a, b) => a.name.compareTo(b.name));
        return DropdownButton<EventGroup>(
          value: selectedEventGroup,
          onChanged: (_selected) {
            if (_selected != null) {
              onChange(_selected);
            }
          },
          items: data.map((eventGroup) => DropdownMenuItem(
            value: eventGroup,
            child: Text(eventGroup.name),
          )).toList(),
        );
      },
    );
  }
}
