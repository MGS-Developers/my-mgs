import 'package:json_annotation/json_annotation.dart';

part 'term.g.dart';

@JsonSerializable()
class Term {
  int startWeek;
  int endWeek;

  int? cateringWeek;

  Term({
    required this.startWeek,
    required this.endWeek,
  });
  factory Term.fromJson(Map<String, dynamic> json) => _$TermFromJson(json);
  Map<String, dynamic> toJson() => _$TermToJson(this);
}