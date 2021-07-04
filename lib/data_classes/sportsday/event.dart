import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/data/sportsday/populate.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/helpers/class_serializers.dart';

part 'event.g.dart';

enum EventLocation {
  sports_hall,
  running_track_start,
  athletics_area,
}

@JsonSerializable()
class EventTimetable {
  @SerializableTimestampKey
  final Timestamp startTime;
  final EventLocation location;

  String get locationString {
    switch(location) {
      case EventLocation.athletics_area:
        return 'Athletics area';
      case EventLocation.running_track_start:
        return 'Start of running track';
      case EventLocation.sports_hall:
        return 'Sports Hall';
    }
  }

  EventTimetable({
    required this.startTime,
    required this.location,
  });

  factory EventTimetable.fromJson(Map<String, dynamic> json) => _$EventTimetableFromJson(json);
  Map<String, dynamic> toJson() => _$EventTimetableToJson(this);
}

@JsonSerializable()
class Event extends Serializable {
  String id;
  String eventGroupId;
  String scoreSpecId;
  int yearGroup;
  int subEvent;

  EventGroup? eventGroup;

  EventTimetable? timetable;

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
