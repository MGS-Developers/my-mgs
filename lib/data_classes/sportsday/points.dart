import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/helpers/class_serializers.dart';

part 'points.g.dart';

@JsonSerializable()
class FormPoints extends Serializable {
  int total;
  int yearPosition;
  int schoolPosition;

  FormPoints({
    required this.total,
    required this.yearPosition,
    required this.schoolPosition,
  });

  factory FormPoints.fromJson(Map<String, dynamic> json) => _$FormPointsFromJson(json);
  Map<String, dynamic> toJson() => _$FormPointsToJson(this);
}
