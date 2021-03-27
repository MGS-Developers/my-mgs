
import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/data_classes/identifiable.dart';
import 'package:mymgs/data_classes/shareable.dart';
import 'package:mymgs/helpers/deep_link.dart';

part 'survival_guide.g.dart';

@JsonSerializable()
class SurvivalGuide with Identifiable, Shareable {
  @JsonKey(ignore: true)
  final String collection = "survival_guides";
  @JsonKey(ignore: true)
  final resource = DeepLinkResource.survivalGuide;

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