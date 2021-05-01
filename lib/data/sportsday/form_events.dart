import 'package:cloud_firestore/cloud_firestore.dart';
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

          await scoreNode.populateEvent();
          await scoreNode.event!.populateEventGroup();
          results.add(scoreNode);
        }

        return results;
  });
}
