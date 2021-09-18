import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

// this is a widget made by pal to reduce the amount of code you need to write to display a spinner component (aka an Activity Indicator)
class Spinner extends StatelessWidget {
  const Spinner();

  @override
  Widget build(BuildContext context) {
    // the PlatformCircularProgressIndicator automatically selects between an Android-style spinner and an iOS-style spinner
    // the Android design system is known as Material, while the iOS one is known as Cupertino
    return PlatformCircularProgressIndicator(
      // we only need a colour for the Android-style spinner (iOS spinners don't have colours)
      material: (_, __) => MaterialProgressIndicatorData(
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}