import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum DateTimePickerMode {
  date,
  time,
  dateTime,
}

Future<DateTime?> showDateTimePicker({
  required BuildContext context,
  required DateTimePickerMode mode,
  DateTime? initialDateTime,
  DateTime? minDateTime,
  DateTime? maxDateTime,
}) async {
  DateTime? selectedDate;

  if (!kIsWeb && Platform.isIOS) {
    CupertinoDatePickerMode pickerMode;
    switch (mode) {
      case DateTimePickerMode.date:
        pickerMode = CupertinoDatePickerMode.date;
        break;
      case DateTimePickerMode.time:
        pickerMode = CupertinoDatePickerMode.time;
        break;
      case DateTimePickerMode.dateTime:
        pickerMode = CupertinoDatePickerMode.dateAndTime;
        break;
    }

    await showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        clipBehavior: Clip.antiAlias,
        height: 300,
        child: CupertinoDatePicker(
          mode: pickerMode,
          initialDateTime: initialDateTime,
          minimumDate: minDateTime,
          maximumDate: maxDateTime,
          onDateTimeChanged: (_newDate) {
            selectedDate = _newDate;
          },
        ),
      ),
    );
  } else {
    if (mode == DateTimePickerMode.time) {
      TimeOfDay _initialTime = TimeOfDay.now();
      if (initialDateTime != null) {
        _initialTime = TimeOfDay.fromDateTime(initialDateTime);
      }

      final _timeOfDay = await showTimePicker(
        context: context,
        initialTime: _initialTime,
      );

      if (_timeOfDay != null) {
        selectedDate = DateTime(0, 0, 0, _timeOfDay.hour, _timeOfDay.minute);
      }
    } else if (mode == DateTimePickerMode.date) {
      selectedDate = await showDatePicker(
        context: context,
        initialDate: initialDateTime ?? DateTime.now(),
        firstDate: minDateTime ?? DateTime(0),
        lastDate: maxDateTime ?? DateTime(3000),
      );
    }
  }

  return selectedDate;
}