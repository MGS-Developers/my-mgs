import 'package:flutter/material.dart';
import 'package:mymgs/screens/main_navigation.dart';

class DrawerIconButton extends StatelessWidget {
  const DrawerIconButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.menu),
      // adding tooltips is important for accessibility!
      // some users may rely on screen-readers to access their phones, so we need a way to tell the screen reader what everything is
      // if you long-tap on the icon, you'll see this tooltip, too.
      tooltip: 'Open menu',
      onPressed: () {
        if (scaffoldKey?.currentState != null) {
          scaffoldKey.currentState.openDrawer();
        }
      }
    );
  }
}