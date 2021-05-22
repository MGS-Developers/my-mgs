import 'package:flutter/material.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/helpers/sportsday.dart';

typedef Callback = void Function(int subEvent);

class SubeventSelect extends StatefulWidget {
  final EventGroup eventGroup;
  final Callback onChange;
  const SubeventSelect({
    required this.eventGroup,
    required this.onChange,
  });

  _SubeventSelectState createState() => _SubeventSelectState();
}

class _SubeventSelectState extends State<SubeventSelect> {
  int? subEvent;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      onChanged: (_subEvent) {
        setState(() {
          subEvent = _subEvent;
        });
        if (_subEvent != null) {
          widget.onChange(_subEvent);
        }
      },
      value: subEvent,
      items: List.generate(widget.eventGroup.subEventCount, (index) => DropdownMenuItem(
        value: index,
        child: Text('Race ' + subEventToString(index)),
      )),
    );
  }
}
