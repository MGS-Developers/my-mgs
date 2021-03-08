import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

dynamic noopTransform(dynamic value) {
  return value;
}

const NoopKey = JsonKey(fromJson: noopTransform, toJson: noopTransform);

String timeOfDayToString(TimeOfDay value) {
  // this one's easy — just stringify the hours and the minutes
  // we're making use of string interpolation here https://dart.dev/guides/language/language-tour#strings
  return '${value.hour}:${value.minute}';
}

TimeOfDay timeOfDayFromString(String value) {
  // we expect 'value' to be a string in the format 'hh:mm''
  List<String> splitValue = value.split(':');
  assert(splitValue.length == 2);

  // this is like the int() function in Python — tries to parse an integer from a string, and throws an error if it can't
  int hours = int.parse(splitValue[0]);
  int minutes = int.parse(splitValue[1]);

  return TimeOfDay(
    hour: hours,
    minute: minutes
  );
}

int stringToInt(String input) {
  return md5.convert(utf8.encode(input)).hashCode;
}
