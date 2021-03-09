
import 'package:json_annotation/json_annotation.dart';

part 'points.g.dart';

@JsonSerializable()
class Points {
  int num;

  /// In the context of [Form]: position within year group
  int? localPosition;

  /// In the context of [Form]: position within entire school
  int? globalPosition;

  Points({
    required this.num,
    this.localPosition,
    this.globalPosition,
  });

  factory Points.fromJson(Map<String, dynamic> json) => _$PointsFromJson(json);
  Map<String, dynamic> toJson() => _$PointsToJson(this);
}
