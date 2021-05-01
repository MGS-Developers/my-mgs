import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';

final _firestore = FirebaseFirestore.instance;

Future<List<EventGroup>> getEventGroups() async {
  final response = await _firestore
      .collectionGroup('sd_event_groups')
      .orderBy('name', descending: false)
      .get();

  return response.docs.map((doc) => EventGroup.fromJson({
    'id': doc.id,
    ...doc.data(),
  })).toList();
}
