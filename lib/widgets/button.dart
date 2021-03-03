import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class MGSButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool enabled;
  const MGSButton({
    @required this.label,
    @required this.onPressed,
    this.enabled = true,
  });
  
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      material: (_, __) {
        return ElevatedButton(
          onPressed: enabled ? onPressed : null,
          child: Text(label),
        );
      },
      cupertino: (_, __) {
        return CupertinoButton(
          onPressed: enabled ? onPressed : null,
          child: Text(label),
        );
      },
    );
  }
}