import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkableMarkdown extends StatelessWidget {
  final String text;
  final MarkdownStyleSheet? styleSheet;

  const LinkableMarkdown({
    required this.text,
    this.styleSheet,
  });

  void _linkClick(BuildContext context, String? href) {
    if (href == null) {
      return;
    }

    if (href.startsWith('mailto:')) {
      final emailAddress = href.replaceFirst('mailto:', '');
      Clipboard.setData(ClipboardData(text: emailAddress));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Email copied to clipboard!"),
        action: SnackBarAction(
          label: "Write email",
          onPressed: () {
            launch(href);
          },
        ),
      ));
      return;
    }

    FlutterWebBrowser.openWebPage(
      url: href,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: text,
      styleSheet: styleSheet,
      onTapLink: (_, href, __) {
        _linkClick(context, href);
      },
    );
  }
}
