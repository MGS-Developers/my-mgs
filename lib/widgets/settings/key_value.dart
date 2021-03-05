import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mymgs/data/settings.dart';

typedef TrackerMapper = String Function(dynamic value);

class KeyValueSetting extends StatelessWidget {
  final String name;
  final String? value;
  final String? description;

  final String? tracker;
  final Stream _stream;
  final TrackerMapper? trackerMapper;

  final VoidCallback onTap;

  KeyValueSetting({
    Key? key,
    required this.name,
    required this.onTap,
    this.value,
    this.description,
    this.tracker,
    this.trackerMapper,
  }) : _stream = watchSetting(tracker);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: description == null ? null : Text(description!),
      trailing: value != null ? Text(
        value!,
        style: Theme.of(context).textTheme.bodyText1,
      ) : tracker != null ? StreamBuilder(
        stream: _stream,
        builder: (BuildContext context, snapshot) {
          final data = snapshot.data;
          if (data == null) return const SizedBox();

          return Text(
            trackerMapper?.call(data) ?? data.toString(),
            style: Theme.of(context).textTheme.bodyText1,
          );
        }
      ) : null,
      onTap: onTap,
    );
  }
}
