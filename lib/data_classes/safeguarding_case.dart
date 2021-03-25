import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/helpers/class_serializers.dart';

part 'safeguarding_case.g.dart';

@JsonSerializable()
class SafeguardingCase {
  String id;

  @NoopKey
  Timestamp createdAt;

  String studentPublicKey;
  String staffPublicKey;

  SafeguardingCase({
    required this.id,
    required this.createdAt,
    required this.studentPublicKey,
    required this.staffPublicKey,
  });

  factory SafeguardingCase.fromJson(Map<String, dynamic> json) => _$SafeguardingCaseFromJson(json);
  Map<String, dynamic> toJson() => _$SafeguardingCaseToJson(this);
}

@JsonSerializable()
class SafeguardingCaseMessage {
  String id;
  String caseId;

  @NoopKey
  Timestamp sentAt;

  bool recipientIsStudent;
  String message;

  SafeguardingCaseMessage({
    required this.id,
    required this.caseId,
    required this.sentAt,
    required this.recipientIsStudent,
    required this.message,
  });
  factory SafeguardingCaseMessage.fromJson(Map<String, dynamic> json) => _$SafeguardingCaseMessageFromJson(json);
  Map<String, dynamic> toJson() => _$SafeguardingCaseMessageToJson(this);
}
