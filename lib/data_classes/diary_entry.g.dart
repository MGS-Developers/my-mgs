// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectEntry _$SubjectEntryFromJson(Map<String, dynamic> json) => SubjectEntry(
      subject: json['subject'] as String,
    )
      ..homework = json['homework'] as String?
      ..dueDate = json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String)
      ..complete = json['complete'] as bool;

Map<String, dynamic> _$SubjectEntryToJson(SubjectEntry instance) =>
    <String, dynamic>{
      'subject': instance.subject,
      'homework': instance.homework,
      'dueDate': instance.dueDate?.toIso8601String(),
      'complete': instance.complete,
    };

DiaryEntry _$DiaryEntryFromJson(Map<String, dynamic> json) => DiaryEntry(
      subjectEntries: (json['subjectEntries'] as List<dynamic>)
          .map((e) => SubjectEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..day = json['day'] == null ? null : DateTime.parse(json['day'] as String);

Map<String, dynamic> _$DiaryEntryToJson(DiaryEntry instance) =>
    <String, dynamic>{
      'day': instance.day?.toIso8601String(),
      'subjectEntries': mapSubjectEntries(instance.subjectEntries),
    };
