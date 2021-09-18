// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catering_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CateringItem _$CateringItemFromJson(Map<String, dynamic> json) => CateringItem(
      week: json['week'] as int,
      dayOfWeek: _$enumDecode(_$DayOfWeekEnumMap, json['dayOfWeek']),
      menuItems: (json['menuItems'] as List<dynamic>)
          .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..id = json['id'] as String
      ..yearGroups =
          (json['yearGroups'] as List<dynamic>?)?.map((e) => e as int).toList()
      ..location = json['location'] as String?;

Map<String, dynamic> _$CateringItemToJson(CateringItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'week': instance.week,
      'yearGroups': instance.yearGroups,
      'dayOfWeek': _$DayOfWeekEnumMap[instance.dayOfWeek],
      'menuItems': instance.menuItems,
      'location': instance.location,
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

const _$DayOfWeekEnumMap = {
  DayOfWeek.Monday: 0,
  DayOfWeek.Tuesday: 1,
  DayOfWeek.Wednesday: 2,
  DayOfWeek.Thursday: 3,
  DayOfWeek.Friday: 4,
  DayOfWeek.Saturday: 5,
  DayOfWeek.Sunday: 6,
};
