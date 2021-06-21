import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/sportsday/temporary_authentication.dart';
import 'package:mymgs/helpers/app_metadata.dart';
import 'package:mymgs/widgets/settings/key_value.dart';
import 'package:mymgs/data/settings.dart';

final firebaseAuth = FirebaseAuth.instance;

class RemoveLicenseSetting extends StatelessWidget {
  const RemoveLicenseSetting();

  void _remove(BuildContext context) async {
    await resetSportsDayAuth();
    await firebaseAuth.signOut();
    signOutNotify();
  }

  void _confirmRemove(BuildContext context) {
    showPlatformDialog(
      context: context,
      materialBarrierColor: Theme.of(context).shadowColor,
      builder: (_) => PlatformAlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('You\'ll need to confirm your email again to continue using $appName.'),
        actions: [
          PlatformDialogAction(
            cupertino: (_, __) => CupertinoDialogActionData(
              isDestructiveAction: true,
            ),
            child: Text('Remove license'),
            onPressed: () {
              _remove(context);
              Navigator.of(context).pop();
            }
          ),
          PlatformDialogAction(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            }
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyValueSetting(
      name: "Remove license",
      description: "Sign out of $appName completely. Requires app restart.",
      onTap: () {
        _confirmRemove(context);
      },
    );
  }
}
