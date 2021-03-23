import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/data_classes/identifiable.dart';
import 'package:mymgs/data_classes/image.dart';
import 'package:mymgs/data_classes/shareable.dart';
import 'package:mymgs/helpers/class_serializers.dart';
import 'package:mymgs/helpers/deep_link.dart';

import 'link.dart';

part 'news.g.dart';

@JsonSerializable()
class NewsItem with Identifiable, Shareable {
  @JsonKey(ignore: true)
  final String collection = "news";
  @JsonKey(ignore: true)
  final DeepLinkResource resource = DeepLinkResource.newsItem;

  String headline;
  String body;
  MGSImage image;
  @JsonKey(fromJson: noopTransform, toJson: noopTransform)
  Timestamp createdAt;
  String authorName;
  List<Link>? links;

  NewsItem({
    required this.headline,
    required this.body,
    required this.image,
    required this.createdAt,
    required this.authorName,
  });
  factory NewsItem.fromJson(Map<String, dynamic> json) => _$NewsItemFromJson(json);
  Map<String, dynamic> toJson() => _$NewsItemToJson(this);
}