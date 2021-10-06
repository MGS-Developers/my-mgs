import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:mymgs/widgets/settings/toggle.dart';

final _analytics = FirebaseAnalytics();

class AnalyticsToggleSetting extends StatelessWidget {
  const AnalyticsToggleSetting();

  @override
  Widget build(BuildContext context) {
    return ToggleSetting(
      name: "Analytics",
      description: "Collect anonymous stats (optional)",
      callback: (enabled) => _analytics.setAnalyticsCollectionEnabled(enabled),
      tracker: "analytics",
    );
  }
}