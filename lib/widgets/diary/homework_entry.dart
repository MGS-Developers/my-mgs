import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data_classes/diary_entry.dart';
import 'package:mymgs/widgets/text_icon.dart';

class HomeworkEntry extends StatefulWidget {
  final Future<void> Function() delete;
  final Future<void> Function() toggle;
  final SubjectEntry subjectEntry;
  const HomeworkEntry({
    required this.subjectEntry,
    required this.delete,
    required this.toggle,
  });

  _HomeworkEntryState createState() => _HomeworkEntryState();
}

class _HomeworkEntryState extends State<HomeworkEntry> with TickerProviderStateMixin {
  late ConfettiController _confetti;

  void _resetConfetti() {
    _confetti = ConfettiController(duration: const Duration(milliseconds: 500));
  }

  @override
  void initState() {
    _resetConfetti();
    super.initState();
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  void _options(BuildContext context) {
    showPlatformDialog(
      context: context,
      materialBarrierColor: Theme.of(context).shadowColor,
      builder: (BuildContext context) => PlatformAlertDialog(
        title: Text(widget.subjectEntry.subject),
        actions: [
          PlatformDialogAction(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            }
          ),
          PlatformDialogAction(
            child: Text("Delete"),
            onPressed: () async {
              await widget.delete();
              Navigator.of(context).pop();
            }
          ),
        ],
      ),
    );
  }

  void _toggle() {
    if (widget.subjectEntry.complete == false) {
      _confetti.play();
    }

    widget.toggle();
  }

  @override
  Widget build(BuildContext context) {
    final homework = widget.subjectEntry.homework;
    final due = widget.subjectEntry.dueDate;
    final subject = widget.subjectEntry.subject;
    final done = widget.subjectEntry.complete;

    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Stack(
        children: [
          Card(
            child: InkWell(
              onLongPress: () {
                _options(context);
              },
              onTap: () {
                _toggle();
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      vsync: this,
                      child: Container(
                        width: done ? 40 : 0,
                        padding: EdgeInsets.only(right: 15),
                        alignment: Alignment.center,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(),
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (homework != null) Text(
                            homework,
                            style: done ? Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontSize: 16,
                              decoration: TextDecoration.lineThrough,
                            ) : TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (due != null) Row(
                            children: [
                              TextIcon(icon: Icons.schedule_outlined),
                              const SizedBox(width: 10),
                              Text(
                                Jiffy(due).yMMMEd,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              TextIcon(icon: Icons.school_outlined),
                              const SizedBox(width: 10),
                              Text(
                                subject,
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    PlatformIconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        _options(context);
                      },
                      material: (_, __) => MaterialIconButtonData(
                        tooltip: "More options",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 15),
              child: ConfettiWidget(
                confettiController: _confetti,
                blastDirectionality: BlastDirectionality.explosive,
                gravity: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
