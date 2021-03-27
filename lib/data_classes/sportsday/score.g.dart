// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreNode _$ScoreNodeFromJson(Map<String, dynamic> json) {
  return ScoreNode(
    formId: json['formId'] as String,
    eventId: json['eventId'] as String,
    position: json['position'] as int,
    calculatedPoints: json['calculatedPoints'] as int?,
    id: json['id'] as String,
    createdAt: noopTransform(json['createdAt']),
  )
    ..event = json['event'] == null
        ? null
        : Event.fromJson(json['event'] as Map<String, dynamic>)
    ..form = json['form'] == null
        ? null
        : Form.fromJson(json['form'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ScoreNodeToJson(ScoreNode instance) => <String, dynamic>{
      'id': instance.id,
      'formId': instance.formId,
      'eventId': instance.eventId,
      'position': instance.position,
      'calculatedPoints': instance.calculatedPoints,
      'createdAt': noopTransform(instance.createdAt),
      'event': instance.event,
      'form': instance.form,
    };
