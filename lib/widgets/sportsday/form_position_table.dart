import 'package:flutter/material.dart' hide Form;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data_classes/sportsday/form.dart';
import 'package:mymgs/data_classes/sportsday/score.dart';
import 'package:mymgs/screens/sportsday/form.dart';
import 'package:mymgs/widgets/sportsday/rank_highlight_row.dart';

class FormPositionTable<T> extends StatelessWidget {
  final List<T> data;
  final int Function(T item) getPosition;
  final int Function(T item) getPoints;
  final String Function(T item) getFormId;
  final bool isARace;
  final AbsoluteScore? Function(T item)? getAbsoluteScore;

  FormPositionTable({
    required this.data,
    required this.getPosition,
    required this.getPoints,
    required this.getFormId,
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

    return absoluteScore.value.toString() + (absoluteScore.units == RecordUnits.meters ? 'm' : 's');
  }

  void _openForm(BuildContext context, T node) {
    Form form;
    if (node is ScoreNode) {
      form = Form.fromID(node.formId);
    } else if (node is FormWithPoints) {
      form = node;
    } else {
      throw Exception("T is of unknown type; cannot launch form");
    }

    Navigator.of(context).push(platformPageRoute(
      context: context,
      builder: (_) => SportsDayForm(form: form),
    ));
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
                isZero: getPoints(form) == 0,
                cells: [
                  DataCell(Text(Form.humaniseID(getFormId(form)))),
                  DataCell(Text(getPoints(form).toString())),
                  if (isARace) DataCell(Text(_getCompetitorName(form) ?? '')),
                  if (isARace) DataCell(Text(_getStringAbsoluteValue(form) ?? '')),
                ],
                onTap: () {
                  _openForm(context, form);
                },
              ),
          ],
        ),
      ),
    );
  }
}
