import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// For use where general Markdown rendering is needed.
/// Not customisable for specific use cases (e.g. news) but best for events, clubs, etc.
class ContentMarkdown extends StatelessWidget {
  final String content;
  const ContentMarkdown({
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: content,
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        p: TextStyle(
          fontSize: 17,
        ),
      ),
    );
  }
}