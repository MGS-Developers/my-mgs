import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:crypto/crypto.dart';

part 'diary_entry.g.dart';

@JsonSerializable()
class SubjectEntry {
  String subject;
  String homework;
  DateTime dueDate;
  bool complete = false;

  SubjectEntry();
  factory SubjectEntry.fromJson(Map<String, dynamic> json) => _$SubjectEntryFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectEntryToJson(this);

  @override
  int get hashCode {
    final hashBase = subject + homework + dueDate.toIso8601String();
    return md5.convert(utf8.encode(hashBase)).hashCode;
  }

  @override
  bool operator ==(Object other) {
    return super.hashCode == other.hashCode;
  }
}

@JsonSerializable()
class DiaryEntry {
  DateTime day;
  List<SubjectEntry> subjectEntries;

  DiaryEntry();
  factory DiaryEntry.fromJson(Map<String, dynamic> json) => _$DiaryEntryFromJson(json);
  Map<String, dynamic> toJson() => _$DiaryEntryToJson(this);
}
