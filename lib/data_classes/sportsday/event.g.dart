// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventTimetable _$EventTimetableFromJson(Map<String, dynamic> json) =>
    EventTimetable(
      startTime: timestampFromJson(json['startTime']),
      location: _$enumDecode(_$EventLocationEnumMap, json['location']),
    );

Map<String, dynamic> _$EventTimetableToJson(EventTimetable instance) =>
    <String, dynamic>{
      'startTime': timestampToJson(instance.startTime),
      'location': _$EventLocationEnumMap[instance.location],
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

const _$EventLocationEnumMap = {
  EventLocation.sports_hall: 'sports_hall',
  EventLocation.running_track_start: 'running_track_start',
  EventLocation.athletics_area: 'athletics_area',
};

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as String,
      subEvent: json['subEvent'] as int,
      yearGroup: json['yearGroup'] as int,
      eventGroupId: json['eventGroupId'] as String,
      scoreSpecId: json['scoreSpecId'] as String,
    )
      ..eventGroup = json['eventGroup'] == null
          ? null
          : EventGroup.fromJson(json['eventGroup'] as Map<String, dynamic>)
      ..timetable = json['timetable'] == null
          ? null
          : EventTimetable.fromJson(json['timetable'] as Map<String, dynamic>);

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'eventGroupId': instance.eventGroupId,
      'scoreSpecId': instance.scoreSpecId,
      'yearGroup': instance.yearGroup,
      'subEvent': instance.subEvent,
      'eventGroup': instance.eventGroup,
      'timetable': instance.timetable,
    };
