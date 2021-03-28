import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

mixin Identifiable {
  String id = '';
  String collection = '';
  DocumentReference identify() {
    return _firestore.collection(collection).doc(id);
  }

  String toString() {
    return identify().path;
  }
}

class _CustomIdentifiable with Identifiable {}

Identifiable customIdentifiable(String name) {
  return _CustomIdentifiable()
    ..collection = name
    ..id = 'any';
}
