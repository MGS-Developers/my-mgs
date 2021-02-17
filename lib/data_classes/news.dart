import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/data_classes/image.dart';
import 'package:mymgs/helpers/class_serializers.dart';

part 'news.g.dart';

@JsonSerializable()
class NewsItem {
  String id;
  String headline;
  String body;
  MGSImage image;
  @JsonKey(fromJson: noopTransform, toJson: noopTransform)
  Timestamp createdAt;
  String authorName;

  NewsItem();
  factory NewsItem.fromJson(Map<String, dynamic> json) => _$NewsItemFromJson(json);
  Map<String, dynamic> toJson() => _$NewsItemToJson(this);
}