import 'package:json_annotation/json_annotation.dart';

part 'wellbeing_organisation.g.dart';

@JsonSerializable()
class WellbeingOrganisation {
  String name;
  // must be no more than 6 words
  String caption;

  String url;
  String phoneNumber;

  String color;

  WellbeingOrganisation();
  factory WellbeingOrganisation.fromJson(Map<String, dynamic> json) => _$WellbeingOrganisationFromJson(json);
  Map<String, dynamic> toJson() => _$WellbeingOrganisationToJson(this);
}