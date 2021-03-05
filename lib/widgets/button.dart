import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class MGSButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool outlined;
  final bool disableCupertinoPaddingCompensation;
  const MGSButton({
    required this.label,
    this.onPressed,
    this.enabled = true,
    this.outlined = false,
    this.disableCupertinoPaddingCompensation = false,
  });
  
  @override
  Widget build(BuildContext context) {
    final callback = enabled ? onPressed : null;
    final child = Text(label);

    return PlatformWidget(
      material: (_, __) {
        if (outlined) {
          return OutlinedButton(
            onPressed: callback,
            child: child,
          );
        }

        return ElevatedButton(
          onPressed: callback,
          child: child,
        );
      },
      cupertino: (_, __) {
        if (outlined) {
          return CupertinoButton(
            onPressed: callback,
            child: child,
          );
        }

        return Padding(
          padding: disableCupertinoPaddingCompensation ? EdgeInsets.zero : EdgeInsets.symmetric(vertical: 10),
          child: CupertinoButton.filled(
            onPressed: callback,
            child: child,
          ),
        );
      },
    );
  }
}