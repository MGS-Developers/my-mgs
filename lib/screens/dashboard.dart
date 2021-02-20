import 'package:flutter/material.dart';
import 'package:mymgs/widgets/dashboard_cards/homework.dart';
import 'package:mymgs/widgets/dashboard_cards/news.dart';
import 'package:mymgs/widgets/drawer_app_bar.dart';
import 'package:mymgs/widgets/dashboard_cards/todays_menu.dart';

class Dashboard extends StatelessWidget {
  const Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerAppBar('Dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 15
        ).copyWith(bottom: 10),
        child: Column(
          children: [
            TodaysMenuCard(),
            NewsCard(),
            HomeworkCard(),
          ],
        ),
      ),
    );
  }
}