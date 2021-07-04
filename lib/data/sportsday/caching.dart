import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data/local_database.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/data_classes/sportsday/event.dart';
import 'package:mymgs/data_classes/sportsday/form.dart';
import 'package:mymgs/helpers/class_serializers.dart';
import 'package:sembast/sembast.dart';

// Due to the exorbitant amounts of data involved with Sports Day, we use some heavy
// caching where appropriate. A lot of data is extremely unlikely to change, and
// so we cache it to (a) speed up our users' experiences and (b) to reduce our bill.

final _firestore = FirebaseFirestore.instance;
final _cacheStore = StoreRef<String, dynamic>('sportsday_caching');

typedef Future<Map<String, dynamic>> QueryRunner<T extends Serializable?>();
typedef T Builder<T extends Serializable?>(Map<String, dynamic> raw);

class SportsDayCaching {
  /// An extensible low-level caching function
  ///
  /// [ref] is the ID to store for this piece of data in cache
  ///
  /// [runner] is a function to fetch live data and return decoded JSON form (as a [Map])
  ///
  /// [builder] takes decoded JSON form (e.g. that returned by runner) and constructs [T] from it
  static Future<T> _get<T extends Serializable?>(String ref, QueryRunner<T> runner, Builder<T> builder) async {
    final db = await getDb();
    final raw = await _cacheStore.record(ref).get(db);
    if (raw != null) {
      try {
        return builder(jsonDecode(raw));
      } catch (e) {
        // if reconstruction fails (i.e. cache is corrupt), delete cached item and retry with live data
        await _cacheStore.record(ref).delete(db);
      }
    }

    final response = await runner();
    // build the response before saving to cache to ensure custom serialization of complex types (e.g. Timestamp) takes place
    final builtResponse = builder(response);

    if (builtResponse == null) {
      return null as T;
    }

    await _cacheStore.record(ref).put(db, jsonEncode(builtResponse.toJson()));
    return builtResponse;
  }

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

  static Future<EventGroup> getEventGroup(String scoreSpecId, String eventGroupId) {
    return _get<EventGroup>(
      "eg-$eventGroupId",
      () async {
        final response = await _firestore.collection('sd_score_specs').doc(scoreSpecId)
            .collection('sd_event_groups').doc(eventGroupId)
            .get();
        return {
          'id': response.id,
          ...?response.data(),
        };
      },
      (raw) => EventGroup.fromJson(raw),
    );
  }

  static Future<Event> getEvent(String id) {
    return _get<Event>(
      "ev-$id",
      () async {
        final response = await _firestore.collectionGroup('sd_events')
            .where('_id', isEqualTo: id)
            .get();

        final doc = response.docs.elementAt(0);
        return {
          'id': doc.id,
          ...doc.data(),
        };
      },
      (raw) => Event.fromJson(raw),
    );
  }

  static Future<Event?> getEventFromComponents(EventGroup eventGroup, int subEvent, int yearGroup) {
    return _get<Event?>(
      "evc-$eventGroup-$subEvent-$yearGroup",
      () async {
        final response = await _firestore.collectionGroup('sd_events')
            .where('eventGroupId', isEqualTo: eventGroup.id)
            .where('subEvent', isEqualTo: subEvent)
            .where('yearGroup', isEqualTo: yearGroup)
            .get();

        if (response.size == 0) {
          return {};
        }

        final doc = response.docs[0];
        return {
          'id': doc.id,
          ...doc.data(),
        };
      },
      (raw) {
        if (raw.isEmpty) {
          return null;
        } else {
          return Event.fromJson(raw);
        }
      }
    );
  }
}
