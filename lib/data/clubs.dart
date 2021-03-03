/*
This file actually uses Firestore to make a query, so take a look at the code in here if you're unsure how to do it elsewhere
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data_classes/club.dart';

// get a reference to firestore at import time (i.e. on app startup)
// this is a performance optimization as we don't have to retrieve the instance on every function call
// always put this at the top level of your code, and use an _ before 'firestore' to ensure other files can't accidentally access it
FirebaseFirestore _firestore = FirebaseFirestore.instance;

// yearGroup is the year group to filter clubs for. it's optional, but when provided only applicable clubs will be shown
Future<List<Club>> getClubs({
  final int yearGroup
}) async {
  // form the basic query (CollectionReference extends Query so they can kinda be used interchangeably)
  Query clubsQuery = _firestore.collection('clubs')
    // orderBy is an easy way to sort
    // warning: when using 'orderBy' and 'where' in the same query, Firestore will throw an error the first time
    // in the error, there'll be a link to create a composite query index. send Pal the link and he'll do it for you
    .orderBy('time.dayOfWeek', descending: true);

  if (yearGroup != null) {
    // where() has many filtering methods
    // this one, 'arrayContains', checks if the provided value is in the 'yearGroups' array of any document and filters to only retrieve those
    clubsQuery = clubsQuery.where('yearGroups', arrayContains: yearGroup);
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