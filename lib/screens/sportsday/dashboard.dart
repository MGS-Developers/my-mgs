import 'package:flutter/material.dart';
import 'package:mymgs/widgets/drawer/drawer_app_bar.dart';

class SportsDayDashboard extends StatelessWidget {
  const SportsDayDashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerAppBar("Sports Day 2021"),
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
