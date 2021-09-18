import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/data_classes/identifiable.dart';
import 'package:mymgs/data_classes/image.dart';
import 'package:mymgs/helpers/class_serializers.dart';

part 'charities_shop_item.g.dart';

@JsonSerializable(createToJson: false)
class CharitiesShopItem with Identifiable {
  @JsonKey(ignore: true)
  final String collection = "charity_shop_items";

  final String id;
  final String name;
  final String description;
  final MGSImage? image;
  final int price;

  CharitiesShopItem({
    required this.id,
    required this.name,
    required this.description,
    this.image,
    required this.price,
  });

  factory CharitiesShopItem.fromJson(Map<String, dynamic> json) => _$CharitiesShopItemFromJson(json);

  @override
  int get hashCode => stringToInt(id);

  @override
  bool operator ==(Object other) {
    if (!(other is CharitiesShopItem)) {
      return false;
    }
    return id == other.id;
  }
}
