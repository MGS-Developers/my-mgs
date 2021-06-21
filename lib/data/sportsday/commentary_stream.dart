import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

Stream<String?> getCommentaryStream() {
  return _firestore.collection('sd_captions')
      .orderBy('c', descending: true)
      .limit(1)
      .snapshots()
      .map((snapshot) {
        if (snapshot.docs.isEmpty) {
          return null;
        } else {
          return snapshot.docs[0].data()["t"];
        }
  });
}
