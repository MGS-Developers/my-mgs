import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:mymgs/data_classes/identifiable.dart';
import 'package:mymgs/data_classes/shareable.dart';

final _analytics = FirebaseAnalytics();
class AnalyticsEvents {
  static Future<void> completeSetup() => _analytics.logLogin(loginMethod: "email");
  static Future<void> clubSubscribe(String id) => _analytics.logJoinGroup(groupId: id);
  static Future<void> eventRemind(String id) => _analytics.logJoinGroup(groupId: id);
  static Future<void> addHomework() => _analytics.logEvent(name: "add_homework");
  static Future<void> completeHomework() => _analytics.logEvent(name: "complete_homework");

  static Future<void> view(Identifiable identifiable, String name) => _analytics.logViewItem(
    itemId: identifiable.id,
    itemName: name,
    itemCategory: identifiable.collection,
  );
  static Future<void> share(Shareable shareable) => _analytics.logShare(
    contentType: shareable.resource.toAnalyticsString(),
    itemId: shareable.id,
    method: "share_sheet",
  );
}
