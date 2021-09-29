import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mymgs/data/analytics.dart';
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
  final yearGroup = await getSetting('year-group');
  return yearGroup ?? 7;
}

Future<String?> sendEmail(String address) async {
  final functionResponse = await _firebaseFunctions.httpsCallable('sendEmail').call({
    'email': address.trim(),
  });

  return functionResponse.data;
}

Future<void> confirmCode(String code, String sessionId) async {
  final functionResponse = await _firebaseFunctions.httpsCallable('confirmEmail').call({
    'code': code,
    'sessionId': sessionId,
  });

  if (functionResponse.data == null) {
    throw Exception("incorrect_code");
  } else {
    await initialiseNotificationConfig();
    await setupAnalytics();
    await AnalyticsEvents.completeSetup();
    await _firebaseAuth.signInWithCustomToken(functionResponse.data);
  }
}

final _analytics = FirebaseAnalytics();
Future<void> setupAnalytics() async {
  await _analytics.setAnalyticsCollectionEnabled(true);
  await saveSetting('analytics', true);
}
