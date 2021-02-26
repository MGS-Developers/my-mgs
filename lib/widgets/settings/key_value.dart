import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mymgs/data/local_database.dart';
import 'package:mymgs/data/settings.dart';

typedef TrackerMapper = String Function(dynamic value);

class KeyValueSetting extends StatelessWidget {
  final String name;
  final String value;
  final String description;

  final String tracker;
  final TransformedStreamController _streamController;
  final TrackerMapper trackerMapper;

  final VoidCallback onTap;

  KeyValueSetting({
    Key key,
    @required this.name,
    @required this.onTap,
    this.value,
    this.description,
    this.tracker,
    this.trackerMapper,
  }) : _streamController = watchSetting(tracker);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: description == null ? null : Text(description),
      trailing: value != null ? Text(
        value,
        style: Theme.of(context).textTheme.bodyText1,
      ) : tracker != null ? StreamBuilder(
        stream: _streamController.streamController.stream,
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) return const SizedBox();

          return Text(
            trackerMapper(snapshot.data),
            style: Theme.of(context).textTheme.bodyText1,
          );
        }
      ) : null,
      onTap: onTap,
    );
  }
}