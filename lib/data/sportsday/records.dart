import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/data_classes/sportsday/score.dart';
import 'package:mymgs/data_classes/sportsday/standing_record.dart';

final _firestore = FirebaseFirestore.instance;
Future<List<MergedRecord>> getMergedRecords(int yearGroup) async {
  final response = await _firestore.collection('sd_standing_records')
      .where('yearGroup', isEqualTo: yearGroup)
      .get();

  final standingRecords = response.docs.map((e) => StandingRecord.fromJson({
    ...e.data(),
    'id': e.id,
  })).toList();

  final mergedRecords = <MergedRecord>[];
  for (final record in standingRecords) {
    final mergedRecord = MergedRecord(standingRecord: record);
    final eventGroupResponse = await _firestore.collection('sd_score_specs')
        .doc(record.scoreSpecId)
        .collection('sd_event_groups')
        .doc(record.eventGroupId)
        .get();

    assert(eventGroupResponse.exists);

    record.eventGroup = EventGroup.fromJson({
      ...eventGroupResponse.data()!,
      'id': eventGroupResponse.id,
    });

    final eventResponse = await eventGroupResponse.reference.collection("sd_events")
        .where("yearGroup", isEqualTo: yearGroup)
        // records only apply to A races (subEvent 0)
        .where("subEvent", isEqualTo: 0)
        .get();
    assert(eventResponse.size == 1);
    final eventId = eventResponse.docs[0].id;

    final scoreNodeResponse = await _firestore.collection("sd_score_nodes")
        .where("eventId", isEqualTo: eventId)
        // only winners of races can beat previous records
        .where("position", isEqualTo: 1)
        .get();
    if (scoreNodeResponse.size == 1) {
      final scoreNode = ScoreNode.fromJson({
        ...scoreNodeResponse.docs[0].data(),
        'id': scoreNodeResponse.docs[0].id,
      });
      mergedRecord.latestRecord = scoreNode.absolute;
    }

    mergedRecords.add(mergedRecord);
  }

  mergedRecords.sort((a, b) {
    return a.standingRecord.eventGroup!.name.compareTo(b.standingRecord.eventGroup!.name);
  });

  return mergedRecords;
}
