import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mymgs/data/local_database.dart';
import 'package:sembast/sembast.dart';

final _functions = FirebaseFunctions.instanceFor(region: 'europe-west2');
final _auth = FirebaseAuth.instance;
final store = StoreRef<String, bool>('sports-day');
Future<void> authenticateSportsDay() async {
  final response = await _functions.httpsCallable('sportsDayTemporaryAuth')();
  final db = await getDb();
  await store.record('temporary-auth').put(db, true);

  await _auth.signInWithCustomToken(response.data);
}

Future<void> resetSportsDayAuth() async {
  final db = await getDb();
  await store.record('temporary-auth').delete(db);
}

// returns true if the user is currently signed in using a temporary Sports Day session
Future<bool> isSportsDayAuth() async {
  final db = await getDb();
  return await store.record('temporary-auth').get(db) ?? false;
}
