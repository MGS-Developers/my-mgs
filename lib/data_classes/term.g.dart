// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Term _$TermFromJson(Map<String, dynamic> json) {
  return Term()
    ..startWeek = json['startWeek'] as int
    ..endWeek = json['endWeek'] as int
    ..cateringWeek = json['cateringWeek'] as int;
}

Map<String, dynamic> _$TermToJson(Term instance) => <String, dynamic>{
      'startWeek': instance.startWeek,
      'endWeek': instance.endWeek,
      'cateringWeek': instance.cateringWeek,
    };
