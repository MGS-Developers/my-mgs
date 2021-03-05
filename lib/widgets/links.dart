import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:mymgs/data_classes/link.dart';
import 'package:mymgs/widgets/button.dart';

class Links extends StatelessWidget {
  final List<Link> links;
  const Links({
    Key? key,
    required this.links,
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
        String? label = link.label;
        if (label == null) {
          final parsedUri = Uri.parse(link.url);
          label = parsedUri.host;
        }

        return MGSButton(
          label: label,
          onPressed: () {
            _openLink(link.url);
          },
          outlined: !link.important,
        );
      }).map((e) => Container(
        child: e,
        width: double.infinity,
      )).toList(),
    );
  }
}
