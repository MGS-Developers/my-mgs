
import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/helpers/class_serializers.dart';

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

  @override
  int get hashCode => stringToInt(id);

  @override
  bool operator ==(Object other) {
    if (!(other is EventGroup)) return false;
    return id == other.id;
  }
}
