// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standing_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StandingRecord _$StandingRecordFromJson(Map<String, dynamic> json) {
  return StandingRecord(
    holder: json['holder'] as String,
    value: (json['value'] as num).toDouble(),
    units: _$enumDecode(_$RecordUnitsEnumMap, json['units']),
    year: json['year'] as int,
    yearGroup: json['yearGroup'] as int,
    eventGroup: json['eventGroup'] == null
        ? null
        : EventGroup.fromJson(json['eventGroup'] as Map<String, dynamic>),
    eventGroupId: json['eventGroupId'] as String,
    scoreSpecId: json['scoreSpecId'] as String,
  );
}

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

const _$RecordUnitsEnumMap = {
  RecordUnits.meters: 'meters',
  RecordUnits.seconds: 'seconds',
};
