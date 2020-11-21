import 'package:flutter/material.dart';
import 'package:mymgs/widgets/drawer_app_bar.dart';

class Diary extends StatelessWidget {
  const Diary();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerAppBar('Homework Diary'),
      body: Container(),
    );
  }
}