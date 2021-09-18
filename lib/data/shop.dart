import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:mymgs/data_classes/charities_shop_item.dart';

final _firestore = FirebaseFirestore.instance;
final _functions = FirebaseFunctions.instanceFor(region: 'europe-west2');

class _PaymentIntentResponse {
  final String userCode;
  final String secret;
  const _PaymentIntentResponse({
    required this.userCode,
    required this.secret,
  });
}

class CharitiesShopData {
  static Future<List<CharitiesShopItem>> getItems() async {
    final response = await _firestore.collection('charity_shop_items').get();
    return response.docs.map((e) => CharitiesShopItem.fromJson({
      'id': e.id,
      ...e.data(),
    })).toList();
  }

  static Future<_PaymentIntentResponse> initialisePayment(Map<CharitiesShopItem, int> cart) async {
    var object = {
      'items': cart.entries.map((e) => {
        'quantity': e.value,
        'price': e.key.price,
        'name': e.key.name,
        'id': e.key.id,
      }).toList(),
    };

    final response = await _functions.httpsCallable(kReleaseMode ? 'createPaymentIntentLive' : 'createPaymentIntentTest')(object);
    return _PaymentIntentResponse(
      userCode: response.data['userCode'],
      secret: response.data['secret'],
    );
    return response.data;
  }
}
