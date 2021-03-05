import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class MGSIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool darkBackground;
  final Color? color;
  const MGSIconButton({
    required this.icon,
    required this.tooltip,
    this.onPressed,
    this.darkBackground = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final _color = color ?? (darkBackground ? Colors.white : null);

    final _icon = Icon(
      icon,
      color: _color,
    );

    return PlatformWidget(
      material: (_, __) {
        return IconButton(
          icon: _icon,
          onPressed: onPressed,
        );
      },
      cupertino: (_, __) {
        return CupertinoButton(
          child: _icon,
          onPressed: onPressed,
        );
      },
    );
  }
}