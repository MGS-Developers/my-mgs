import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data_classes/sportsday/form.dart';

final _firestore = FirebaseFirestore.instance;

Stream<List<Form>> getFormOverview() {
  return _firestore
      .collection('sd_forms')
      .orderBy('points.num', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((e) => Form.fromJson({
    'id': e.id,
    ...?e.data(),
  })).toList());
}


