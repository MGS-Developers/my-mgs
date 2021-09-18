// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wellbeing_organisation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WellbeingOrganisation _$WellbeingOrganisationFromJson(
        Map<String, dynamic> json) =>
    WellbeingOrganisation(
      name: json['name'] as String,
      caption: json['caption'] as String,
      color: json['color'] as String,
    )
      ..url = json['url'] as String?
      ..phoneNumber = json['phoneNumber'] as String?;

Map<String, dynamic> _$WellbeingOrganisationToJson(
        WellbeingOrganisation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'caption': instance.caption,
      'url': instance.url,
      'phoneNumber': instance.phoneNumber,
      'color': instance.color,
    };
