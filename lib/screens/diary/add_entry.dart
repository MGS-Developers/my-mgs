import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data/diary.dart';
import 'package:mymgs/widgets/diary/select_subject.dart';

class AddDiaryEntry extends StatefulWidget {
  final DiaryEntryController diaryEntryController;

  const AddDiaryEntry({
    @required this.diaryEntryController,
  });
  _AddDiaryEntryState createState() => _AddDiaryEntryState();
}

class _AddDiaryEntryState extends State<AddDiaryEntry> {
  String _subject = "Art";
  TextEditingController _homework;

  @override
  void initState() {
    _homework = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _homework.dispose();
    super.dispose();
  }

  void _save() async {
    widget.diaryEntryController.addHomework(
      subject: _subject,
      homework: _homework.text,
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
          children: [
            Text(
              Jiffy(widget.diaryEntryController.date).yMMMEd,
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
            const SizedBox(height: 10),
            PlatformTextField(
              controller: _homework,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              material: (_, __) => MaterialTextFieldData(
                decoration: InputDecoration(
                  labelText: "Homework",
                  hintText: "Describe your homework...",
                ),
              ),
            ),
            const SizedBox(height: 20),
            PlatformButton(
              child: Text("Save"),
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}