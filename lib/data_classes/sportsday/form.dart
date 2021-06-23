
import 'package:json_annotation/json_annotation.dart';
import 'package:mymgs/data_classes/sportsday/points.dart';

part 'form.g.dart';

@JsonSerializable(createToJson: false)
class Form {
  String id;
  int yearGroup;

  factory Form.fromID(String formId) {
    if (formId.startsWith('10')) {
      return Form(id: formId, yearGroup: 10);
    }

    final firstCharacter = formId[0];
    final parsedYearGroup = int.tryParse(firstCharacter);
    if (parsedYearGroup == null) {
      throw Exception("Couldn't parse Year Group from Form ID $formId");
    } else {
      return Form(id: formId, yearGroup: parsedYearGroup);
    }
  }

  static String humaniseID(String formId) {
    return formId.replaceFirst('-', '/');
  }
  String get humanID {
    return humaniseID(id);
  }

  Form({
    required this.id,
    required this.yearGroup,
  });
  factory Form.fromJson(Map<String, dynamic> json) => _$FormFromJson(json);
}

@JsonSerializable(createToJson: false)
class FormWithPoints extends Form {
  FormPoints points;
  FormWithPoints({
    required String id,
    required int yearGroup,
    required this.points,
  }) : super(id: id, yearGroup: yearGroup);

  factory FormWithPoints.fromJson(Map<String, dynamic> json) => _$FormWithPointsFromJson(json);
}
