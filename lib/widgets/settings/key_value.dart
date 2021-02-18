import 'package:flutter/material.dart';

class KeyValueSetting extends StatelessWidget {
  final String name;
  final String value;
  final String description;
  final VoidCallback onTap;

  const KeyValueSetting({
    Key key,
    @required this.name,
    @required this.onTap,
    this.value,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: description == null ? null : Text(description),
      trailing: value == null ? null : Text(
        value,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      onTap: onTap,
    );
  }
}