import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/data_classes/sportsday/score.dart';

final _firestore = FirebaseFirestore.instance;

Stream<List<ScoreNode>> getEventGroupScoreNodes({
  required int yearGroup,
  required EventGroup eventGroup,
  required int subEvent,
}) async* {
  final eventIdResponse = await _firestore
      .collection('sd_score_specs')
      .doc(eventGroup.scoreSpecId)
      .collection('sd_event_groups')
      .doc(eventGroup.id)
      .collection('sd_events')
      .where('subEvent', isEqualTo: subEvent)
      .where('yearGroup', isEqualTo: yearGroup)
      .get();
  if (eventIdResponse.docs.isEmpty) throw Exception("No Event found for ScoreSpec and EventGroup IDs.");
  final eventId = eventIdResponse.docs[0].id;

  final formIdsResponse = await _firestore
      .collection('sd_forms')
      .where('yearGroup', isEqualTo: yearGroup)
      .get();
  final formIds = formIdsResponse.docs.map((e) => e.id).toList();

  yield* _firestore
      .collection('sd_score_nodes')
      .where('eventId', isEqualTo: eventId)
      .where('formId', whereIn: formIds)
      .orderBy('position', descending: false)
      .snapshots()
      .asyncMap((snapshot) async {
        final scoreNodes = snapshot.docs.map((scoreNode) => ScoreNode.fromJson({
          'id': scoreNode.id,
          ...?scoreNode.data(),
        })).toList();

        for (final node in scoreNodes) {
          await node.populateForm();
        }

        return scoreNodes;
  });
}
