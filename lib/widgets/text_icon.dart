import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget {
  final IconData icon;
  final bool forceLightIcon;
  const TextIcon({
    required this.icon,
    this.forceLightIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 14,
      color: forceLightIcon ? Colors.white70 : Theme.of(context).textTheme.bodyText1?.color,
    );
  }
}

class TextIconSpan extends WidgetSpan {
  final IconData icon;
  final bool forceLightIcon;
  TextIconSpan({
    required this.icon,
    this.forceLightIcon = false,
  }) : super(
    child: TextIcon(
      icon: icon,
      forceLightIcon: forceLightIcon,
    ),
    alignment: PlaceholderAlignment.baseline,
    baseline: TextBaseline.alphabetic,
  );
}
