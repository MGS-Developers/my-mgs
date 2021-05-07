import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data/setup.dart';
import 'package:mymgs/data_classes/news.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<List<NewsItem>> getNews(int limit) async {
  var query = _firestore.collection("news")
      .orderBy("createdAt", descending: true)
      .limit(limit);

  final yearGroup = await getYearGroup();
  if (yearGroup != null) {
    query = query.where('yearGroups', arrayContains: yearGroup);
  }

  final newsDocs = await query.get();
  return newsDocs.docs.map((e) => NewsItem.fromJson({
    ...e.data(),
    "id": e.id,
  })).toList();
}

Future<NewsItem?> getNewsItem(String id) async {
  final doc = await _firestore.collection("news")
      .doc(id)
      .get();

  if (!doc.exists) return null;

  return NewsItem.fromJson({
    ...?doc.data(),
    "id": doc.id,
  });
}