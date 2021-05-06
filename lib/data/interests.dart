import 'package:mymgs/data/settings.dart';

class Interest {
  String name;
  bool interested;
  Interest(this.name, this.interested);
}

class InterestsManager {
  InterestsManager._internal();
  static final _singleton = InterestsManager._internal();
  factory InterestsManager() => _singleton;

  List<String> get allInterests {
    return [
      "Maths",
      "Physics",
      "Biology",
      "Chemistry",
    ];
  }

  List<Interest> _mapInterests(dynamic event) {
    final List list = event ?? [];
    return allInterests.map((name) {
      return Interest(name, list.contains(name));
    }).toList();
  }

  Stream<List<Interest>> watchInterests() async* {
    yield* watchSetting("interests").map(_mapInterests);
  }

  Future<List<Interest>> getInterests() async {
    final data = await getSetting('interests');
    return _mapInterests(data);
  }

  Future<void> toggleInterest(Interest interest) async {
    final interests = await getInterests();
    final newInterests = interests.map((e) {
      if (e.name == interest.name) {
        return Interest(e.name, !interest.interested);
      } else {
        return e;
      }
    });

    final stringInterests = newInterests.where((e) => e.interested).map((e) => e.name).toList();
    await saveSetting('interests', stringInterests);
  }
}
