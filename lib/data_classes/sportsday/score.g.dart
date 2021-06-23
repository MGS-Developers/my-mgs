// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbsoluteScore _$AbsoluteScoreFromJson(Map<String, dynamic> json) {
  return AbsoluteScore(
    units: _$enumDecode(_$RecordUnitsEnumMap, json['units']),
    value: (json['value'] as num).toDouble(),
    competitorName: json['competitorName'] as String,
    isNewRecord: json['isNewRecord'] as bool,
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

ScoreNode _$ScoreNodeFromJson(Map<String, dynamic> json) {
  return ScoreNode(
    formId: json['formId'] as String,
    eventId: json['eventId'] as String,
    position: json['position'] as int,
    calculatedPoints: json['calculatedPoints'] as int?,
    absolute: json['absolute'] == null
        ? null
        : AbsoluteScore.fromJson(json['absolute'] as Map<String, dynamic>),
    id: json['id'] as String,
    createdAt: noopTransform(json['createdAt']),
  )..event = json['event'] == null
      ? null
      : Event.fromJson(json['event'] as Map<String, dynamic>);
}
