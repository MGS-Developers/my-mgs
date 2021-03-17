// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    id: json['id'] as String,
    subEvent: json['subEvent'] as int,
    yearGroup: json['yearGroup'] as int,
    eventGroupId: json['eventGroupId'] as String,
    scoreSpecId: json['scoreSpecId'] as String,
  )..eventGroup = json['eventGroup'] == null
      ? null
      : EventGroup.fromJson(json['eventGroup'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'eventGroupId': instance.eventGroupId,
      'scoreSpecId': instance.scoreSpecId,
      'yearGroup': instance.yearGroup,
      'subEvent': instance.subEvent,
      'eventGroup': instance.eventGroup,
    };
