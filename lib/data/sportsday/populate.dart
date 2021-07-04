import 'package:mymgs/data/sportsday/caching.dart';
import 'package:mymgs/data_classes/sportsday/event.dart';
import 'package:mymgs/data_classes/sportsday/score.dart';

Future<ScoreNode> populateScoreNode(ScoreNode instance) async {
  instance.event = await SportsDayCaching.getEvent(instance.eventId);
  return instance;
}

Future<Event> eventGetGroup(Event instance) async {
  instance.eventGroup = await SportsDayCaching.getEventGroup(instance.scoreSpecId, instance.eventGroupId);
  return instance;
}
