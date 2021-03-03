import 'package:cloud_functions/cloud_functions.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:mymgs/data/settings.dart';
import 'package:mymgs/notifications/permissions.dart';

final FirebaseFunctions _firebaseFunctions = FirebaseFunctions.instanceFor(region: 'europe-west2');
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

enum SetupStatus {
  Determining,
  Complete,
  Incomplete,
}

Future<SetupStatus> getSetupComplete() async {
  final authState = await _firebaseAuth.authStateChanges().first;
  if (authState == null) {
    return SetupStatus.Incomplete;
  } else {
    return SetupStatus.Complete;
  }
}

Future<int> getYearGroup() async {
  return getSetting('year-group');
}

// generate a MyMGS-compatible QR code with an encrypted private key: https://repl.it/@palk/mymgs-key-gen

/// returns whether the processing was successful
Future<bool> processQR(String rawData) async {
  if (!rawData.startsWith('mymgs-privkey-')) {
    return false;
  }

  Encrypted encryptedData;
  try {
    encryptedData = Encrypted.fromBase64(
        rawData.replaceFirst('mymgs-privkey-', '')
    );
  } catch (e) {
    return false;
  }

  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  final String publicKeyString = remoteConfig.getString('enrollment_public_key');
  final String ivString = remoteConfig.getString('enrollment_iv');

  if (publicKeyString == null) {
    return false;
  }

  String decryptedData;
  try {
    final Key publicKey = Key.fromUtf8(publicKeyString);
    final IV iv = IV.fromUtf8(ivString);
    final encrypter = Encrypter(AES(publicKey, mode: AESMode.cbc));
    decryptedData = encrypter.decrypt(encryptedData, iv: iv);
  } catch (e) {
    return false;
  }

  String authToken;
  try {
    final functionResponse = await _firebaseFunctions.httpsCallable('getSignInToken').call({
      'privateKey': decryptedData,
    });
    authToken = functionResponse.data;
  } catch (e) {
    return false;
  }

  if (authToken == null) {
    return false;
  }

  try {
    await allowAllNotifications();
    await _firebaseAuth.signInWithCustomToken(authToken);
    return true;
  } catch (e) {
    return false;
  }
}