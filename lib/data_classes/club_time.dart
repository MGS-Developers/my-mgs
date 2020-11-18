import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/helpers/class_serializers.dart';

part 'club_time.g.dart';

// enum is _sort of_ syntactical sugar for integers — basically a replacement for using an integer 0-6 to make life easier for programmers
// unlike enums in other languages, dart's act a little different to actual integers
// https://dart.dev/guides/language/language-tour#enumerated-types
enum DayOfWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday
}

@JsonSerializable(nullable: false)
class ClubTime {
  // an enum type
  DayOfWeek _dayOfWeek;
  // TimeOfDay is independent of time zones (incl. DST), much like MGS clubs
  // since JsonSerializable doesn't know how to serialize a TimeOfDay instance, we need to tell it using @JsonKey
  // @JsonKey is an 'annotation': https://dart.dev/guides/language/language-tour#metadata
  @JsonKey(fromJson: timeOfDayFromString, toJson: timeOfDayToString)
  TimeOfDay time;

  get dayOfWeek => _dayOfWeek;
  set dayOfWeek(dynamic value) {
    // the assert() keyword makes sure our program crashes dramatically (only in development) should the statement be false
    // https://dart.dev/guides/language/language-tour#assert
    assert(value is DayOfWeek || value is int);

    if (value is DayOfWeek) {
      _dayOfWeek = value;
    } else if (value is int) {
      assert(value >= 0 && value <= 6);
      _dayOfWeek = DayOfWeek.values[value];
    }
  }

  // TODO: replace this line with your code for GitHub issue #2

  ClubTime();
  factory ClubTime.fromJson(Map<String, dynamic> json) => _$ClubTimeFromJson(json);
  Map<String, dynamic> toJson() => _$ClubTimeToJson(this);
}