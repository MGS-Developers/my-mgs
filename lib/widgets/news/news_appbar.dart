import 'package:flutter/material.dart';

class NewsAppBar extends StatefulWidget implements PreferredSizeWidget {
  final ScrollController controller;

  const NewsAppBar({
    @required this.controller,
    Key key,
  });

  _NewsAppBarState createState() => _NewsAppBarState();

  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);
}

class _NewsAppBarState extends State<NewsAppBar> {
  bool transparent = true;

  void _scrollListener() {
    final position = widget.controller.position;
    setState(() {
      transparent = position.extentBefore == 0;
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
    return AppBar(
      title: Text("Article"),
      backgroundColor: transparent ? Colors.transparent : Theme.of(context).appBarTheme.color,
      elevation: transparent ? 0 : null,
    );
  }
}