// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventFeedItem _$EventFeedItemFromJson(Map<String, dynamic> json) {
  return EventFeedItem(
    id: json['id'] as String,
    name: json['name'] as String,
    subEvent: json['subEvent'] as int,
    subEventCount: json['subEventCount'] as int,
    groupId: json['groupId'] as String,
    yearGroup: json['yearGroup'] as int,
    scoreSpecId: json['scoreSpecId'] as String,
  );
}

FeedItem _$FeedItemFromJson(Map<String, dynamic> json) {
  return FeedItem(
    event: json['event'] == null
        ? null
        : EventFeedItem.fromJson(json['event'] as Map<String, dynamic>),
    timestamp: noopTransform(json['timestamp']),
    id: json['id'] as String,
  );
}
