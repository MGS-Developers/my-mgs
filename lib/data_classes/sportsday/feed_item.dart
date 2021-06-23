import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/data_classes/image.dart';
import 'package:mymgs/helpers/class_serializers.dart';

part 'feed_item.g.dart';

@JsonSerializable(createToJson: false)
class EventFeedItem {
  final String id;
  final String groupId;
  final String name;
  final int yearGroup;
  final int subEvent;
  final int subEventCount;
  final String scoreSpecId;

  const EventFeedItem({
    required this.id,
    required this.name,
    required this.subEvent,
    required this.subEventCount,
    required this.groupId,
    required this.yearGroup,
    required this.scoreSpecId,
  });

  factory EventFeedItem.fromJson(Map<String, dynamic> json) => _$EventFeedItemFromJson(json);
}

@JsonSerializable(createToJson: false)
class MediaFeedItem {
  // supports basic markdown syntax
  final String text;
  final String author;
  final MGSImage? image;

  const MediaFeedItem({
    required this.text,
    required this.author,
    this.image,
  });
  factory MediaFeedItem.fromJson(Map<String, dynamic> json) => _$MediaFeedItemFromJson(json);
}

@JsonSerializable(createToJson: false)
class FeedItem {
  final String id;

  final EventFeedItem? event;
  final MediaFeedItem? media;
  @NoopKey
  final Timestamp timestamp;

  const FeedItem({
    this.event,
    this.media,
    required this.timestamp,
    required this.id,
  });

  factory FeedItem.fromJson(Map<String, dynamic> json) => _$FeedItemFromJson(json);
}
