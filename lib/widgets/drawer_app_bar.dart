import 'package:flutter/material.dart';
import 'package:mymgs/widgets/drawer_icon_body.dart';

class DrawerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Size preferredSize;
  DrawerAppBar(this.title, {
    Key key,
  }): preferredSize = AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const DrawerIconButton(),
      title: Text(title),
    );
  }
}