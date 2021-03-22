
import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/data_classes/identifiable.dart';

part 'survival_guide.g.dart';

@JsonSerializable()
class SurvivalGuide with Identifiable {
  final String collection = "survival_guides";
  String id;

  String folderName;
  String name;
  String contents;

  SurvivalGuide({
    required this.id,
    required this.name,
    required this.contents,
    required this.folderName,
  });
  factory SurvivalGuide.fromJson(Map<String, dynamic> json) => _$SurvivalGuideFromJson(json);
  Map<String, dynamic> toJson() => _$SurvivalGuideToJson(this);
}