import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/diary.dart';
import 'package:mymgs/screens/diary/add_entry.dart';
import 'package:mymgs/widgets/diary/date_selector.dart';
import 'package:mymgs/widgets/diary/entry_list.dart';
import 'package:mymgs/widgets/drawer_app_bar.dart';

class Diary extends StatefulWidget {
  const Diary();
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  DiaryEntryController _diaryEntryController;

  @override
  void initState() {
    _diaryEntryController = getControllerForDay(DateTime.now());
    super.initState();
  }

  void _changeDate(DateTime newDate) {
    setState(() {
      _diaryEntryController = getControllerForDay(newDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerAppBar('Homework Diary'),
      floatingActionButton: FloatingActionButton(
        child: Icon(PlatformIcons(context).add),
        onPressed: () {
          Navigator.of(context).push(platformPageRoute(
            context: context,
            builder: (_) => AddDiaryEntry(diaryEntryController: _diaryEntryController)
          ));
        },
      ),
      body: Container(
        child: Column(
          children: [
            DateSelector(
              selectedDate: _diaryEntryController.date,
              dateCallback: _changeDate,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: EntryList(
                diaryEntryController: _diaryEntryController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}