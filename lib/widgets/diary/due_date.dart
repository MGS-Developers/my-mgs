import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jiffy/jiffy.dart';

typedef DateCallback = void Function(DateTime newDate);

class DueDate extends StatelessWidget {
  final DateTime selectedDate;
  final DateCallback dateCallback;

  const DueDate({
    Key key,
    @required this.selectedDate,
    @required this.dateCallback,
  });

  void _showDatePicker(BuildContext context) async {
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.utc(3000),
    );

    if (newDate != null) {
      dateCallback(newDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformTextField(
      readOnly: true,
      controller: TextEditingController.fromValue(TextEditingValue(
        text: Jiffy(selectedDate).yMMMEd,
      )),
      onTap: () {
        _showDatePicker(context);
      },
      material: (_, __) => MaterialTextFieldData(
        decoration: InputDecoration(
          labelText: "Due date",
        ),
      ),
      cupertino: (_, __) => CupertinoTextFieldData(
        placeholder: "Due date",
      ),
    );
  }
}