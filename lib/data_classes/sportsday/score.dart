import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/data/sportsday/populate.dart';
import 'package:mymgs/data_classes/sportsday/event.dart';
import 'package:mymgs/data_classes/sportsday/form.dart';
import 'package:mymgs/helpers/class_serializers.dart';

part 'score.g.dart';

@JsonSerializable()
class ScoreNode {
  String id;

  String formId;
  String eventId;
  int position;
  int? calculatedPoints;

  @NoopKey
  Timestamp createdAt;

  /// only populated after [ScoreNode.populate] is called
  Event? event;
  /// only populated after [ScoreNode.populate] is called
  Form? form;

  Future<void> populate() => populateScoreNode(this);
  Future<void> populateEvent() => populateScoreNode(this, true, false);
  Future<void> populateForm() => populateScoreNode(this, false, true);

  ScoreNode({
    required this.formId,
    required this.eventId,
    required this.position,
    this.calculatedPoints,
    required this.id,
    required this.createdAt,
  });

  factory ScoreNode.fromJson(Map<String, dynamic> json) => _$ScoreNodeFromJson(json);
  Map<String, dynamic> toJson() => _$ScoreNodeToJson(this);
}
