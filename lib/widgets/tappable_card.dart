import 'package:flutter/material.dart';
import 'package:mymgs/helpers/widget_helpers.dart';

class TappableCard extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback? onPressed;
  final Color? color;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  const TappableCard({
    required this.children,
    this.onPressed,
    this.color,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    Color? splashColor;
    if (color != null) {
      final hslColor = HSLColor.fromColor(color!);
      splashColor = hslColor.withLightness(hslColor.lightness + 0.2).withAlpha(0.5).toColor();
    }

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onPressed,
      splashColor: splashColor,
      child: Ink(
        padding: EdgeInsets.all(15),
        decoration: getCardDecoration(
          context,
          borderRadius: 20,
          color: color,
        ),
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          children: children,
        ),
      ),
    );
  }
}