import 'package:flutter/material.dart';

class GroupedListSeparator extends StatelessWidget {
  final String label;
  final bool contrastBackground;
  const GroupedListSeparator({
    required this.label,
    this.contrastBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: contrastBackground ? Theme.of(context).primaryColorDark : Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}