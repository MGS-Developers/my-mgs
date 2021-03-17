import 'package:flutter/material.dart' hide Form;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data_classes/sportsday/form.dart';
import 'package:mymgs/screens/sportsday/form.dart';
import 'package:mymgs/widgets/sportsday/rank_highlight_row.dart';

class FormPositionTable<T> extends StatelessWidget {
  final List<T> data;
  final int Function(T item) getPosition;
  final String Function(T item) getFormName;
  final int Function(T item) getPoints;
  final Form Function(T item) getForm;

  FormPositionTable({
    required this.data,
    required this.getPosition,
    required this.getFormName,
    required this.getPoints,
    required this.getForm,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      showCheckboxColumn: false,
      columns: const [
        DataColumn(
            label: Text("Position"),
            numeric: true
        ),
        DataColumn(label: Text("Form")),
        DataColumn(label: Text("Points")),
      ],
      rows: [
        for (final form in data)
          RankHighlightRow(
            context: context,
            rank: getPosition(form),
            cells: [
              DataCell(Text(getFormName(form))),
              DataCell(Text(getPoints(form).toString())),
            ],
            onTap: () {
              Navigator.of(context).push(platformPageRoute(
                context: context,
                builder: (_) => SportsDayForm(form: getForm(form)),
              ));
            }
          ),
      ]
    );
  }
}