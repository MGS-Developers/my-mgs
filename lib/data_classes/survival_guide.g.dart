// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survival_guide.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurvivalGuide _$SurvivalGuideFromJson(Map<String, dynamic> json) =>
    SurvivalGuide(
      id: json['id'] as String,
      name: json['name'] as String,
      contents: json['contents'] as String,
      folderName: json['folderName'] as String,
    );

Map<String, dynamic> _$SurvivalGuideToJson(SurvivalGuide instance) =>
    <String, dynamic>{
      'id': instance.id,
      'folderName': instance.folderName,
      'name': instance.name,
      'contents': instance.contents,
    };
