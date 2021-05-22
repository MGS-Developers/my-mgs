import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/data_classes/sportsday/form.dart';

final _firestore = FirebaseFirestore.instance;
Future<Map<int, List<Form>>> getSportsdayForms() async {
  final response = await _firestore.collection("sd_forms").get();
  final groupedForms = <int, List<Form>>{};

  for (final doc in response.docs) {
    final form = Form.fromJson({
      ...doc.data(),
      'id': doc.id,
    });

    var formList = groupedForms[form.yearGroup];
    if (formList == null) {
      groupedForms[form.yearGroup] = [];
      formList = groupedForms[form.yearGroup]!;
    }

    formList.add(form);
  }

  return groupedForms;
}

Future<List<EventGroup>> getEventGroups() async {
  final response = await _firestore
      .collectionGroup('sd_event_groups')
      .orderBy('name', descending: false)
      .get();

  return response.docs.map((doc) => EventGroup.fromJson({
    'id': doc.id,
    ...doc.data(),
  })).toList();
}
