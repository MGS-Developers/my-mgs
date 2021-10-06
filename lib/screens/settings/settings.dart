import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/settings.dart';
import 'package:mymgs/data/sportsday/temporary_authentication.dart';
import 'package:mymgs/helpers/app_metadata.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/screens/interests/interests.dart';
import 'package:mymgs/screens/settings/notifications.dart';
import 'package:mymgs/screens/settings/subjects.dart';
import 'package:mymgs/screens/settings/web_auth.dart';
import 'package:mymgs/widgets/button.dart';
import 'package:mymgs/widgets/drawer/drawer_app_bar.dart';
import 'package:mymgs/widgets/settings/analytics_toggle.dart';
import 'package:mymgs/widgets/settings/contributors.dart';
import 'package:mymgs/widgets/settings/key_value.dart';
import 'package:mymgs/widgets/settings/remove_license.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen();
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool restrictForSportsDay = false;
  @override
  void initState() {
    super.initState();

    isSportsDayAuth().then((value) {
      setState(() {
        restrictForSportsDay = value;
      });
    });
  }

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
      children: [
        MGSButton(
          label: "View source code",
          onPressed: () {
            launch(appSourceUrl);
          },
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerAppBar("Settings"),
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: Responsive(context).horizontalListPadding,
        ),
        children: [
          if (restrictForSportsDay) Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "Some settings may be unavailable as you're using a restricted Sports Day version of MyMGS.",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),

          if (!kIsWeb && !restrictForSportsDay) KeyValueSetting(
            name: "Notifications",
            description: "Set how you want to stay updated.",
            onTap: () {
              Navigator.of(context).push(platformPageRoute(
                context: context,
                builder: (_) => NotificationSettings(),
              ));
            },
          ),
          if (!restrictForSportsDay) KeyValueSetting(
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
          if (!kIsWeb && !restrictForSportsDay) KeyValueSetting(
            name: "Interests",
            description: "Help us tailor recommendations to you",
            onTap: () {
              Navigator.of(context).push(platformPageRoute(
                context: context,
                builder: (_) => const InterestsScreen(),
              ));
            },
          ),
          if (!restrictForSportsDay) KeyValueSetting(
            name: "Subjects",
            description: "Select which subjects you take",
            onTap: () {
              Navigator.of(context).push(platformPageRoute(
                context: context,
                fullscreenDialog: true,
                builder: (_) => const SelectSubjects(),
              ));
            }
          ),
          const RemoveLicenseSetting(),
          if (!kIsWeb && !restrictForSportsDay) KeyValueSetting(
            name: "MyMGS Web",
            description: "Sign into the app's web version",
            onTap: () {
              Navigator.of(context).push(platformPageRoute(
                context: context,
                builder: (_) => const WebAuthScreen(),
              ));
            },
          ),
          const AnalyticsToggleSetting(),
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
