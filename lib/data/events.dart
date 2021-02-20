import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data_classes/club.dart';
import 'package:mymgs/data_classes/event.dart';

final _firestore = FirebaseFirestore.instance;

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

  final events = response.docs.map((e) => Event.fromJson({
    ...e.data(),
    'id': e.id,
  })).toList();

  for (final event in events) {
    if (event.clubId == null) continue;
    final clubResponse = await _firestore
        .collection('clubs')
        .doc(event.clubId)
        .get();

    if (!clubResponse.exists) continue;
    event.club = Club.fromJson({
      ...clubResponse.data(),
      'id': clubResponse.id,
    });

    if (event.location == null && event.club.location != null) {
      event.location = event.club.location;
    }
  }

  return events;
}