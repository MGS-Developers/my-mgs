// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubTime _$ClubTimeFromJson(Map<String, dynamic> json) => ClubTime(
      time: timeOfDayFromString(json['time'] as String),
    )..dayOfWeek = _$enumDecodeNullable(_$DayOfWeekEnumMap, json['dayOfWeek']);

Map<String, dynamic> _$ClubTimeToJson(ClubTime instance) => <String, dynamic>{
      'dayOfWeek': _$DayOfWeekEnumMap[instance.dayOfWeek],
      'time': timeOfDayToString(instance.time),
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
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
