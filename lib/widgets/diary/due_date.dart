import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/widgets/date_picker.dart';
import 'package:mymgs/widgets/text_field.dart';

typedef DateCallback = void Function(DateTime newDate);

class DueDate extends StatelessWidget {
  final DateTime selectedDate;
  final DateCallback dateCallback;

  const DueDate({
    Key? key,
    required this.selectedDate,
    required this.dateCallback,
  });

  void _showDatePicker(BuildContext context) async {
    final DateTime? newDate = await showDateTimePicker(
      context: context,
      mode: DateTimePickerMode.date,
      initialDateTime: selectedDate,
      minDateTime: DateTime.now().subtract(Duration(hours: DateTime.now().hour)),
    );

    if (newDate != null) {
      dateCallback(newDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MGSTextField(
      readOnly: true,
      controller: TextEditingController.fromValue(TextEditingValue(
        text: Jiffy(selectedDate).yMMMEd,
      )),
      onTap: () {
        _showDatePicker(context);
      },
      label: "Due date",
    );
  }
}