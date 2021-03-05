import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mymgs/helpers/animation.dart';

class HeroAppBar extends StatefulWidget implements PreferredSizeWidget {
  final ScrollController controller;
  final String title;

  const HeroAppBar({
    required this.controller,
    required this.title,
    Key? key,
  });

  _HeroAppBarState createState() => _HeroAppBarState();

  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);
}

class _HeroAppBarState extends State<HeroAppBar> {
  double scrollExtent = 0;

  void _scrollListener() {
    final position = widget.controller.position;
    setState(() {
      scrollExtent = position.extentBefore;
    });
  }

  @override
  void initState() {
    widget.controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final opacity = lerp(0, 1, 0, 100, scrollExtent);

    return AppBar(
      title: Text(widget.title),
      backgroundColor: Theme.of(context).primaryColor.withOpacity(opacity),
      elevation: 0,
    );
  }
}