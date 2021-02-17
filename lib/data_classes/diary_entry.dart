import 'package:json_annotation/json_annotation.dart';

part 'diary_entry.g.dart';

@JsonSerializable()
class SubjectEntry {
  String subject;
  String homework;

  SubjectEntry();
  factory SubjectEntry.fromJson(Map<String, dynamic> json) => _$SubjectEntryFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectEntryToJson(this);
}

@JsonSerializable()
class DiaryEntry {
  DateTime day;
  List<SubjectEntry> subjectEntries;

  DiaryEntry();
  factory DiaryEntry.fromJson(Map<String, dynamic> json) => _$DiaryEntryFromJson(json);
  Map<String, dynamic> toJson() => _$DiaryEntryToJson(this);
}
