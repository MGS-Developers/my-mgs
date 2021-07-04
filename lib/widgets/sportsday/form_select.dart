import 'package:flutter/material.dart' hide Form;
import 'package:mymgs/data/sportsday/metadata.dart';
import 'package:mymgs/data_classes/sportsday/form.dart';
import 'package:mymgs/widgets/shimmer/sized_shimmer.dart';

typedef FormCallback = void Function(Form form);

class FormSelect extends StatefulWidget {
  final formsFuture = getSportsdayForms();
  final FormCallback onChange;
  FormSelect({
    required this.onChange,
  });

  _FormSelectState createState() => _FormSelectState();
}

class _FormSelectState extends State<FormSelect> {
  int? yearGroup = 7;
  Form? form;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<int, List<Form>>>(
      future: widget.formsFuture,
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data == null || data.length == 0) {
          return SizedShimmer(height: 40);
        }

        final _sortedKeys = data.keys.toList()..sort((a, b) => a - b);
        final _year = yearGroup;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<int>(
              hint: Text("Year group"),
              value: yearGroup,
              onChanged: (_yearGroup) {
                setState(() {
                  yearGroup = _yearGroup;
                  form = null;
                });
              },
              items: _sortedKeys.map((key) => DropdownMenuItem(
                value: key,
                child: Text("Year $key"),
              )).toList(),
            ),

            if (_year != null) DropdownButton<String>(
              hint: Text("Form"),
              onChanged: (_formId) {
                final _form = data[_year]!.firstWhere((e) => e.id == _formId);
                widget.onChange(_form);
                setState(() {
                  form = _form;
                });
              },
              value: form?.id,
              items: data[_year]!.map((form) => DropdownMenuItem(
                child: Text(form.humanID),
                value: form.id,
              )).toList(),
            ),
          ],
        );
      },
    );
  }
}
