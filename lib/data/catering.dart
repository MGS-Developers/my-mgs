import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data/setup.dart';
import 'package:mymgs/data_classes/catering_item.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<List<CateringItem>> getCateringItems() async {
  final yearGroup = await getYearGroup();
  assert(yearGroup != null);

  final cateringResponse = await _firestore
      .collection('catering')
      .where('yearGroups', arrayContains: yearGroup)
      .orderBy('dayOfWeek', descending: false)
      .get();

  final cateringItems = cateringResponse.docs.map((e) => CateringItem.fromJson({
    'id': e.id,
    ...e.data(),
  })).toList();

  cateringItems.sort((a, b) {
    return a.week.compareTo(b.week);
  });

  return cateringItems;
}