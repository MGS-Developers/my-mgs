import 'package:flutter/widgets.dart';
import 'package:mymgs/data/local_database.dart';
import 'package:mymgs/widgets/dashboard_cards/clubs.dart';
import 'package:mymgs/widgets/dashboard_cards/homework.dart';
import 'package:mymgs/widgets/dashboard_cards/news.dart';
import 'package:mymgs/widgets/dashboard_cards/todays_events_card.dart';
import 'package:mymgs/widgets/dashboard_cards/todays_menu.dart';
import 'package:sembast/sembast.dart';

final store = StoreRef("dashboard");

List<String> defaultOrder = ["catering", "news", "events", "clubs", "homework"];

Widget getCardForName(String widgetName) {
  switch(widgetName) {
    case 'news':
      return NewsCard(key: const Key("news"));
    case 'catering':
      return TodaysMenuCard(key: const Key("catering"));
    case 'homework':
      return HomeworkCard(key: const Key("homework"));
    case 'events':
      return TodaysEventsCard(key: const Key("events"));
    case 'clubs':
      return ClubsCard(key: const Key("clubs"));
    default:
      return SizedBox();
  }
}

Stream<List<String>> getOrderedCards() async* {
  yield defaultOrder;

  final db = await getDb();
  yield* store.record('order').onSnapshot(db)
  .map((rawOrder) {
    var stringOrder = rawOrder?.value;
    if (stringOrder == null || stringOrder.length == 0) {
      stringOrder = defaultOrder;
    }

    return stringOrder;
  });
}

Future<List?> getOrderedNames() async {
  final db = await getDb();
  return await store.record('order').get(db);
}

Future<void> setOrder(List newOrder) async {
  final db = await getDb();
  await store.record('order').put(db, newOrder);
}
