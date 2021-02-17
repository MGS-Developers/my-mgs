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
