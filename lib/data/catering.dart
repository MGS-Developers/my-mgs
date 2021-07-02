import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mymgs/data/setup.dart';
import 'package:mymgs/data_classes/catering_item.dart';
import 'package:mymgs/data_classes/term.dart';

// how long a catering cycle is, in weeks
const CATERING_CYCLE_LENGTH = 2;

FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<List<CateringItem>> getCateringItems() async {
  final yearGroup = await getYearGroup();

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

int _calculateCycle(int? startWeek, int weeksSinceStart) {
  int currentWeek = startWeek ?? 1;
  for (var i = currentWeek; i <= weeksSinceStart; i++) {
    if (currentWeek == CATERING_CYCLE_LENGTH) {
      currentWeek = 1;
    } else {
      currentWeek++;
    }
  }

  return currentWeek;
}

Future<int?> getCateringWeek() async {
  final termsResponse = await _firestore
      .collection('terms')
      .get();

  final terms = termsResponse.docs.map((e) => Term.fromJson({
    'id': e.id,
    ...e.data(),
  })).toList();

  final currentDate = DateTime.now();
  final currentWeekNumber = Jiffy(currentDate).week;

  final Term? currentTerm = terms.firstWhere((term) {
    return currentWeekNumber >= term.startWeek && currentWeekNumber <= term.endWeek;
  });

  if (currentTerm == null) {
    return null;
  }

  return _calculateCycle(
    currentTerm.cateringWeek,
    currentWeekNumber - currentTerm.startWeek,
  );
}

Future<CateringItem?> getTodaysMenu() async {
  // if you're debugging outside of term/week times, override these values
  // make sure not to actually commit your override!
  final cateringWeek = await getCateringWeek();
  final dayOfWeek = DateTime.now().weekday - 1;

  final yearGroup = await getYearGroup();

  if (cateringWeek == null) {
    return null;
  }
  
  final cateringItemResponse = await _firestore
      .collection('catering')
      .where('week', isEqualTo: cateringWeek)
      .where('dayOfWeek', isEqualTo: dayOfWeek)
      .where('yearGroups', arrayContains: yearGroup)
      .get();

  if (cateringItemResponse.size == 0) {
    return null;
  }

  return CateringItem.fromJson({
    'id': cateringItemResponse.docs[0].id,
    ...cateringItemResponse.docs[0].data(),
  });
}