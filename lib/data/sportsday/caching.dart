import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data/local_database.dart';
import 'package:mymgs/data_classes/sportsday/form.dart';
import 'package:sembast/sembast.dart';

// Due to the exorbitant amounts of data involved with Sports Day, we use some heavy
// caching where appropriate. A lot of data is extremely unlikely to change, and
// so we cache it to (a) speed up our users' experiences and (b) to reduce our bill.

final _firestore = FirebaseFirestore.instance;
final _cacheStore = StoreRef<String, dynamic>('sportsday_caching');

class SportsDayCaching {

  static final _formIdsRef = _cacheStore.record("form-ids");
  static Future<List<String>> getFormIds(int yearGroup) async {
    final db = await getDb();
    final rawFormIds = await _formIdsRef.get(db);
    if (rawFormIds != null) {
      final assembledFormIds = jsonDecode(rawFormIds) as Map;
      return new List<String>.from(assembledFormIds[yearGroup.toString()]);
    } else {
      final formsResponse = await _firestore.collection('sd_forms').get();

      var assembledFormIds = <String, List<String>>{};
      for (final formRef in formsResponse.docs) {
        final form = Form.fromJson({
          ...formRef.data(),
          'id': formRef.id,
        });

        final stringKey = form.yearGroup.toString();
        if (assembledFormIds.containsKey(stringKey)) {
          assembledFormIds[stringKey]!.add(form.id);
        } else {
          assembledFormIds[stringKey] = [form.id];
        }
      }

      await _formIdsRef.put(db, jsonEncode(assembledFormIds));

      return assembledFormIds[yearGroup.toString()] ?? [];
    }
  }
}