import 'package:cloud_functions/cloud_functions.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

// we're not actually using AES for what it's meant to be used
// normally, an Initialization Vector (IV) would be generated for each request, similarly to a nonce
// but in this case, we're implementing a much simpler use case. therefore, a simple hard-coded SHA1 segment will do
const PERMANENT_IV = 'ccc10b2bac194a1d';
final IV _iv = IV.fromUtf8(PERMANENT_IV);

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

Future<void> saveYearGroup(int yearGroup) async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setInt('year-group', yearGroup);
}

Future<int> getYearGroup() async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getInt('year-group');
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

  if (publicKeyString == null) {
    return false;
  }

  String decryptedData;
  try {
    final Key publicKey = Key.fromUtf8(publicKeyString);
    final encrypter = Encrypter(AES(publicKey, mode: AESMode.cbc));
    decryptedData = encrypter.decrypt(encryptedData, iv: _iv);
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
    _firebaseAuth.signInWithCustomToken(authToken);
    return true;
  } catch (e) {
    return false;
  }
}