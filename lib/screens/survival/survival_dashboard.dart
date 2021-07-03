import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/survival.dart';
import 'package:mymgs/data_classes/survival_guide.dart' as SG;
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/screens/survival/survival_folder.dart';
import 'package:mymgs/widgets/drawer/drawer_app_bar.dart';
import 'package:mymgs/widgets/spinner.dart';

class SurvivalGuides extends StatefulWidget {
  const SurvivalGuides();
  _SurvivalGuidesState createState() => _SurvivalGuidesState();
}

class _SurvivalGuidesState extends State<SurvivalGuides> {
  final survivalGuideFuture = getSurvivalGuides();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      appBar: DrawerAppBar("Survival Guide"),
      body: FutureBuilder<Map<String?, List<SG.SurvivalGuide>>>(
        future: survivalGuideFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Spinner(),
            );
          }

          final data = snapshot.data;
          if (data == null || data.isEmpty) {
            return Center(
              child: Text("Something went wrong."),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: responsive.horizontalListPadding,
            ),
            itemCount: data.keys.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.horizontalPadding,
                  ).copyWith(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Everything about MGS",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "This page gives you an overview of MGS' policies, rules, and more. Speak to your Form Tutor or Head of Year for more information.",
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                );
              }

              final key = data.keys.elementAt(index - 1);
              if (key == null) return SizedBox();

              final items = data[key];
              if (items == null) return SizedBox();

              return ListTile(
                leading: Icon(
                  Icons.folder,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
                title: Text(key),
                onTap: () {
                  Navigator.of(context).push(platformPageRoute(
                    context: context,
                    builder: (_) => SurvivalFolder(
                      folderName: key,
                      survivalGuides: items,
                    )
                  ));
                },
              );
            }
          );
        },
      )
    );
  }
}
