import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jiffy/jiffy.dart';

typedef DateCallback = void Function(DateTime newDate);

class DateSelector extends StatefulWidget {
  final DateTime selectedDate;
  final DateCallback dateCallback;
  const DateSelector({
    @required this.selectedDate,
    @required this.dateCallback,
  });

  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  void _openSelector() async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate,
      firstDate: DateTime.utc(2021),
      lastDate: DateTime.utc(3000),
    );

    if (newDate != null) {
      widget.dateCallback(newDate);
    }
  }

  void _nextDay() {
    final newDate = widget.selectedDate.add(Duration(days: 1));
    widget.dateCallback(newDate);
  }

  void _prevDay() {
    final newDate = widget.selectedDate.subtract(Duration(days: 1));
    widget.dateCallback(newDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      color: MediaQuery.of(context).platformBrightness == Brightness.light ? Color(0xFFEFEFEF) : Color(0xFF111111),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PlatformIconButton(
            icon: Icon(PlatformIcons(context).leftChevron),
            onPressed: _prevDay,
            color: Theme.of(context).accentColor,
          ),
          GestureDetector(
            onTap: _openSelector,
            child: Text(
              Jiffy(widget.selectedDate).yMMMEd
            ),
          ),
          PlatformIconButton(
            icon: Icon(PlatformIcons(context).rightChevron),
            onPressed: _nextDay,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}