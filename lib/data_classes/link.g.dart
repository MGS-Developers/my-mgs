// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Link _$LinkFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['url']);
  return Link()
    ..label = json['label'] as String
    ..important = json['important'] as bool
    ..url = json['url'] as String;
}

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'label': instance.label,
      'important': instance.important,
      'url': instance.url,
    };
