import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/data/sportsday/populate.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  String id;
  String eventGroupId;
  String scoreSpecId;
  int yearGroup;
  int subEvent;

  EventGroup? eventGroup;

  Future<void> populateEventGroup() => eventGetGroup(this);

  Event({
    required this.id,
    required this.subEvent,
    required this.yearGroup,
    required this.eventGroupId,
    required this.scoreSpecId,
  });
  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}
