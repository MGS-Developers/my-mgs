import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/data_classes/club_time.dart';
import 'package:mymgs/data_classes/identifiable.dart';
import 'package:mymgs/data_classes/link.dart';

part 'club.g.dart';

// @JsonSerializable is a simple way to automatically make a class serializable
// this means that we can turn an instance of the class into a semi-primitive object (a 'Map' — https://dart.dev/guides/language/language-tour#maps) by just calling a function, and vice-versa
// this is useful for use with our database — of course, you can't just store a class instance in a database.
// our database only takes maps, and it only gives maps. so we need a really easy system to convert between maps and class instances
// JsonSerializable is a build tool that generates this function for us automatically
// If you make changes to this class's members, you'll need to run: flutter pub run build_runner build
// this will update the club.g.dart file
@JsonSerializable()
class Club with Identifiable {
  @JsonKey(ignore: true)
  final collection = 'clubs';

  String name;
  String? description;

  // year groups allowed to attend the club
  List<int>? yearGroups;
  ClubTime time;
  // can be a room (e.g. 'S21') or a more generic area identifier (e.g. 'Platt Fields Park')
  String? location;

  String? staffName;
  String? staffEmail;

  List<Link>? links;

  Club({
    required this.name,
    required this.time,
  });
  factory Club.fromJson(Map<String, dynamic> json) => _$ClubFromJson(json);
  Map<String, dynamic> toJson() => _$ClubToJson(this);
}