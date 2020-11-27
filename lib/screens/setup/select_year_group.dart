import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/setup.dart';

class SelectYearGroup extends StatefulWidget {
  final VoidCallback onComplete;
  const SelectYearGroup({
    @required this.onComplete,
  });

  _SelectYearGroupState createState() => _SelectYearGroupState();
}

class _SelectYearGroupState extends State<SelectYearGroup> {
  int yearGroup;

  void _save() async {
    await saveYearGroup(yearGroup);
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Which year group are you in?',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 10),
          Text(
            'Don\'t worry — your data always stays on your phone. You can change this setting at any time.',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 5),
          DropdownButton<int>(
            dropdownColor: Theme.of(context).backgroundColor,
            hint: Text(
              'Tap to choose',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onChanged: (int newValue) {
              setState(() {
                yearGroup = newValue;
              });
            },
            value: yearGroup,
            items: [7, 8, 9, 10, 11, 12, 13].map((value) => DropdownMenuItem(
              child: Text('Year ${value.toString()}'),
              value: value,
            )).toList(),
          ),
          const SizedBox(height: 10),
          PlatformButton(
            child: const Text('Save'),
            onPressed: yearGroup == null ? null : _save,
          )
        ],
      ),
    );
  }
}