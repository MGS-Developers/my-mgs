import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/data_classes/club_time.dart';
import 'package:mymgs/data_classes/identifiable.dart';
import 'package:mymgs/data_classes/menu_item.dart';

part 'catering_item.g.dart';

@JsonSerializable()
class CateringItem with Identifiable {
  @JsonKey(ignore: true)
  final String collection = "catering";

  int week;
  List<int>? yearGroups;
  DayOfWeek dayOfWeek;
  List<MenuItem> menuItems;
  String? location;

  CateringItem({
    required this.week,
    required this.dayOfWeek,
    required this.menuItems,
  });
  factory CateringItem.fromJson(Map<String, dynamic> json) => _$CateringItemFromJson(json);
  Map<String, dynamic> toJson() => _$CateringItemToJson(this);
}