import 'package:flutter/material.dart';
import 'package:mymgs/data/settings.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/widgets/button.dart';

class SelectYearGroup extends StatefulWidget {
  final VoidCallback onComplete;
  const SelectYearGroup({
    required this.onComplete,
  });

  _SelectYearGroupState createState() => _SelectYearGroupState();
}

class _SelectYearGroupState extends State<SelectYearGroup> {
  int? yearGroup;

  void _save() async {
    await saveSetting("year-group", yearGroup);
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Responsive(context).centeredSetupPadding,
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
            'This setting always stays on your device. You can change it at any time.',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 5),
          Text(
            'Staff — please select the year group you\'d most like to see data for.',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 5),
          DropdownButton<int>(
            dropdownColor: Theme.of(context).colorScheme.surface,
            isExpanded: true,
            hint: Text(
              'Tap to choose',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onChanged: (int? newValue) {
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
          ButtonBar(
            children: [
              MGSButton(
                label: 'Continue',
                onPressed: yearGroup == null ? null : _save,
              ),
            ],
          ),
        ],
      ),
    );
  }
}