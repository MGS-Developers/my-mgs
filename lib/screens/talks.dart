import 'package:flutter/material.dart';
import 'package:mymgs/widgets/drawer_app_bar.dart';

class Talks extends StatelessWidget {
  const Talks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerAppBar('Talks')
    );
  }
}