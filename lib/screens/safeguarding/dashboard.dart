import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/screens/safeguarding/report.dart';
import 'package:mymgs/widgets/drawer_app_bar.dart';

class SafeguardingDashboard extends StatelessWidget {
  const SafeguardingDashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerAppBar("Safeguarding"),
      body: Container(
        child: FlatButton(
          child: Text("Make a report"),
          onPressed: () {
            Navigator.of(context).push(platformPageRoute(
              context: context,
              builder: (_) => SafeguardingReport(),
            ));
          },
        ),
      ),
    );
  }
}
