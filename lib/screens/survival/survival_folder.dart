import 'package:flutter/material.dart';
import 'package:mymgs/data_classes/survival_guide.dart';
import 'package:mymgs/widgets/master_detail.dart';
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
    return MasterDetailScreen(
      masterTitle: folderName,
      masterBuilder: (context, selectedIndex, onTap) {
        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 20),
          itemCount: survivalGuides.length,
          itemBuilder: (context, index) {
            final guide = survivalGuides[index];

            return ListTile(
              leading: Icon(Icons.article),
              title: Text(guide.name),
              onTap: () => onTap(index),
              tileColor: selectedIndex == index ? Theme.of(context).primaryColorDark : null,
            );
          },
        );
      },
      detailBuilder: (context, selectedIndex, isNewScreen, [_]) {
        final guide = survivalGuides[selectedIndex];
        return InfoScreen(
          title: guide.name,
          markdownContent: guide.contents,
          identifier: guide,
          shareable: guide,
          isFullScreen: isNewScreen,
        );
      }
    );
  }
}
