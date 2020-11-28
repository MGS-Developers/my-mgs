import 'package:json_annotation/json_annotation.dart';

part 'menu_item.g.dart';

@JsonSerializable(nullable: true)
class MenuItem {
  @JsonKey(nullable: false)
  String name;
  String description;
  String imageUrl;
  List<String> flags;

  MenuItem();
  factory MenuItem.fromJson(Map<String, dynamic> json) => _$MenuItemFromJson(json);
  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}