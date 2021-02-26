/// Use local_database whenever you need to stream a database locally

import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransformedStreamController<T> {
  final BehaviorSubject<T> streamController;
  final T Function(String value) parser;
  TransformedStreamController([this.parser]) : streamController = BehaviorSubject<T>();

  T parse(dynamic value) {
    if (parser != null && value is String) {
      return parser(value);
    } else {
      return value;
    }
  }

  void dispose() {
    streamController.close();
  }

  Stream<T> get stream {
    return streamController.stream;
  }
}

final allControllers = Map<String, List<TransformedStreamController>>();

void _broadcastUpdate(String key, dynamic newValue) {
  if (!allControllers.containsKey(key)) return;
  final streamControllers = allControllers[key];

  List<int> deadStreamControllers = [];
  streamControllers.asMap().forEach((index, transformedStreamController) {
    if (transformedStreamController.streamController.isClosed) {
      deadStreamControllers.add(index);
      return;
    }

    transformedStreamController.streamController.add(
      transformedStreamController.parse(newValue),
    );
  });

  // remove from highest index to lowest index
  deadStreamControllers.reversed.forEach((index) {
    streamControllers.removeAt(index);
  });
}

Future<T> get<T>(String key, [T Function(String value) parser]) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final rawValue = sharedPreferences.get(key);

  if (parser != null && rawValue is String) {
    return parser(rawValue);
  } else {
    return rawValue;
  }
}

TransformedStreamController<T> watch<T>(String key, {T Function(String value) parser, T placeholderValue}) {
  final transformedStreamController = TransformedStreamController<T>(parser);

  if (allControllers.containsKey(key)) {
    allControllers[key].add(transformedStreamController);
  } else {
    allControllers[key] = [transformedStreamController];
  }

  if (placeholderValue != null) {
    transformedStreamController.streamController.add(placeholderValue);
  }

  final initFuture = SharedPreferences.getInstance()
      .then((instance) {
    final currentValue = instance.get(key);
    if (parser != null && currentValue is String) {
      return parser(currentValue);
    } else if (currentValue is T) {
      return currentValue;
    } else {
      return null;
    }
  });
  transformedStreamController.streamController.addStream(initFuture.asStream());

  return transformedStreamController;
}

Future<void> set<T>(String key, T rawValue, [String Function(T value) stringifier]) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  var value;
  if (stringifier != null) {
    value = stringifier(rawValue);
  } else {
    value = rawValue;
  }

  if (value is bool) {
    await sharedPreferences.setBool(key, value);
  } else if (value is String) {
    await sharedPreferences.setString(key, value);
  } else if (value is int) {
    await sharedPreferences.setInt(key, value);
  }

  _broadcastUpdate(key, value);
}
