// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsItem _$NewsItemFromJson(Map<String, dynamic> json) => NewsItem(
      headline: json['headline'] as String,
      body: json['body'] as String,
      image: MGSImage.fromJson(json['image'] as Map<String, dynamic>),
      createdAt: noopTransform(json['createdAt']),
      authorName: json['authorName'] as String,
    )
      ..id = json['id'] as String
      ..links = (json['links'] as List<dynamic>?)
          ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$NewsItemToJson(NewsItem instance) => <String, dynamic>{
      'id': instance.id,
      'headline': instance.headline,
      'body': instance.body,
      'image': instance.image,
      'createdAt': noopTransform(instance.createdAt),
      'authorName': instance.authorName,
      'links': instance.links,
    };
