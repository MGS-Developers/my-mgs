
import 'package:json_annotation/json_annotation.dart';

part 'event_group.g.dart';

@JsonSerializable()
class EventGroup {
  String id;
  String name;
  int subEventCount;

  EventGroup({
    required this.id,
    required this.name,
    required this.subEventCount,
  });

  factory EventGroup.fromJson(Map<String, dynamic> json) => _$EventGroupFromJson(json);
  Map<String, dynamic> toJson() => _$EventGroupToJson(this);
}