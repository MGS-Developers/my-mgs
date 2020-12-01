// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) {
  return MenuItem()
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..imageUrl = json['imageUrl'] as String
    ..flags = (json['flags'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'flags': instance.flags,
    };
