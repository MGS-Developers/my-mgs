import 'package:flutter/material.dart' hide Form;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data_classes/sportsday/form.dart';
import 'package:mymgs/data_classes/sportsday/score.dart';
import 'package:mymgs/screens/sportsday/form.dart';
import 'package:mymgs/widgets/sportsday/rank_highlight_row.dart';

class FormPositionTable<T> extends StatelessWidget {
  final List<T> data;
  final int Function(T item) getPosition;
  final String Function(T item) getFormName;
  final int Function(T item) getPoints;
  final Form Function(T item) getForm;
  final bool isARace;
  final AbsoluteScore? Function(T item)? getAbsoluteScore;

  FormPositionTable({
    required this.data,
    required this.getPosition,
    required this.getFormName,
    required this.getPoints,
    required this.getForm,
    this.getAbsoluteScore,
    this.isARace = false,
  });

  AbsoluteScore? _getAbsoluteScore(T form) {
    final _get = getAbsoluteScore;
    if (_get == null) {
      return null;
    } else {
      return _get(form);
    }
  }

  String? _getCompetitorName(T form) {
    final absoluteScore = _getAbsoluteScore(form);
    return absoluteScore?.competitorName;
  }

  String? _getStringAbsoluteValue(T form) {
    final absoluteScore = _getAbsoluteScore(form);
    if (absoluteScore == null) {
      return null;
    }

    return absoluteScore.value.toString() + (absoluteScore.units == Units.meters ? 'm' : 's');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: DataTable(
          showCheckboxColumn: false,
          columns: [
            DataColumn(
                label: Text("Position"),
                numeric: true
            ),
            DataColumn(label: Text("Form")),
            DataColumn(label: Text("Points")),
            if (isARace) DataColumn(label: Text("Name")),
            if (isARace) DataColumn(label: Text("Score")),
          ],
          rows: [
            for (final form in data)
              RankHighlightRow(
                  context: context,
                  rank: getPosition(form),
                  cells: [
                    DataCell(Text(getFormName(form))),
                    DataCell(Text(getPoints(form).toString())),
                    if (isARace) DataCell(Text(_getCompetitorName(form) ?? '')),
                    if (isARace) DataCell(Text(_getStringAbsoluteValue(form) ?? '')),
                  ],
                  onTap: () {
                    Navigator.of(context).push(platformPageRoute(
                      context: context,
                      builder: (_) => SportsDayForm(form: getForm(form)),
                    ));
                  }
              ),
          ],
        ),
      ),
    );
  }
}