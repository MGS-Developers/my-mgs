import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/screens/diary/add_entry.dart';
import 'package:mymgs/widgets/diary/date_selector.dart';
import 'package:mymgs/widgets/diary/day_list.dart';
import 'package:mymgs/widgets/diary/entry_list.dart';
import 'package:mymgs/widgets/drawer/drawer_app_bar.dart';
import 'package:mymgs/widgets/icon_button.dart';

enum DiaryView {
  SingleDay,
  DayList,
}

class Diary extends StatefulWidget {
  const Diary();
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  late DateTime? _date;
  DiaryView _diaryView = DiaryView.SingleDay;

  @override
  void initState() {
    _date = DateTime.now();
    super.initState();
  }

  void _changeDate(DateTime newDate) {
    setState(() {
      _date = newDate;
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
        _date = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerAppBar(
        'Homework Diary',
        actions: [
          MGSIconButton(
            icon: _diaryView == DiaryView.SingleDay ? Icons.calendar_view_day : Icons.view_array,
            onPressed: _toggleView,
            tooltip: 'Toggle view',
            darkBackground: true,
          ),
        ],
      ),
      floatingActionButton: _diaryView == DiaryView.SingleDay ? FloatingActionButton.extended(
        label: Text(
          'Add entry',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        icon: Icon(
          PlatformIcons(context).add,
          color: Theme.of(context).textTheme.bodyText2?.color,
        ),
        onPressed: () {
          Navigator.of(context).push(platformPageRoute(
            context: context,
            builder: (_) => AddDiaryEntry(date: _date!),
            fullscreenDialog: true,
          ));
        },
      ) : null,
      body: Container(
        child: _diaryView == DiaryView.SingleDay ? Column(
          children: [
            DateSelector(
              selectedDate: _date!,
              dateCallback: _changeDate,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: EntryList(
                date: _date!,
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