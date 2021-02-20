import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data/setup.dart';
import 'package:mymgs/data_classes/club.dart';
import 'package:mymgs/data_classes/event.dart';

final _firestore = FirebaseFirestore.instance;

Future<void> _transformEvent(Event event) async {
  if (event.clubId == null) return;
  final clubResponse = await _firestore
      .collection('clubs')
      .doc(event.clubId)
      .get();

  if (!clubResponse.exists) return;
  event.club = Club.fromJson({
    ...clubResponse.data(),
    'id': clubResponse.id,
  });

  if (event.location == null && event.club.location != null) {
    event.location = event.club.location;
  }

  return;
}

Future<List<Event>> _mapEventList(QuerySnapshot response) async {
  final events = response.docs.map((e) => Event.fromJson({
    ...e.data(),
    'id': e.id,
  })).toList();

  for (final event in events) {
    await _transformEvent(event);
  }

  return events;
}

Future<List<Event>> getEvents({
  int yearGroup,
  int limit = 25,
}) async {
  final response = await _firestore
      .collection('events')
      .where('yearGroups', arrayContains: yearGroup)
      .where('startTime', isGreaterThan: Timestamp.now())
      .orderBy('startTime', descending: false)
      .limit(limit)
      .get();

  return _mapEventList(response);
}

Future<List<Event>> getTodaysEvents() async {
  final yearGroup = await getYearGroup();
  final response = await _firestore
      .collection('events')
      .where('yearGroups', arrayContains: yearGroup)
      .where('startTime', isGreaterThan: Jiffy().startOf(Units.DAY))
      .where('startTime', isLessThan: Jiffy().endOf(Units.DAY))
      .orderBy('startTime', descending: false)
      .get();

  return _mapEventList(response);
}
