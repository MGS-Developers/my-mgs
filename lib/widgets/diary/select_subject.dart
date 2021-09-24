import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/settings.dart';
import 'package:mymgs/screens/settings/subjects.dart';
import 'package:mymgs/widgets/tutorial/tutorial_card.dart';

const SUBJECTS = [
  "🎨 Art",
  "🧬 Biology",
  "🧪 Chemistry",
  "🏺 Classics",
  "🖥️ Computing",
  "🎭 Drama",
  "📚 EPQ/Perspectives",
  "💰 Economics",
  "⚡ Electronics",
  "📖 English",
  "🤠 Enrichment",
  "🇫🇷 French",
  "🥼 General Science",
  "🌍 Geography",
  "🇩🇪 German",
  "🔱 Greek",
  "⚔️ History",
  "🇮🇹 Italian",
  "🌋 Latin",
  "🇨🇳 Mandarin",
  "🧮 Mathematics",
  "🎶 Music",
  "⚽ PE/Games",
  "🫂 PSHE",
  "🔭 Physics",
  "🗳️ Politics",
  "🛐 RS",
  "🇷🇺 Russian",
  "🇪🇸 Spanish",
  "Other...",
];

typedef SubjectCallback = void Function(String newSubject);

class SelectSubject extends StatefulWidget {
  final String? selectedSubject;
  final SubjectCallback subjectCallback;

  const SelectSubject({
    required this.selectedSubject,
    required this.subjectCallback,
  });

  _SelectSubjectState createState() => _SelectSubjectState();
}

class _SelectSubjectState extends State<SelectSubject> {
  late TextEditingController _otherSubject;
  List selectedSubjects = [];
  bool noSubjectsSelected = false;

  Future<void> _initChosenSubjects() async {
    final subjects = await getSetting<List?>('subjects');
    if (subjects != null && subjects.length > 0) {
      setState(() {
        selectedSubjects = subjects;
        noSubjectsSelected = false;
      });
    } else {
      setState(() {
        noSubjectsSelected = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _otherSubject = TextEditingController();
    _initChosenSubjects();
  }

  @override
  void dispose() {
    _otherSubject.dispose();
    super.dispose();
  }

  void _selectOtherSubject(BuildContext context) {
    showPlatformDialog(
      context: context,
      materialBarrierColor: Theme.of(context).shadowColor,
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

  void _openSubjectPicker(BuildContext context) async {
    await Navigator.of(context).push(platformPageRoute(
      context: context,
      fullscreenDialog: true,
      builder: (_) => SelectSubjects(),
    ));
    await _initChosenSubjects();
  }

  @override
  Widget build(BuildContext context) {
    List<String> combinedSubjects = SUBJECTS;
    final selectedSubject = widget.selectedSubject;
    if (selectedSubject != null && !combinedSubjects.contains(selectedSubject)) {
      combinedSubjects = [
        selectedSubject,
        ...combinedSubjects,
      ];
    }

    combinedSubjects = [
      ...selectedSubjects,
      ...combinedSubjects.where((subject) => !selectedSubjects.contains(subject)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (noSubjectsSelected) ...[
          const SizedBox(height: 10),
          TutorialCard(
            onPressed: () => _openSubjectPicker(context),
            children: [
              Text(
                "Which subjects do you take?",
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                "Tap here to choose your subjects and make saving homework easier.",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],

        DropdownButton<String>(
          dropdownColor: Theme.of(context).colorScheme.surface,
          value: widget.selectedSubject,
          hint: Text(
            "Select subject",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          items: combinedSubjects.map((subject) => DropdownMenuItem<String>(
            child: Text(subject),
            value: subject,
          )).toList(),
          onChanged: (String? newValue) {
            if (newValue == null) return;

            if (newValue == "Other...") {
              _selectOtherSubject(context);
            } else {
              widget.subjectCallback(newValue);
            }
          },
        ),
      ],
    );
  }
}
