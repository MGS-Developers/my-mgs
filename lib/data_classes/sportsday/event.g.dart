// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    id: json['id'] as String,
    subEvent: json['subEvent'] as int,
    eventGroupId: json['eventGroupId'] as String,
    yearGroup: json['yearGroup'] as int,
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'yearGroup': instance.yearGroup,
      'subEvent': instance.subEvent,
      'eventGroupId': instance.eventGroupId,
    };
