import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data_classes/sportsday/event.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/data_classes/sportsday/score.dart';

final _firestore = FirebaseFirestore.instance;

Future<ScoreNode> populateScoreNode(ScoreNode instance) async {
  final _eventResponse = await _firestore.collectionGroup('sd_events')
      .where('_id', isEqualTo: instance.eventId)
      .get();
  final _eventData = _eventResponse.docs[0].data();

  instance.event = Event.fromJson({
    'id': _eventResponse.docs[0].id,
    ..._eventData,
  });

  return instance;
}

Future<Event> eventGetGroup(Event instance) async {
  final _eventGroupResponse = await _firestore
      .collection('sd_score_specs')
      .doc(instance.scoreSpecId)
      .collection('sd_event_groups')
      .doc(instance.eventGroupId)
      .get();

  final _eventGroupData = _eventGroupResponse.data();
  if (_eventGroupData == null) throw Exception("Event group for Event ${instance.id} not found.");

  instance.eventGroup = EventGroup.fromJson({
    'id': _eventGroupResponse.id,
    ..._eventGroupData,
  });
  return instance;
}
