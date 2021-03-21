import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

Stream<String?> getCommentaryStream() {
  return _firestore.collection('sd_captions')
      .doc('latest')
      .snapshots()
      .map((snapshot) => snapshot.data()?["t"]);
}
