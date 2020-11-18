// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Club _$ClubFromJson(Map<String, dynamic> json) {
  return Club()
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..yearGroups = (json['yearGroups'] as List).map((e) => e as int).toList()
    ..time = ClubTime.fromJson(json['time'] as Map<String, dynamic>)
    ..staffName = json['staffName'] as String
    ..staffEmail = json['staffEmail'] as String;
}

Map<String, dynamic> _$ClubToJson(Club instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'yearGroups': instance.yearGroups,
      'time': instance.time,
      'staffName': instance.staffName,
      'staffEmail': instance.staffEmail,
    };
