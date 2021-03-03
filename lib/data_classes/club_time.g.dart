// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubTime _$ClubTimeFromJson(Map<String, dynamic> json) {
  return ClubTime()
    ..dayOfWeek = _$enumDecode(_$DayOfWeekEnumMap, json['dayOfWeek'])
    ..time = timeOfDayFromString(json['time'] as String);
}

Map<String, dynamic> _$ClubTimeToJson(ClubTime instance) => <String, dynamic>{
      'dayOfWeek': _$DayOfWeekEnumMap[instance.dayOfWeek],
      'time': timeOfDayToString(instance.time),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

const _$DayOfWeekEnumMap = {
  DayOfWeek.Monday: 0,
  DayOfWeek.Tuesday: 1,
  DayOfWeek.Wednesday: 2,
  DayOfWeek.Thursday: 3,
  DayOfWeek.Friday: 4,
  DayOfWeek.Saturday: 5,
  DayOfWeek.Sunday: 6,
};
