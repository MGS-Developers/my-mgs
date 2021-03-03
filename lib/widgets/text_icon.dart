import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget {
  final IconData icon;
  const TextIcon({
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 14,
      color: Theme.of(context).textTheme.bodyText1.color,
    );
  }
}