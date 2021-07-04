import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data/sportsday/caching.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/data_classes/sportsday/score.dart';

final _firestore = FirebaseFirestore.instance;

Stream<List<ScoreNode>> getEventGroupScoreNodes({
  required int yearGroup,
  required EventGroup eventGroup,
  required int subEvent,
  String? eventId,
}) async* {
  String? _eventId = eventId;
  if (_eventId == null) {
    final eventResponse = await SportsDayCaching.getEventFromComponents(eventGroup, subEvent, yearGroup);
    if (eventResponse == null) {
      throw Exception("No Event found for ScoreSpec and EventGroup IDs.");
    }
    eventId = eventResponse.id;
  }

  final formIds = await SportsDayCaching.getFormIds(yearGroup);

  yield* _firestore
      .collection('sd_score_nodes')
      .where('eventId', isEqualTo: eventId)
      .where('formId', whereIn: formIds)
      .orderBy('position', descending: false)
      .snapshots()
      .asyncMap((snapshot) async {
        final scoreNodes = snapshot.docs.map((scoreNode) => ScoreNode.fromJson({
          'id': scoreNode.id,
          ...scoreNode.data(),
        })).toList();

        return scoreNodes;
  });
}
