// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Points _$PointsFromJson(Map<String, dynamic> json) {
  return Points(
    num: json['num'] as int,
    localPosition: json['localPosition'] as int?,
    globalPosition: json['globalPosition'] as int?,
  );
}

Map<String, dynamic> _$PointsToJson(Points instance) => <String, dynamic>{
      'num': instance.num,
      'localPosition': instance.localPosition,
      'globalPosition': instance.globalPosition,
    };
