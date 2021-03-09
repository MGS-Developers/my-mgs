// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Form _$FormFromJson(Map<String, dynamic> json) {
  return Form(
    id: json['id'] as String,
    points: Points.fromJson(json['points'] as Map<String, dynamic>),
    yearGroup: json['yearGroup'] as int,
  );
}

Map<String, dynamic> _$FormToJson(Form instance) => <String, dynamic>{
      'id': instance.id,
      'yearGroup': instance.yearGroup,
      'points': instance.points,
    };
