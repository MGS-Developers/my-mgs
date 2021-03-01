import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/keys.dart';
import 'package:openpgp/openpgp.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> encryptAndSubmitReport(String report) async {
  final publicKeyString = getSafeguardingPGP();
  final encryptedMessage = await OpenPGP.encrypt(report, publicKeyString);

  await _firestore.collection('reports').add({
    "message": encryptedMessage,
    "publicKey": publicKeyString,
    "encryption": getSafeguardingKeyType(),
    "createdAt": Timestamp.now(),
  });
}
