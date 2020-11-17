import 'package:flutter/material.dart';
import 'package:mymgs/widgets/drawer_icon_body.dart';

class Dashboard extends StatelessWidget {
  const Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const DrawerIconButton(),
        title: const Text('Dashboard'),
      ),
    );
  }
}