import 'package:flutter/material.dart';
import 'package:mymgs/widgets/sportsday/rank_highlight_row.dart';

class StatisticContainer extends StatelessWidget {
  final String? label;
  final int? rank;
  final String? value;
  const StatisticContainer({
    this.label,
    this.rank,
    this.value,
  }) : assert(value != null || rank != null);

  @override
  Widget build(BuildContext context) {
    final _rank = rank;
    Color _color = _rank != null ? getRankColor(context, _rank) : Colors.transparent;
    if (_color == Colors.transparent) {
      _color = MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.white : Colors.black;
    }

    String? _value = value;
    if (_rank != null) {
      _value = _rank.toString();
    }

    return Material(
      elevation: 2,
      color: _color,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label != null) Text(
              label!,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              _value!,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
