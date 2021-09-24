import 'package:flutter/material.dart';
import 'package:mymgs/data/settings.dart';
import 'package:mymgs/widgets/tutorial/tutorial_card.dart';

class TutorialShowOnce extends StatefulWidget {
  final String tutorialKey;
  final List<Widget> children;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;
  final bool enabled;
  const TutorialShowOnce({
    Key? key,
    required this.tutorialKey,
    required this.children,
    this.padding,
    this.onPressed,
    this.enabled = true,
  });

  _TutorialShowOnceState createState() => _TutorialShowOnceState();
}

class _TutorialShowOnceState extends State<TutorialShowOnce> {
  bool show = false;

  @override
  void initState() {
    super.initState();

    getSetting('tutorial_dismissed_' + widget.tutorialKey)
    .then((value) {
      if (value != true) {
        setState(() {
          show = true;
        });
      }
    });
  }

  void _dismiss() async {
    widget.onPressed?.call();

    setState(() {
      show = false;
    });
    await saveSetting('tutorial_dismissed_' + widget.tutorialKey, true);
  }

  @override
  Widget build(BuildContext context) {
    if (show) {
      return Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: TutorialCard(
          onPressed: _dismiss,
          enabled: widget.enabled,
          children: widget.children,
        )
      );
    } else {
      return SizedBox();
    }
  }
}