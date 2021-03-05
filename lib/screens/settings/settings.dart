import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/settings.dart';
import 'package:mymgs/helpers/app_metadata.dart';
import 'package:mymgs/screens/settings/notifications.dart';
import 'package:mymgs/widgets/drawer/drawer_app_bar.dart';
import 'package:mymgs/widgets/settings/contributors.dart';
import 'package:mymgs/widgets/settings/key_value.dart';
import 'package:mymgs/widgets/settings/remove_license.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen();

  void _changeYearGroup(BuildContext context) async {
    showPlatformDialog(
      context: context,
      materialBarrierColor: Theme.of(context).shadowColor,
      builder: (_) => PlatformAlertDialog(
        title: Text("Change year group"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...[7, 8, 9, 10, 11, 12, 13].map((year) => Container(
              width: double.infinity,
              child: TextButton(
                onPressed: () async {
                  await saveSetting("year-group", year);
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Restart " + appName + " to get personalised content."),
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

  void _showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: appName,
      applicationVersion: appVersion,
      applicationLegalese: appLegalese,
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
          ),
          const RemoveLicenseSetting(),
          KeyValueSetting(
            name: "About $appName",
            onTap: () {
              _showAbout(context);
            }
          ),
          KeyValueSetting(
            name: "Contributors",
            onTap: () {
              Navigator.of(context).push(platformPageRoute(
                context: context,
                builder: (_) => Contributors(),
              ));
            }
          ),
        ],
      ),
    );
  }
}