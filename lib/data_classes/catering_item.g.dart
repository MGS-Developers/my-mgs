// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catering_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CateringItem _$CateringItemFromJson(Map<String, dynamic> json) {
  return CateringItem()
    ..id = json['id'] as String
    ..week = json['week'] as int
    ..yearGroups = (json['yearGroups'] as List)?.map((e) => e as int)?.toList()
    ..dayOfWeek = _$enumDecodeNullable(_$DayOfWeekEnumMap, json['dayOfWeek'])
    ..menuItems = (json['menuItems'] as List)?.map((e) => e as String)?.toList()
    ..location = json['location'] as String;
}

Map<String, dynamic> _$CateringItemToJson(CateringItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'week': instance.week,
      'yearGroups': instance.yearGroups,
      'dayOfWeek': _$DayOfWeekEnumMap[instance.dayOfWeek],
      'menuItems': instance.menuItems,
      'location': instance.location,
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

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
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
