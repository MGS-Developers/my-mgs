import 'package:flutter/material.dart';
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

@JsonSerializable(nullable: false)
class ClubTime {
  // an enum type
  DayOfWeek dayOfWeek;
  // TimeOfDay is independent of time zones (incl. DST), much like MGS clubs
  // since JsonSerializable doesn't know how to serialize a TimeOfDay instance, we need to tell it using @JsonKey
  // @JsonKey is an 'annotation': https://dart.dev/guides/language/language-tour#metadata
  @JsonKey(fromJson: timeOfDayFromString, toJson: timeOfDayToString)
  TimeOfDay time;

  // TODO: replace this line with your code for GitHub issue #2

  ClubTime();
  factory ClubTime.fromJson(Map<String, dynamic> json) => _$ClubTimeFromJson(json);
  Map<String, dynamic> toJson() => _$ClubTimeToJson(this);
}