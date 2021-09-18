// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charities_shop_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharitiesShopItem _$CharitiesShopItemFromJson(Map<String, dynamic> json) =>
    CharitiesShopItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] == null
          ? null
          : MGSImage.fromJson(json['image'] as Map<String, dynamic>),
      price: json['price'] as int,
    );
