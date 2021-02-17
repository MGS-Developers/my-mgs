// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectEntry _$SubjectEntryFromJson(Map<String, dynamic> json) {
  return SubjectEntry()
    ..subject = json['subject'] as String
    ..homework = json['homework'] as String;
}

Map<String, dynamic> _$SubjectEntryToJson(SubjectEntry instance) =>
    <String, dynamic>{
      'subject': instance.subject,
      'homework': instance.homework,
    };

DiaryEntry _$DiaryEntryFromJson(Map<String, dynamic> json) {
  return DiaryEntry()
    ..day = json['day'] == null ? null : DateTime.parse(json['day'] as String)
    ..subjectEntries = (json['subjectEntries'] as List)
        ?.map((e) =>
            e == null ? null : SubjectEntry.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$DiaryEntryToJson(DiaryEntry instance) =>
    <String, dynamic>{
      'day': instance.day?.toIso8601String(),
      'subjectEntries': instance.subjectEntries,
    };
