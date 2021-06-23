import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data_classes/sportsday/event.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/data_classes/sportsday/score.dart';

final _firestore = FirebaseFirestore.instance;

Stream<List<ScoreNode>> getLatestResults(String formId, [int limit = 5]) {
  return _firestore
      .collection('sd_score_nodes')
      .where('formId', isEqualTo: formId)
      .orderBy('createdAt', descending: true)
      .limit(limit)
      .snapshots()
      .asyncMap((snapshot) async {
        final List<ScoreNode> results = [];
        for (final doc in snapshot.docs) {
          final scoreNode = ScoreNode.fromJson({
            'id': doc.id,
            ...doc.data(),
          });

          await scoreNode.populate();
          await scoreNode.event!.populateEventGroup();
          results.add(scoreNode);
        }

        return results;
  });
}

Future<Event?> getEventFromComponents(EventGroup eventGroup, int subEvent, int yearGroup) async {
  final response = await _firestore.collectionGroup('sd_events')
      .where('eventGroupId', isEqualTo: eventGroup.id)
      .where('subEvent', isEqualTo: subEvent)
      .where('yearGroup', isEqualTo: yearGroup)
      .get();

  if (response.size == 0) {
    return null;
  }

  final data = response.docs[0].data();
  return Event.fromJson({
    ...data,
    'id': response.docs[0].id,
  });
}
