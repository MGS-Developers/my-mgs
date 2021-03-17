// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormPoints _$FormPointsFromJson(Map<String, dynamic> json) {
  return FormPoints(
    total: json['total'] as int,
    yearPosition: json['yearPosition'] as int,
    schoolPosition: json['schoolPosition'] as int,
  );
}

Map<String, dynamic> _$FormPointsToJson(FormPoints instance) =>
    <String, dynamic>{
      'total': instance.total,
      'yearPosition': instance.yearPosition,
      'schoolPosition': instance.schoolPosition,
    };
