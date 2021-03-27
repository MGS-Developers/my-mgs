import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/data_classes/club.dart';
import 'package:mymgs/data_classes/link.dart';
import 'package:mymgs/data_classes/shareable.dart';
import 'package:mymgs/helpers/class_serializers.dart';
import 'package:mymgs/helpers/deep_link.dart';

import 'identifiable.dart';

part 'event.g.dart';

@JsonSerializable()
class Event with Identifiable, Shareable {
  @JsonKey(ignore: true)
  final String collection = "events";
  @JsonKey(ignore: true)
  final DeepLinkResource resource = DeepLinkResource.event;

  String title;
  /// short, plaintext summary (<50 words)
  String? summary;
  /// longer, markdown-enabled abstract
  String? description;
  String? imageUrl;
  List<int>? yearGroups;

  @NoopKey
  Timestamp startTime;
  @NoopKey
  Timestamp endTime;

  /// Firestore only stores [Event.clubId] — data query functions may populate [Event.club]
  Club? club;
  String? clubId;

  /// When [Event.clubId] resolves to a real club, the club's location will be used.
  /// In this case, [Event.location] is optional.
  ///
  /// If [Event.clubId] is null or cannot be resolved, [Event.location] is required.
  ///
  /// If [Event.location] is provided AND [Event.clubId] can be resolved, [Event.location] will override [Club.location]
  ///
  /// In any case, [Event.location] must be a non-null string after transformation
  String? location;

  List<Link>? links;

  Event({
    required this.startTime,
    required this.endTime,
    required this.title,
  });
  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}
