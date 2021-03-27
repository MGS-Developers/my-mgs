// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventGroup _$EventGroupFromJson(Map<String, dynamic> json) {
  return EventGroup(
    id: json['id'] as String,
    name: json['name'] as String,
    subEventCount: json['subEventCount'] as int,
    scoreSpecId: json['scoreSpecId'] as String,
  );
}

Map<String, dynamic> _$EventGroupToJson(EventGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subEventCount': instance.subEventCount,
      'scoreSpecId': instance.scoreSpecId,
    };
