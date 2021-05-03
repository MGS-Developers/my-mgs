import 'package:flutter/material.dart';
import 'package:mymgs/data/magazines.dart';
import 'package:mymgs/data_classes/protobuf/magazines.pb.dart';

class ScrollPrompt extends StatefulWidget {
  final PublicationTheme theme;
  const ScrollPrompt({
    required this.theme,
  });
  _ScrollPromptState createState() => _ScrollPromptState();
}

class _ScrollPromptState extends State<ScrollPrompt> with TickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
    value: 0,
  )..forward();
  late final _position = Tween(begin: Offset(0, -1), end: Offset(0, 0)).animate(CurvedAnimation(
    parent: _controller,
    curve: Interval(0.6, 0.8, curve: Curves.easeOut),
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Scroll to read",
          style: parsePbTextStyle(widget.theme.headingStyle).copyWith(
            color: Colors.grey[400],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 5),
        ClipRect(
          child: SizedBox(
            height: 20,
            child: SlideTransition(
              position: _position,
              child: Icon(
                Icons.arrow_downward,
                size: 20,
                color: Colors.grey[400],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
