import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/helpers/class_serializers.dart';

part 'club_time.g.dart';

// enum is _sort of_ syntactical sugar for integers — basically a replacement for using an integer 0-6 to make life easier for programmers
// unlike enums in other languages, dart's act a little different to actual integers
// https://dart.dev/guides/language/language-tour#enumerated-types
enum DayOfWeek {
  @JsonValue(0)
  Monday,
  @JsonValue(1)
  Tuesday,
  @JsonValue(2)
  Wednesday,
  @JsonValue(3)
  Thursday,
  @JsonValue(4)
  Friday,
  @JsonValue(5)
  Saturday,
  @JsonValue(6)
  Sunday
}

extension ParseString on DayOfWeek {
  String toDayString() {
    return this.toString().split('.').last;
  }
}

@JsonSerializable()
class ClubTime {
  // an enum type
  DayOfWeek? dayOfWeek;
  // TimeOfDay is independent of time zones (incl. DST), much like MGS clubs
  // since JsonSerializable doesn't know how to serialize a TimeOfDay instance, we need to tell it using @JsonKey
  // @JsonKey is an 'annotation': https://dart.dev/guides/language/language-tour#metadata
  @JsonKey(fromJson: timeOfDayFromString, toJson: timeOfDayToString)
  TimeOfDay time;

  String toDisplayString() {
    return ("Every " + dayOfWeek.toString().split('.').last + " at " + getDisplayTime());
  }

  String getDisplayTime() {
    // TimeOfDay stores an hour and minute value in 24hr time. The 'hourOfPeriod' function returns the stored hour value in 12hr time (24hr - 12).
    // The below code then combines the 12 hour value with the minute value, as well as the period value which stores if the time is am or pm.

    return Jiffy(DateTime(0, 0, 0, time.hour, time.minute)).jm;
  }

  /// the next occurrence of this ClubTime as a DateTime
  DateTime get next {
    final _now = DateTime.now();
    DateTime? _result;
    for (var i = 0; i <= 6; i++) {
      final _added = _now.add(Duration(days: i));
      if (_added.weekday - 1 == DayOfWeek.values.indexOf(dayOfWeek!)) {
        _result = DateTime(_added.year, _added.month, _added.day, time.hour, time.minute);
      }
    }

    if (_result != null) {
      return _result;
    } else {
      throw Exception("Couldn't get next date.");
    }
  }

  ClubTime({required this.time});
  factory ClubTime.fromJson(Map<String, dynamic> json) => _$ClubTimeFromJson(json);
  Map<String, dynamic> toJson() => _$ClubTimeToJson(this);
}