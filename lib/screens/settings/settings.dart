import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/screens/settings/notifications.dart';
import 'package:mymgs/widgets/drawer_app_bar.dart';
import 'package:mymgs/widgets/settings/key_value.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen();

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
        ],
      ),
    );
  }
}