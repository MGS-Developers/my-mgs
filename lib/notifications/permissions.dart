import 'package:mymgs/data/settings.dart';

Future<bool> isNotificationAllowed(String groupId) async {
  final response = await getSetting<bool>(groupId + "_notifications");
  if (response == null) {
    return false;
  } else {
    return response;
  }
}
