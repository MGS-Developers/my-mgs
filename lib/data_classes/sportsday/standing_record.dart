import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/data_classes/sportsday/event_group.dart';
import 'package:mymgs/data_classes/sportsday/score.dart';

part 'standing_record.g.dart';

@JsonSerializable(createToJson: false)
class StandingRecord {
  final String holder;
  final double value;
  final RecordUnits units;
  final int year;

  final int yearGroup;
  EventGroup? eventGroup;
  final String scoreSpecId;
  final String eventGroupId;

  StandingRecord({
    required this.holder,
    required this.value,
    required this.units,
    required this.year,
    required this.yearGroup,
    this.eventGroup,
    required this.eventGroupId,
    required this.scoreSpecId,
  });
  factory StandingRecord.fromJson(Map<String, dynamic> json) => _$StandingRecordFromJson(json);
}

class MergedRecord {
  AbsoluteScore? latestRecord;
  final StandingRecord standingRecord;
  MergedRecord({
    this.latestRecord,
    required this.standingRecord,
  });
}
