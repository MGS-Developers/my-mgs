import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data/diary.dart';
import 'package:mymgs/widgets/button.dart';
import 'package:mymgs/widgets/diary/due_date.dart';
import 'package:mymgs/widgets/diary/select_subject.dart';
import 'package:mymgs/widgets/text_field.dart';

class AddDiaryEntry extends StatefulWidget {
  final DateTime date;

  const AddDiaryEntry({
    required this.date,
  });
  _AddDiaryEntryState createState() => _AddDiaryEntryState();
}

class _AddDiaryEntryState extends State<AddDiaryEntry> {
  String? _subject;
  late TextEditingController _homework;
  late DateTime _dueDate;

  @override
  void initState() {
    _homework = TextEditingController();
    _dueDate = DateTime.now().add(const Duration(days: 1));
    super.initState();
  }

  @override
  void dispose() {
    _homework.dispose();
    super.dispose();
  }

  void _save() async {
    final subject = _subject;
    if (subject == null) return;

    final controller = DiaryEntryController.forDay(widget.date);
    controller.addHomework(
      subject: subject,
      homework: _homework.text,
      dueDate: _dueDate,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add diary entry"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Jiffy(widget.date).yMMMEd,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 10),
            SelectSubject(
              selectedSubject: _subject,
              subjectCallback: (String newSubject) {
                setState(() {
                  _subject = newSubject;
                });
              }
            ),
            const SizedBox(height: 15),
            DueDate(
              selectedDate: _dueDate,
              dateCallback: (DateTime newDate) {
                setState(() {
                  _dueDate = newDate;
                });
              },
            ),
            const SizedBox(height: 15),
            MGSTextField(
              controller: _homework,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              label: "Homework",
              hint: "Describe your homework...",
            ),
            const SizedBox(height: 20),
            MGSButton(
              label: "Save",
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}