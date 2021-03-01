// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsItem _$NewsItemFromJson(Map<String, dynamic> json) {
  return NewsItem()
    ..id = json['id'] as String
    ..headline = json['headline'] as String
    ..body = json['body'] as String
    ..image = json['image'] == null
        ? null
        : MGSImage.fromJson(json['image'] as Map<String, dynamic>)
    ..createdAt = noopTransform(json['createdAt'])
    ..authorName = json['authorName'] as String
    ..links = (json['links'] as List)
        ?.map(
            (e) => e == null ? null : Link.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$NewsItemToJson(NewsItem instance) => <String, dynamic>{
      'id': instance.id,
      'headline': instance.headline,
      'body': instance.body,
      'image': instance.image,
      'createdAt': noopTransform(instance.createdAt),
      'authorName': instance.authorName,
      'links': instance.links,
    };
