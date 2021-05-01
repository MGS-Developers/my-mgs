import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data_classes/protobuf/magazines.pb.dart';
import 'package:flutter/material.dart' as Material;

Material.Color parsePbColor(Color color) {
  return Material.Color.fromRGBO(color.red, color.green, color.blue, 1);
}

final _firestore = FirebaseFirestore.instance;
Future<List<Publication>> getPublications() async {
  final snapshot = await _firestore.collection("publications").get();

  return snapshot.docs.map((e) => Publication()..mergeFromProto3Json({
    'id': e.id,
    ...e.data(),
  })).toList();
}

Future<List<Season>> getSeasons(String publicationId) async {
  final seasonSnapshot = await _firestore.collection("publications")
      .doc(publicationId)
      .collection("seasons")
      .orderBy("sequenceNumber", descending: true)
      .get();

  return seasonSnapshot.docs.map((e) => Season()..mergeFromProto3Json({
    'id': e.id,
    ...e.data(),
  })).toList();
}

Future<List<Edition>> getEditions(String publicationId, String seasonId) async {
  final snapshot = await _firestore.collection("publications")
      .doc(publicationId)
      .collection("seasons")
      .doc(seasonId)
      .collection("editions")
      .orderBy("sequenceNumber", descending: true)
      .get();

  return snapshot.docs.map((e) => Edition()..mergeFromProto3Json({
    'id': e.id,
    ...e.data(),
  })).toList();
}

Future<Edition> getLatestEdition(String publicationId) async {
  final seasons = await getSeasons(publicationId);
  final editions = await getEditions(publicationId, seasons.elementAt(0).id);
  return editions.elementAt(0);
}
