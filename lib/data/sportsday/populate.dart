import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data_classes/sportsday/event.dart';
import 'package:mymgs/data_classes/sportsday/form.dart';
import 'package:mymgs/data_classes/sportsday/score.dart';

final _firestore = FirebaseFirestore.instance;

Future<ScoreNode> populateScoreNode(ScoreNode instance) async {
  final _eventResponse = await _firestore.collection('sd_events').doc(instance.eventId).get();
  final _eventData = _eventResponse.data();

  final _formResponse = await _firestore.collection('sd_forms').doc(instance.formId).get();
  final _formData = _formResponse.data();

  if (_formData == null || _eventData == null) {
    throw Exception("Could not find form or event for ScoreNode ${instance.id}");
  }

  return instance
      ..event = Event.fromJson(_eventData)
      ..form = Form.fromJson(_formData);
}
