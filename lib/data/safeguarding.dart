import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:mymgs/keys.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> encryptAndSubmitReport(String report) async {
  final publicKeyString = getSafeguardingKey();
  final publicKey = RSAKeyParser().parse(publicKeyString);

  final encryptor = RSA(
    publicKey: publicKey,
  );
  final encrypted = encryptor.encrypt(Uint8List.fromList(report.codeUnits));

  await _firestore.collection('reports').add({
    "message": encrypted.base64,
    "publicKey": publicKeyString,
    "encryption": "RSA2048",
    "createdAt": Timestamp.now(),
  });
}
