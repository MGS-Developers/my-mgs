import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data/sportsday/caching.dart';
import 'package:mymgs/data_classes/sportsday/standing_record.dart';

final _firestore = FirebaseFirestore.instance;
Stream<List<StandingRecord>> getStandingRecordStream(int yearGroup) {
  return _firestore.collection('sd_standing_records')
      .where('yearGroup', isEqualTo: yearGroup)
      .snapshots()
      .asyncMap((snapshot) async {
        final standingRecords = snapshot.docs.map((e) => StandingRecord.fromJson({
          'id': e.id,
          ...e.data(),
        })).toList();

        for (final record in standingRecords) {
          record.eventGroup = await SportsDayCaching.getEventGroup(record.scoreSpecId, record.eventGroupId);
        }

        return standingRecords;
  });
}
