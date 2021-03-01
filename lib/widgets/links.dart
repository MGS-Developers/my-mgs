import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:mymgs/data_classes/link.dart';

class Links extends StatelessWidget {
  final List<Link> links;
  const Links({
    Key key,
    @required this.links,
  });

  void _openLink(String url) async {
    FlutterWebBrowser.openWebPage(
      url: url,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: links.map((link) {
        String label = link.label;
        if (label == null) {
          final parsedUri = Uri.parse(link.url);
          label = parsedUri.host;
        }

        if (link.important) {
          return ElevatedButton(
            onPressed: () {
              _openLink(link.url);
            },
            child: Text(label),
          );
        } else {
          return OutlinedButton(
            onPressed: () {
              _openLink(link.url);
            },
            child: Text(label),
          );
        }
      }).map((e) => Container(
        child: e,
        width: double.infinity,
      )).toList(),
    );
  }
}
