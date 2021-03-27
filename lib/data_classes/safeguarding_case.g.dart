// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'safeguarding_case.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SafeguardingCase _$SafeguardingCaseFromJson(Map<String, dynamic> json) {
  return SafeguardingCase(
    id: json['id'] as String,
    createdAt: noopTransform(json['createdAt']),
    studentPublicKey: json['studentPublicKey'] as String,
    staffPublicKey: json['staffPublicKey'] as String,
  );
}

Map<String, dynamic> _$SafeguardingCaseToJson(SafeguardingCase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': noopTransform(instance.createdAt),
      'studentPublicKey': instance.studentPublicKey,
      'staffPublicKey': instance.staffPublicKey,
    };

SafeguardingCaseMessage _$SafeguardingCaseMessageFromJson(
    Map<String, dynamic> json) {
  return SafeguardingCaseMessage(
    id: json['id'] as String,
    caseId: json['caseId'] as String,
    sentAt: noopTransform(json['sentAt']),
    recipientIsStudent: json['recipientIsStudent'] as bool,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$SafeguardingCaseMessageToJson(
        SafeguardingCaseMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'caseId': instance.caseId,
      'sentAt': noopTransform(instance.sentAt),
      'recipientIsStudent': instance.recipientIsStudent,
      'message': instance.message,
    };
