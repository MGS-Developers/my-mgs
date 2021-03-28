import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:mymgs/data/local_database.dart';
import 'package:mymgs/data_classes/safeguarding_case.dart';
import 'package:mymgs/data_classes/wellbeing_organisation.dart';
import 'package:mymgs/keys.dart';
import 'package:openpgp/model/bridge.pb.dart';
import 'package:openpgp/openpgp.dart';
import 'package:sembast/sembast.dart';

final _firestore = FirebaseFirestore.instance;
final _functions = FirebaseFunctions.instanceFor(region: 'europe-west2');

class _KeyDetails {
  final String studentPrivateKey;
  final String newStudentPublicKey;
  const _KeyDetails({
    required this.studentPrivateKey,
    required this.newStudentPublicKey,
  });
}

final caseKeyStore = StoreRef<String, String>('case_keys');
/// key is [caseId, messageId]
final caseMessageStore = StoreRef<List<dynamic>, String>('case_decrypted_messages');
final caseSecretStore = StoreRef<String, String>('case_secrets');
class _CaseManager {
  static Future<String?> getCaseSendingSecret(String caseId) async {
    final db = await getDb();
    final existingSecret = await caseSecretStore.record(caseId).get(db);
    if (existingSecret != null) {
      return existingSecret;
    }

    final functionResponse = await _functions.httpsCallable('getSendingSecret').call({
      'caseId': caseId,
    });
    final sendingSecret = functionResponse.data as String?;

    if (sendingSecret != null) {
      await caseSecretStore.record(caseId).put(db, sendingSecret);
      return sendingSecret;
    }
  }

  static Future<String?> getCasePrivateKey(String caseId) async {
    final db = await getDb();
    final existingPrivateKey = await caseKeyStore.record(caseId).get(db);
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

    await caseKeyStore.record(caseId).put(db, newKeyPair.privateKey);
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
    yield* caseKeyStore.query().onSnapshots(db).map((event) => event.map((e) => e.key).toList());
  }

  static Future<String?> getDecryptedOutgoingMessage(String caseId, String messageId) async {
    final db = await getDb();
    return caseMessageStore.record([caseId, messageId]).get(db);
  }

  static Future<String> encryptOutgoingMessage(String caseId, String messageId, String message) async {
    final _encryptedMessage = await OpenPGP.encrypt(message, getSafeguardingPGP());

    final db = await getDb();
    await caseMessageStore.record([caseId, messageId]).put(db, message);

    return _encryptedMessage;
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

          if (!_response.exists) {
            continue;
          }

          _cases.add(SafeguardingCase.fromJson({
            'id': _response.id,
            ...?_response.data(),
          }));
        }

        _cases.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        return _cases;
  });
}

Stream<List<DecryptedSafeguardingCaseMessage>> getSafeguardingMessages(String caseId, String passphrase) {
  return _firestore
      .collection('safeguarding_cases')
      .doc(caseId)
      .collection('messages')
      .orderBy('sentAt', descending: true)
      .snapshots()
      .map((messages) => messages.docs.map((e) => SafeguardingCaseMessage.fromJson({
    'id': e.id,
    ...?e.data(),
  })))
      .asyncMap((messages) async {
        final List<DecryptedSafeguardingCaseMessage> decryptedMessages = [];
        for (final message in messages) {
          String _message;
          if (message.recipientIsStudent) {
            try {
              final _decryptedMessage = await _CaseManager.attemptDecryption(caseId, passphrase, message.message);
              _message = _decryptedMessage;
            } catch (e) {
              _message = "(failed to decrypt — check your passphrase)";
            }
          } else {
            final _decryptedMessage = await _CaseManager.getDecryptedOutgoingMessage(caseId, message.id);
            if (_decryptedMessage != null) {
              _message = _decryptedMessage;
            } else {
              _message = "(failed to decrypt)";
            }
          }

          decryptedMessages.add(DecryptedSafeguardingCaseMessage.fromEncryptedMessage(message, _message));
        }

        return decryptedMessages;
  });
}

Future<SafeguardingCase> createSafeguardingCase(String passphrase) async {
  final _doc = _firestore
      .collection('safeguarding_cases')
      .doc();

  final _keyDetails = await _CaseManager.generateCaseCredentials(_doc.id, passphrase);
  final _case = SafeguardingCase(
    id: _doc.id,
    createdAt: Timestamp.now(),
    studentPublicKey: _keyDetails.newStudentPublicKey,
    staffPublicKey: getSafeguardingPGP(),
  );

  await _doc.set(_case.toJson());
  return _case;
}

Future<void> sendSafeguardingMessage(String caseId, String message) async {
  final sendingSecret = await _CaseManager.getCaseSendingSecret(caseId);
  if (sendingSecret == null) {
    return;
  }

  final docId = _firestore
      .collection('safeguarding_cases')
      .doc(caseId)
      .collection('messages')
      .doc().id;

  final encryptedMessage = await _CaseManager.encryptOutgoingMessage(caseId, docId, message);
  await _functions.httpsCallable('studentSendMessage').call({
    'caseId': caseId,
    'secret': sendingSecret,
    'encryptedMessage': encryptedMessage,
    'messageId': docId,
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
