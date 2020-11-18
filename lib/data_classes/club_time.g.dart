// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubTime _$ClubTimeFromJson(Map<String, dynamic> json) {
  return ClubTime()
    ..time = timeOfDayFromString(json['time'] as String)
    ..dayOfWeek = json['dayOfWeek'];
}

Map<String, dynamic> _$ClubTimeToJson(ClubTime instance) => <String, dynamic>{
      'time': timeOfDayToString(instance.time),
      'dayOfWeek': instance.dayOfWeek,
    };
