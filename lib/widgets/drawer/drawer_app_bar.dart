import 'package:flutter/material.dart';
import 'package:mymgs/widgets/drawer/drawer_icon_body.dart';

class DrawerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  late final Size preferredSize;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  DrawerAppBar(this.title, {
    Key? key,
    this.actions,
    this.bottom,
  }) {
    var preferredSize = AppBar().preferredSize;
    final bottom = this.bottom;
    if (bottom != null) {
      preferredSize = Size.fromHeight(preferredSize.height + bottom.preferredSize.height);
    }

    this.preferredSize = preferredSize;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const DrawerIconButton(),
      actions: actions,
      title: Text(title),
      bottom: bottom,
    );
  }
}
