import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data_classes/sportsday/feed_item.dart';

final _firestore = FirebaseFirestore.instance;
Stream<List<FeedItem>> getScoreNodeStream() {
  return _firestore
      .collection('sd_feed')
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((e) => FeedItem.fromJson({
          'id': e.id,
          ...e.data(),
        })).toList();
  });
}
