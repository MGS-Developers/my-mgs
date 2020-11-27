import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/data_classes/club_time.dart';

part 'catering_item.g.dart';

@JsonSerializable()
class CateringItem {
  String id;

  int week;
  List<int> yearGroups;
  DayOfWeek dayOfWeek;
  List<String> menuItems;
  String location;

  CateringItem();
  factory CateringItem.fromJson(Map<String, dynamic> json) => _$CateringItemFromJson(json);
  Map<String, dynamic> toJson() => _$CateringItemToJson(this);
}