import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

mixin Identifiable {
  String id = '';
  String collection = '';
  DocumentReference identify() {
    return _firestore.collection(collection).doc(id);
  }
}
