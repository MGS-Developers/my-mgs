import 'package:flutter/material.dart';
import 'package:mymgs/helpers/responsive.dart';
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
    var _color = _rank != null ? getRankColor(context, _rank) : null;
    if (_color == null) {
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
          horizontal: Responsive(context).horizontalPadding,
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
