import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data_classes/shareable.dart';
import 'package:mymgs/helpers/animation.dart';
import 'package:mymgs/widgets/share_button.dart';

class HeroAppBar extends StatefulWidget implements PreferredSizeWidget {
  final ScrollController controller;
  final String title;
  final Shareable? shareable;

  const HeroAppBar({
    required this.controller,
    required this.title,
    this.shareable,
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
    final shareable = widget.shareable;

    return AppBar(
      title: Text(widget.title),
      backgroundColor: Theme.of(context).primaryColor.withOpacity(opacity),
      elevation: 0,
      actions: shareable != null ? [
        ShareButton(shareable: shareable),
      ] : null,
    );
  }
}
