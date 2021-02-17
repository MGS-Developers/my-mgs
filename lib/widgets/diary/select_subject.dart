import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

const SUBJECTS = [
  "Art",
  "Biology",
  "Chemistry",
  "Classics",
  "Computing",
  "Drama",
  "EPQ",
  "Economics",
  "Electronics",
  "English",
  "Enrichment",
  "French",
  "General Science",
  "Geography",
  "German",
  "Greek",
  "History",
  "Italian",
  "Latin",
  "Mandarin",
  "Mathematics",
  "Music",
  "PE/Games",
  "PSHE",
  "Physics",
  "Politics",
  "RS",
  "Russian",
  "Spanish",
  "Other...",
];

typedef SubjectCallback = void Function(String newSubject);

class SelectSubject extends StatefulWidget {
  final String selectedSubject;
  final SubjectCallback subjectCallback;

  const SelectSubject({
    @required this.selectedSubject,
    @required this.subjectCallback,
  });

  _SelectSubjectState createState() => _SelectSubjectState();
}

class _SelectSubjectState extends State<SelectSubject> {
  TextEditingController _otherSubject;
  @override
  void initState() {
    _otherSubject = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _otherSubject.dispose();
    super.dispose();
  }

  void _selectOtherSubject(BuildContext context) {
    showPlatformDialog(
      context: context,
      builder: (BuildContext context) => PlatformAlertDialog(
        title: Text("Other subject"),
        content: PlatformTextField(
          controller: _otherSubject,
          textCapitalization: TextCapitalization.words,
          autofocus: true,
        ),
        actions: [
          PlatformDialogAction(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          PlatformDialogAction(
            child: Text("Save"),
            onPressed: () {
              if (_otherSubject.text.isNotEmpty) {
                widget.subjectCallback(_otherSubject.text);
              }
              Navigator.of(context).pop();
            }
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> combinedSubjects = SUBJECTS;
    if (!combinedSubjects.contains(widget.selectedSubject)) {
      combinedSubjects = [
        widget.selectedSubject,
        ...combinedSubjects,
      ];
    }

    return DropdownButton<String>(
      dropdownColor: Theme.of(context).backgroundColor,
      value: widget.selectedSubject,
      hint: Text(
        "Select subject",
        style: Theme.of(context).textTheme.bodyText1,
      ),
      items: combinedSubjects.map((subject) => DropdownMenuItem<String>(
        child: Text(subject ?? ""),
        value: subject,
      )).toList() + [

      ],
      onChanged: (String newValue) {
        if (newValue == "Other...") {
          _selectOtherSubject(context);
        } else {
          widget.subjectCallback(newValue);
        }
      }
    );
  }
}