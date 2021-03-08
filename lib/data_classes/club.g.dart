// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Club _$ClubFromJson(Map<String, dynamic> json) {
  return Club(
    name: json['name'] as String,
    time: ClubTime.fromJson(json['time'] as Map<String, dynamic>),
  )
    ..id = json['id'] as String
    ..description = json['description'] as String?
    ..yearGroups =
        (json['yearGroups'] as List<dynamic>?)?.map((e) => e as int).toList()
    ..location = json['location'] as String?
    ..staffName = json['staffName'] as String?
    ..staffEmail = json['staffEmail'] as String?
    ..links = (json['links'] as List<dynamic>?)
        ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ClubToJson(Club instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'yearGroups': instance.yearGroups,
      'time': instance.time,
      'location': instance.location,
      'staffName': instance.staffName,
      'staffEmail': instance.staffEmail,
      'links': instance.links,
    };
