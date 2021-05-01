import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:mymgs/screens/clubs/clubs.dart';
import 'package:mymgs/screens/dashboard/dashboard.dart';
import 'package:mymgs/screens/diary/diary.dart';
import 'package:mymgs/screens/events/events.dart';
import 'package:mymgs/screens/magazines/explore_magazines.dart';
import 'package:mymgs/screens/settings/settings.dart';
import 'package:mymgs/screens/sportsday/navigation.dart';
import 'package:mymgs/screens/survival/survival_dashboard.dart';
import 'package:mymgs/screens/wellbeing/dashboard.dart';
import 'package:mymgs/widgets/drawer/drawer_tile.dart';

final _remoteConfig = RemoteConfig.instance;

const _modules = <String, RouteData>{
  'dashboard': RouteData("Dashboard", Icons.home_outlined, Icons.home, Dashboard(
    key: Key("DashboardScreen"),
  )),
  'events': RouteData("Events", Icons.event_outlined, Icons.event, Events()),
  'clubs': RouteData("Clubs", Icons.school_outlined, Icons.school, Clubs()),
  'diary': RouteData("Homework Diary", Icons.description_outlined, Icons.description, Diary()),
  'magazines': RouteData("Magazines", Icons.bookmark_border, Icons.bookmark, ExploreMagazines()),
  'survival_guides': RouteData("Survival Guides", Icons.menu_book_outlined, Icons.menu_book, SurvivalGuides()),
  'wellbeing': RouteData("Wellbeing", Icons.support_outlined, Icons.support, WellbeingDashboard()),
  'settings': RouteData("Settings", Icons.settings_outlined, Icons.settings, SettingsScreen()),
  'sportsday': RouteData("Sports Day 2021", Icons.run_circle_outlined, Icons.run_circle, SportsDayNavigation()),
};

RouteData? _featureToRouteData(String featureName) {
  return _modules[featureName];
}

List<RouteData> _jsonStringToRoutes(String jsonString) {
  final features = jsonDecode(jsonString) as List;
  final List<RouteData> routes = [];
  for (final feature in features) {
    final route = _featureToRouteData(feature);
    if (route != null) routes.add(route);
  }

  return routes;
}

class Config {
  static bool initialised = false;

  static Future<void> _init() async {
    if (initialised) return;

    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 15),
      minimumFetchInterval: Foundation.kDebugMode ? Duration.zero : const Duration(days: 3),
    ));

    await _remoteConfig.setDefaults({
      'modules': '["dashboard"]',
    });

    initialised = true;
  }

  static Future<void> _fetch() async {
    try {
      await _remoteConfig.fetchAndActivate();
    } catch (e) {}
  }

  static Stream<List<RouteData>> getDrawerTabs() async* {
    await _init();
    await _fetch();

    final liveData = _remoteConfig.getString('modules');
    if (liveData == '') return;
    yield _jsonStringToRoutes(liveData);
  }
}
