import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/settings.dart';
import 'package:mymgs/screens/settings/notifications.dart';
import 'package:mymgs/widgets/drawer_app_bar.dart';
import 'package:mymgs/widgets/settings/key_value.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen();

  void _changeYearGroup(BuildContext context) async {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: Text("Change year group"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...[7, 8, 9, 10, 11, 12, 13].map((year) => Container(
              width: double.infinity,
              child: FlatButton(
                onPressed: () async {
                  await saveSetting("year-group", year);
                  Navigator.of(context).pop();

                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Restart MyMGS to get personalised content."),
                    duration: const Duration(seconds: 2),
                  ));
                },
                child: Text("Year " + year.toString()),
              )),
            )
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerAppBar("Settings"),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        children: [
          KeyValueSetting(
            name: "Notifications",
            description: "Set how you want to stay updated.",
            onTap: () {
              Navigator.of(context).push(platformPageRoute(
                context: context,
                builder: (_) => NotificationSettings(),
              ));
            },
          ),
          KeyValueSetting(
            name: "Year group",
            description: "Personalises your experience.",
            tracker: "year-group",
            trackerMapper: (value) {
              return "Year " + (value as int).toString();
            },
            onTap: () {
              _changeYearGroup(context);
            },
          )
        ],
      ),
    );
  }
}