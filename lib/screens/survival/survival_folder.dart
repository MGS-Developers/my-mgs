import 'package:flutter/material.dart';
import 'package:mymgs/data_classes/survival_guide.dart';
import 'package:mymgs/widgets/page_layouts/master_detail.dart';
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
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          itemCount: survivalGuides.length,
          itemBuilder: (context, index) {
            final guide = survivalGuides[index];
            final selected = selectedIndex == index;

            return ListTile(
              leading: Icon(
                Icons.article,
                color: selected ? Colors.white70 : Theme.of(context).textTheme.bodyText1?.color,
              ),
              title: Text(
                guide.name,
                style: TextStyle(
                  color: selected ? Colors.white : null,
                ),
              ),
              onTap: () => onTap(index),
              tileColor: selected ? Theme.of(context).primaryColor : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
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
