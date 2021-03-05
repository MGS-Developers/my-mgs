import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class MGSImage {
  String? thumbnailUrl;
  String? fullUrl;

  MGSImage();
  factory MGSImage.fromJson(Map<String, dynamic> json) => _$MGSImageFromJson(json);
  Map<String, dynamic> toJson() => _$MGSImageToJson(this);
}