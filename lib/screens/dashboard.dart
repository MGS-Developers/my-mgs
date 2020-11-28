import 'package:flutter/material.dart';
import 'package:mymgs/widgets/drawer_app_bar.dart';
import 'package:mymgs/widgets/todays_menu.dart';

class Dashboard extends StatelessWidget {
  const Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerAppBar('Dashboard'),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TodaysMenu(),
          ],
        ),
      ),
    );
  }
}