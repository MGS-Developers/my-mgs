import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:mymgs/data/sportsday/temporary_authentication.dart';
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
  'dashboard': RouteData("dashboard", "Dashboard", Icons.home_outlined, Icons.home, Dashboard(
    key: Key("DashboardScreen"),
  )),
  'events': RouteData("events", "Events", Icons.event_outlined, Icons.event, Events()),
  'clubs': RouteData("clubs", "Clubs", Icons.school_outlined, Icons.school, Clubs()),
  'diary': RouteData("diary", "Homework Diary", Icons.description_outlined, Icons.description, Diary()),
  'magazines': RouteData("magazines", "Magazines", Icons.bookmark_border, Icons.bookmark, ExploreMagazines()),
  'survival_guides': RouteData("survival_guides", "Survival Guides", Icons.menu_book_outlined, Icons.menu_book, SurvivalGuides()),
  'wellbeing': RouteData("wellbeing", "Wellbeing", Icons.support_outlined, Icons.support, WellbeingDashboard()),
  'settings': RouteData("settings", "Settings", Icons.settings_outlined, Icons.settings, SettingsScreen()),
  'sportsday': RouteData("sportsday", "Sports Day 2021", Icons.run_circle_outlined, Icons.run_circle, SportsDayNavigation()),
};

RouteData? _featureToRouteData(String featureName) {
  return _modules[featureName];
}

List<RouteData> _jsonStringToRoutes(String jsonString) {
  final features = jsonDecode(jsonString) as List;
  final List<RouteData> routes = [];
  for (final feature in features) {
    if (Foundation.kIsWeb && feature == 'diary') continue;

    final route = _featureToRouteData(feature);
    if (route != null) routes.add(route);
  }

  return routes;
}

class Config {
  static bool initialised = false;

  static Future<void> _init() async {
    if (initialised) return;

    if (Foundation.kIsWeb) {
      initialised = true;
      return;
    }

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
    if (Foundation.kIsWeb) return;
    try {
      await _remoteConfig.fetchAndActivate();
    } catch (e) {}
  }

  static Stream<List<RouteData>> getDrawerTabs() async* {
    if (await isSportsDayAuth()) {
      yield _jsonStringToRoutes(jsonEncode(['sportsday', 'settings']));
      return;
    }

    if (Foundation.kIsWeb) {
      yield _jsonStringToRoutes(jsonEncode([
        "dashboard",
        "clubs",
        "events",
        "diary",
        "magazines",
        "survival_guides",
        "wellbeing",
        "settings",
      ]));
      return;
    }

    await _init();
    await _fetch();

    final liveData = _remoteConfig.getString('modules');
    if (liveData == '') return;
    yield _jsonStringToRoutes(liveData);
  }

  static Stream<bool> getIsSportsDaySeason() async* {
    if (Foundation.kDebugMode) {
      yield true;
      return;
    }

    final date = DateTime.now();
    yield date.isAfter(DateTime(2021, 6, 20)) && date.isBefore(DateTime(2021, 7, 14));
    if (Foundation.kIsWeb) {
      return;
    }

    await _init();
    await _fetch();
    yield _remoteConfig.getBool('is_sportsday_season');
  }

  static Future<bool> getIsSignupEnabled() async {
    if (Foundation.kDebugMode) {
      return true;
    }

    if (Foundation.kIsWeb) {
      return false; // must be updated manually
    }

    await _init();
    await _fetch();
    return _remoteConfig.getBool('is_signup_enabled');
  }
}
