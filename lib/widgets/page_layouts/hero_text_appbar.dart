import 'package:flutter/material.dart';
import 'package:mymgs/data_classes/shareable.dart';
import 'package:mymgs/helpers/animation.dart';
import 'package:mymgs/widgets/share_button.dart';

class HeroTextAppBar extends StatefulWidget implements PreferredSizeWidget {
  final ScrollController controller;
  final String title;
  final double start;
  final double end;
  final Shareable? shareable;

  const HeroTextAppBar({
    required this.controller,
    required this.title,
    required this.start,
    required this.end,
    this.shareable,
    Key? key,
  });

  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);

  _HeroTextAppBarState createState() => _HeroTextAppBarState();
}

class _HeroTextAppBarState extends State<HeroTextAppBar> {
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
    final padding = lerp(100, 0, widget.start, widget.end, scrollExtent);
    final shareable = widget.shareable;

    return AppBar(
      title: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
          top: padding
        ),
        child: Text(widget.title),
      ),
      actions: shareable != null ? [
        ShareButton(shareable: shareable),
      ] : null,
    );
  }
}
