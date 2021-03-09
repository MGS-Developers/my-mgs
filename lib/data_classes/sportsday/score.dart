import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/data/sportsday/populate.dart';
import 'package:mymgs/data_classes/sportsday/event.dart';
import 'package:mymgs/data_classes/sportsday/form.dart';
import 'package:mymgs/data_classes/sportsday/points.dart';

part 'score.g.dart';

@JsonSerializable()
class ScoreNode {
  String id;

  String formId;
  String eventId;
  /// event A, B, or C
  int subEvent;
  Points points;

  /// only populated after [ScoreNode.populate] is called
  Event? event;
  /// only populated after [ScoreNode.populate] is called
  Form? form;

  Future<void> populate() => populateScoreNode(this);

  ScoreNode({
    required this.formId,
    required this.eventId,
    required this.points,
    required this.subEvent,
    required this.id,
  });

  factory ScoreNode.fromJson(Map<String, dynamic> json) => _$ScoreNodeFromJson(json);
  Map<String, dynamic> toJson() => _$ScoreNodeToJson(this);
}
