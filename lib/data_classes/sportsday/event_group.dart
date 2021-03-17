
import 'package:json_annotation/json_annotation.dart';

part 'event_group.g.dart';

@JsonSerializable()
class EventGroup {
  String id;
  String name;
  int subEventCount;
  String scoreSpecId;

  EventGroup({
    required this.id,
    required this.name,
    required this.subEventCount,
    required this.scoreSpecId,
  });

  factory EventGroup.fromJson(Map<String, dynamic> json) => _$EventGroupFromJson(json);
  Map<String, dynamic> toJson() => _$EventGroupToJson(this);
}