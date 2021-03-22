// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survival_guide.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurvivalGuide _$SurvivalGuideFromJson(Map<String, dynamic> json) {
  return SurvivalGuide(
    id: json['id'] as String,
    name: json['name'] as String,
    contents: json['contents'] as String,
    folderName: json['folderName'] as String,
  )..collection = json['collection'] as String;
}

Map<String, dynamic> _$SurvivalGuideToJson(SurvivalGuide instance) =>
    <String, dynamic>{
      'collection': instance.collection,
      'id': instance.id,
      'folderName': instance.folderName,
      'name': instance.name,
      'contents': instance.contents,
    };
