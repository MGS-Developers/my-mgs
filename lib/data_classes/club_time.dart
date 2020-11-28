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

  String toDisplayString() {
    // TimeOfDay stores an hour and minute value in 24hr time. The 'hourOfPeriod' function returns the stored hour value in 12hr time (24hr - 12).
    // The below code then combines the 12 hour value with the minute value, as well as the period value which stores if the time is am or pm.
    String displayTime = time.hourOfPeriod.toString() + ":" + time.minute.toString() + time.period.toString();
    return ("Every " + _dayOfWeek.toString() + " at " + displayTime);
  }

  ClubTime();
  factory ClubTime.fromJson(Map<String, dynamic> json) => _$ClubTimeFromJson(json);
  Map<String, dynamic> toJson() => _$ClubTimeToJson(this);


}