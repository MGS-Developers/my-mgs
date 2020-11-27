import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/screens/catering.dart';
import 'package:mymgs/widgets/drawer_app_bar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerAppBar('Dashboard'),
      body: Container(
        child: Column(
          children: [
            // this button is here temporarily, just to let you access the catering menu view
            //
            // when we implement a "today's menu" section, we'll replace this button with a large, hero-format card
            // that contains today's menu, and when you tap it, you'll be taken to the catering menu page
            TextButton(
              child: const Text('view menu'),
              onPressed: () {
                Navigator.of(context).push(platformPageRoute(context: context, builder: (_) => Catering()));
              },
            ),
          ],
        ),
      ),
    );
  }
}