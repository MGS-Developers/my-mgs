import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

final Map<String, List<StreamController>> allStreamControllers = {};

void _broadcastUpdate(String key, dynamic newValue) {
  if (!allStreamControllers.containsKey(key)) return;
  final streamControllers = allStreamControllers[key];

  List<int> deadStreamControllers = [];
  streamControllers.asMap().forEach((index, streamController) {
    if (streamController.isClosed) {
      deadStreamControllers.add(index);
      return;
    }

    streamController.add(newValue);
  });

  // remove from highest index to lowest index
  deadStreamControllers.reversed.forEach((index) {
    streamControllers.removeAt(index);
  });
}

Future<void> saveSetting(String key, dynamic value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (value is bool) {
    await sharedPreferences.setBool(key, value);
  } else if (value is String) {
    await sharedPreferences.setString(key, value);
  } else if (value is int) {
    await sharedPreferences.setInt(key, value);
  }

  _broadcastUpdate(key, value);
}

StreamController<T> watchSetting<T>(String key) {
  final newStreamController = StreamController<T>.broadcast();

  if (allStreamControllers.containsKey(key)) {
    allStreamControllers[key].add(newStreamController);
  } else {
    allStreamControllers[key] = [newStreamController];
  }

  final initFuture = SharedPreferences.getInstance()
  .then((instance) {
    final currentValue = instance.get(key);
    if (currentValue is T) {
      return currentValue;
    } else {
      return null;
    }
  });
  newStreamController.addStream(initFuture.asStream());

  return newStreamController;
}

Future<T> getSetting<T>(String key) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.get(key) as T;
}