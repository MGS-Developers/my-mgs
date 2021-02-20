import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data_classes/news.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<List<NewsItem>> getNews(int limit) async {
  final newsDocs = await _firestore.collection("news")
      .orderBy("createdAt", descending: true)
      .limit(limit)
      .get();

  return newsDocs.docs.map((e) => NewsItem.fromJson({
    ...e.data(),
    "id": e.id,
  })).toList();
}

Future<NewsItem> getNewsItem(String id) async {
  final doc = await _firestore.collection("news")
      .doc(id)
      .get();

  if (!doc.exists) return null;

  return NewsItem.fromJson({
    ...doc.data(),
    "id": doc.id,
  });
}