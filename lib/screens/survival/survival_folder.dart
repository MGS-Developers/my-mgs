import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data_classes/survival_guide.dart';
import 'package:mymgs/widgets/page_layouts/info.dart';

class SurvivalFolder extends StatelessWidget {
  final List<SurvivalGuide> survivalGuides;
  final String folderName;

  const SurvivalFolder({
    required this.survivalGuides,
    required this.folderName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(folderName),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20),
        itemCount: survivalGuides.length,
        itemBuilder: (context, index) {
          final guide = survivalGuides[index];

          return ListTile(
            leading: Icon(Icons.article),
            title: Text(guide.name),
            onTap: () {
              Navigator.of(context).push(platformPageRoute(
                context: context,
                builder: (_) => InfoScreen(
                  title: guide.name,
                  markdownContent: guide.contents,
                  identifier: guide,
                ),
              ));
            },
          );
        }
      ),
    );
  }
}