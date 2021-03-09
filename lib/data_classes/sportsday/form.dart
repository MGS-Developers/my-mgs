
import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/data_classes/sportsday/points.dart';

part 'form.g.dart';

@JsonSerializable()
class Form {
  String id;
  int yearGroup;
  Points points;

  Form({
    required this.id,
    required this.points,
    required this.yearGroup,
  });
  factory Form.fromJson(Map<String, dynamic> json) => _$FormFromJson(json);
  Map<String, dynamic> toJson() => _$FormToJson(this);
}