import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mymgs/data/magazines.dart';
import 'package:mymgs/data_classes/protobuf/magazines.pb.dart' hide TextStyle;

class ArticleTextNode extends StatelessWidget {
  final RichTextNode richTextNode;
  final PublicationTheme theme;

  const ArticleTextNode({
    Key? key,
    required this.richTextNode,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    if (richTextNode.hasMarkdown()) {
      return MarkdownBody(
        data: richTextNode.markdown,
        styleSheet: MarkdownStyleSheet(
          blockSpacing: 15,
          p: parsePbTextStyle(theme.paragraphStyle).copyWith(
            fontSize: 14,
            color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.white : parsePbColor(theme.paragraphStyle.color),
          ),
          h1: parsePbTextStyle(theme.subheadingStyle).copyWith(
            fontSize: 24,
            color: Theme.of(context).textTheme.headline4?.color,
          ),
        ),
      );
    } else if (richTextNode.hasRichText()) {
      return SizedBox();
    } else {
      return SizedBox();
    }
  }
}
