// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventFeedItem _$EventFeedItemFromJson(Map<String, dynamic> json) =>
    EventFeedItem(
      id: json['id'] as String,
      name: json['name'] as String,
      subEvent: json['subEvent'] as int,
      subEventCount: json['subEventCount'] as int,
      groupId: json['groupId'] as String,
      yearGroup: json['yearGroup'] as int,
      scoreSpecId: json['scoreSpecId'] as String,
    );

MediaFeedItem _$MediaFeedItemFromJson(Map<String, dynamic> json) =>
    MediaFeedItem(
      text: json['text'] as String,
      author: json['author'] as String,
      image: json['image'] == null
          ? null
          : MGSImage.fromJson(json['image'] as Map<String, dynamic>),
    );

FeedItem _$FeedItemFromJson(Map<String, dynamic> json) => FeedItem(
      event: json['event'] == null
          ? null
          : EventFeedItem.fromJson(json['event'] as Map<String, dynamic>),
      media: json['media'] == null
          ? null
          : MediaFeedItem.fromJson(json['media'] as Map<String, dynamic>),
      timestamp: noopTransform(json['timestamp']),
      id: json['id'] as String,
    );
