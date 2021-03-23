import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:mymgs/data_classes/survival_guide.dart';

final _firestore = FirebaseFirestore.instance;

Future<Map<String?, List<SurvivalGuide>>> getSurvivalGuides() async {
  final response = await _firestore
      .collection('survival_guides')
      .orderBy('name', descending: false)
      .get();

  final guides = response.docs.map((e) => SurvivalGuide.fromJson({
    'id': e.id,
    ...?e.data(),
  })).toList();

  return groupBy<SurvivalGuide, String?>(guides, (e) => e.folderName);
}

Future<SurvivalGuide?> getSurvivalGuide(String id) async {
  final response = await _firestore
      .collection('survival_guides')
      .doc(id)
      .get();

  if (!response.exists) {
    return null;
  }

  return SurvivalGuide.fromJson({
    'id': response.id,
    ...?response.data(),
  });
}
