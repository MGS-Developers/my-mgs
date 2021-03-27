import 'package:flutter/material.dart';
import 'package:mymgs/widgets/drawer/drawer_icon_body.dart';

class DrawerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Size preferredSize;
  final List<Widget>? actions;
  DrawerAppBar(this.title, {
    Key? key,
    this.actions,
  }): preferredSize = AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const DrawerIconButton(),
      actions: actions,
      title: Text(title),
    );
  }
}
