import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymgs/data/local_database.dart';
import 'package:mymgs/data_classes/safeguarding_case.dart';
import 'package:mymgs/data_classes/wellbeing_organisation.dart';
import 'package:mymgs/keys.dart';
import 'package:openpgp/model/bridge.pb.dart';
import 'package:openpgp/openpgp.dart';
import 'package:sembast/sembast.dart';

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

class _KeyDetails {
  final String studentPrivateKey;
  final String newStudentPublicKey;
  const _KeyDetails({
    required this.studentPrivateKey,
    required this.newStudentPublicKey,
  });
}

final caseStore = StoreRef<String, String>('cases');
class _CaseManager {
  static Future<void> clearCaseCredentials(String caseId) async {
    final db = await getDb();
    await caseStore.record(caseId).delete(db);
  }

  static Future<String?> getCasePrivateKey(String caseId) async {
    final db = await getDb();
    final existingPrivateKey = await caseStore.record(caseId).get(db);
    return existingPrivateKey;
  }

  static Future<_KeyDetails> generateCaseCredentials(String caseId, String passphrase) async {
    final db = await getDb();
    final keyOptions = KeyOptions()..rsaBits = 2048;
    final newKeyPair = await OpenPGP.generate(
      options: Options()
          ..keyOptions = keyOptions
          ..passphrase = passphrase,
    );

    await caseStore.record(caseId).put(db, newKeyPair.privateKey);
    return _KeyDetails(
      studentPrivateKey: newKeyPair.privateKey,
      newStudentPublicKey: newKeyPair.publicKey,
    );
  }

  static Future<String> attemptDecryption(String caseId, String passphrase, String message) async {
    final privateKey = await getCasePrivateKey(caseId);
    if (privateKey == null) {
      throw Exception("Private key not found for case $caseId");
    }

    String decryptedMessage;
    try {
      decryptedMessage = await OpenPGP.decrypt(message, privateKey, passphrase);
    } catch (e) {
      throw Exception("Couldn't decrypt message for case $caseId");
    }

    return decryptedMessage;
  }

  static Stream<List<String>> getOwnedCaseIds() async* {
    final db = await getDb();
    yield* caseStore.query().onSnapshots(db).map((event) => event.map((e) => e.key).toList());
  }
}

Stream<List<SafeguardingCase>> getSafeguardingCases() {
  return _CaseManager.getOwnedCaseIds()
      .asyncMap((event) async {
        final List<SafeguardingCase> _cases = [];

        for (final id in event) {
          final _response = await _firestore
              .collection('safeguarding_cases')
              .doc(id)
              .get();

          _cases.add(SafeguardingCase.fromJson({
            'id': _response.id,
            ...?_response.data(),
          }));
        }

        return _cases;
  });
}

Future<List<WellbeingOrganisation>> getWellbeingOrganisations() async {
  final response = await _firestore
      .collection('wellbeing_organisations')
      .get();

  return response.docs
      .map((doc) => WellbeingOrganisation.fromJson({...?doc.data()}))
      .toList();
}
