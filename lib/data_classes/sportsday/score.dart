import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/data/sportsday/populate.dart';
import 'package:mymgs/data_classes/sportsday/event.dart';
import 'package:mymgs/helpers/class_serializers.dart';

part 'score.g.dart';

enum RecordUnits {
  meters,
  seconds,
}

@JsonSerializable(createToJson: false)
class AbsoluteScore {
  final RecordUnits units;
  final double value;
  // typically provided as first initial + surname
  final String competitorName;

  @Deprecated("Field is no longer maintained and its value is unreliable")
  final bool isNewRecord;

  const AbsoluteScore({
    required this.units,
    required this.value,
    required this.competitorName,
    this.isNewRecord = false,
  });

  factory AbsoluteScore.fromJson(Map<String, dynamic> json) => _$AbsoluteScoreFromJson(json);
}

@JsonSerializable(createToJson: false)
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

  // only provided for 1st place A-race ScoreNodes
  AbsoluteScore? absolute;

  Future<void> populate() => populateScoreNode(this);

  ScoreNode({
    required this.formId,
    required this.eventId,
    required this.position,
    this.calculatedPoints,
    this.absolute,
    required this.id,
    required this.createdAt,
  });

  factory ScoreNode.fromJson(Map<String, dynamic> json) => _$ScoreNodeFromJson(json);
}
