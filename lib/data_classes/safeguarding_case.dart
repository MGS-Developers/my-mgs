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

class DecryptedSafeguardingCaseMessage extends SafeguardingCaseMessage {
  String decryptedMessage;

  DecryptedSafeguardingCaseMessage({
    required String id,
    required String caseId,
    required Timestamp sentAt,
    required bool recipientIsStudent,
    required String message,
    required this.decryptedMessage,
  }) : super(id: id, caseId: caseId, sentAt: sentAt, recipientIsStudent: recipientIsStudent, message: message);

  factory DecryptedSafeguardingCaseMessage.fromEncryptedMessage(SafeguardingCaseMessage message, String _decryptedMessage) {
    return DecryptedSafeguardingCaseMessage(
      id: message.id,
      caseId: message.caseId,
      sentAt: message.sentAt,
      recipientIsStudent: message.recipientIsStudent,
      message: message.message,
      decryptedMessage: _decryptedMessage,
    );
  }
}
