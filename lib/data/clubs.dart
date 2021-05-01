/*
This file actually uses Firestore to make a query, so take a look at the code in here if you're unsure how to do it elsewhere
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data/local_database.dart';
import 'package:mymgs/data_classes/club.dart';
import 'package:mymgs/helpers/class_serializers.dart';
import 'package:mymgs/notifications/channels.dart';
import 'package:mymgs/notifications/reminders.dart';
import 'package:mymgs/notifications/scoping.dart';
import 'package:sembast/sembast.dart';

// get a reference to firestore at import time (i.e. on app startup)
// this is a performance optimization as we don't have to retrieve the instance on every function call
// always put this at the top level of your code, and use an _ before 'firestore' to ensure other files can't accidentally access it
FirebaseFirestore _firestore = FirebaseFirestore.instance;

// yearGroup is the year group to filter clubs for. it's optional, but when provided only applicable clubs will be shown
Future<List<Club>> getClubs({
  final int? yearGroup,
  final bool? todayOnly,
  final int? limit,
}) async {
  // form the basic query (CollectionReference extends Query so they can kinda be used interchangeably)
  Query clubsQuery = _firestore.collection('clubs')
      .orderBy('time.time', descending: false);

  if (yearGroup != null) {
    // where() has many filtering methods
    // this one, 'arrayContains', checks if the provided value is in the 'yearGroups' array of any document and filters to only retrieve those
    clubsQuery = clubsQuery.where('yearGroups', arrayContains: yearGroup);
  }
  
  if (todayOnly != null) {
    clubsQuery = clubsQuery.where('time.dayOfWeek', isEqualTo: DateTime.now().weekday - 1);
  }

  if (limit != null) {
    clubsQuery = clubsQuery.limit(limit);
  }

  // because of indexing, _all_ firestore queries on the same number of documents will take the same amount of time, no matter how complex your query is
  // so basically don't worry about filtration/ordering affecting performance

  // the QuerySnapshot is fairly complex and also pretty useless, so we use list.map to convert each document into a Club
  final QuerySnapshot response = await clubsQuery.get();
  return response.docs.map((e) => Club.fromJson({
    'id': e.id,
    // spread operator https://www.woolha.com/tutorials/dart-using-triple-dot-spread-operator-examples#:~:text=Usage%20on%20Map
    ...e.data(),
  })).toList(growable: false);
}

Future<Club?> getClub(String id) async {
  final _response = await _firestore.collection('clubs').doc(id).get();
  if (!_response.exists) {
    return null;
  } else {
    return Club.fromJson({
      'id': _response.id,
      ...?_response.data(),
    });
  }
}

final clubSubscriptionStore = StoreRef<String, bool>("club_subscriptions");
final _scoping = NotificationScoping();
Future<void> subscribeToClub(Club club) async {
  final db = await getDb();
  await clubSubscriptionStore.record(club.id).put(db, true);

  final id = stringToInt(club.id);
  scheduleReminder(
    id,
    title: "Upcoming club!",
    subtitle: MGSChannels.clubReminderDetails(club),
    notificationDetails: MGSChannels.club(club),
    when: club.time.next.subtract(Duration(minutes: 20)),
  );

  await _scoping.subscribeToScope(club);
}

Future<void> unsubscribeFromClub(Club club) async {
  final db = await getDb();
  await clubSubscriptionStore.record(club.id).delete(db);

  final id = stringToInt(club.id);
  cancelReminder(id);

  await _scoping.unsubscribeFromScope(club);
}

Future<bool> isSubscribedToClub(Club club) async {
  final db = await getDb();
  final response = await clubSubscriptionStore.record(club.id).get(db);

  if (response == null) {
    return false;
  } else {
    return response;
  }
}
