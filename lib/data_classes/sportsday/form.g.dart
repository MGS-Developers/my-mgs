// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Form _$FormFromJson(Map<String, dynamic> json) => Form(
      id: json['id'] as String,
      yearGroup: json['yearGroup'] as int,
    );

FormWithPoints _$FormWithPointsFromJson(Map<String, dynamic> json) =>
    FormWithPoints(
      id: json['id'] as String,
      yearGroup: json['yearGroup'] as int,
      points: FormPoints.fromJson(json['points'] as Map<String, dynamic>),
    );
