import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data_classes/sportsday/form.dart';

final _firestore = FirebaseFirestore.instance;

Stream<List<FormWithPoints>> getFormOverview() {
  return _firestore
      .collection('sd_forms')
      .orderBy('points.schoolPosition', descending: false)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((e) => FormWithPoints.fromJson({
    'id': e.id,
    ...e.data(),
  })).toList());
}

Stream<FormWithPoints> getFormStream(String formId) {
  return _firestore
      .collection('sd_forms')
      .doc(formId)
      .snapshots()
      .map((snapshot) => FormWithPoints.fromJson({
    'id': formId,
    ...?snapshot.data(),
  }));
}
