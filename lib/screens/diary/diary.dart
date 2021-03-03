import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/diary.dart';
import 'package:mymgs/screens/diary/add_entry.dart';
import 'package:mymgs/widgets/diary/date_selector.dart';
import 'package:mymgs/widgets/diary/day_list.dart';
import 'package:mymgs/widgets/diary/entry_list.dart';
import 'package:mymgs/widgets/drawer_app_bar.dart';

enum DiaryView {
  SingleDay,
  DayList,
}

class Diary extends StatefulWidget {
  const Diary();
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  DiaryEntryController _diaryEntryController;
  DiaryView _diaryView = DiaryView.SingleDay;

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

  void _toggleView() {
    setState(() {
      _diaryView = _diaryView == DiaryView.SingleDay ? DiaryView.DayList : DiaryView.SingleDay;
    });

    if (_diaryView == DiaryView.SingleDay) {
      _changeDate(DateTime.now());
    } else {
      setState(() {
        _diaryEntryController = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerAppBar(
        'Homework Diary',
        actions: [
          PlatformIconButton(
            icon: _diaryView == DiaryView.SingleDay ? Icon(Icons.calendar_view_day) : Icon(Icons.view_array),
            onPressed: _toggleView,
            material: (_, __) => MaterialIconButtonData(
              tooltip: "Toggle view",
            ),
          ),
        ],
      ),
      floatingActionButton: _diaryView == DiaryView.SingleDay ? FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        child: Icon(PlatformIcons(context).add),
        onPressed: () {
          Navigator.of(context).push(platformPageRoute(
            context: context,
            builder: (_) => AddDiaryEntry(diaryEntryController: _diaryEntryController)
          ));
        },
      ) : null,
      body: Container(
        child: _diaryView == DiaryView.SingleDay ? Column(
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
        ) : DiaryDayList(
          focusOnDay: (_date) {
            _changeDate(_date);
            setState(() {
              _diaryView = DiaryView.SingleDay;
            });
          },
        ),
      ),
    );
  }
}