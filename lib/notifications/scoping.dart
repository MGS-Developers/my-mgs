import 'dart:convert';

import 'package:mymgs/data/local_database.dart';
import 'package:mymgs/data_classes/identifiable.dart';
import 'package:sembast/sembast.dart';

final _scopeStore = StoreRef<String, String>('notification_scoping');

/// Anonymous topic subscription utility API for Cloud Messaging
///
/// Tracks a single list of [Identifiable]s that are 'subscribed' to.
/// Notifications can then be contextually 'scoped' to only be shown to users
/// with a subscription to a specific [Identifiable].
///
/// Such scoped notifications are still delivered to anyone who is subscribed to
/// the relevant topic, but are filtered locally, thereby maintaining anonymity.
class NotificationScoping {
  NotificationScoping._internal();
  static final _singleton = NotificationScoping._internal();
  factory NotificationScoping() => _singleton;

  Future<List<dynamic>> get scopes async {
    final db = await getDb();
    final response = await _scopeStore.record('scopes').get(db);
    if (response == null) return [];

    final parsed = jsonDecode(response) as List<dynamic>;
    return parsed;
  }

  Future<void> subscribeToScope(Identifiable scope) async {
    final stringRepresentation = scope.toString();
    print("subscribing to scope $stringRepresentation");

    final newScopes = [
      ...(await scopes),
      stringRepresentation,
    ];

    final db = await getDb();
    await _scopeStore.record('scopes').put(db, jsonEncode(newScopes));
  }

  Future<void> unsubscribeFromScope(Identifiable scope) async {
    final stringRepresentation = scope.toString();
    final currentScopes = [...(await scopes)];

    currentScopes.remove(stringRepresentation);

    final db = await getDb();
    await _scopeStore.record('scopes').put(db, jsonEncode(currentScopes));
  }

  /// [scope] must be the string representation of an [Identifiable].
  ///
  /// Typically, a packet from Cloud Messaging will contain this scope string.
  Future<bool> isScopeAllowed(String scope) async {
    final currentScopes = await scopes;
    return currentScopes.contains(scope);
  }
}
