import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  String id;
  int yearGroup;
  int subEvent;
  String eventGroupId;

  Event({
    required this.id,
    required this.subEvent,
    required this.eventGroupId,
    required this.yearGroup,
  });
  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}
