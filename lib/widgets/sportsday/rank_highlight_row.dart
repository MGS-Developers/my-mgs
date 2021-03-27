import 'package:flutter/material.dart';

Color getRankColor(BuildContext context, int rank) {
  final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
  switch(rank) {
    case 1: return dark ? Color(0xFF88751d) : Color(0xFFffd700);
    case 2: return dark ? Color(0xFF646464) : Color(0xFFc0c0c0);
    case 3: return dark ? Color(0xff804d17) : Color(0xffe99545);
    default: return Colors.transparent;
  }
}

class RankHighlightRow extends DataRow {
  final int rank;
  final VoidCallback? onTap;
  RankHighlightRow({
    required this.rank,
    required List<DataCell> cells,
    this.onTap,
    required BuildContext context,
  }) : super(
    cells: [
      DataCell(Text(
        rank.toString(),
        style: TextStyle(
          fontWeight: rank <= 3 ? FontWeight.bold : FontWeight.normal,
        ),
      )),
      ...cells,
    ],
    color: MaterialStateProperty.all(getRankColor(context, rank)),
    onSelectChanged: (_) {
      onTap?.call();
    }
  );
}
