import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mymgs/data/clubs.dart';
import 'package:mymgs/data_classes/club.dart';
import 'package:mymgs/notifications/permissions.dart';
import 'package:mymgs/screens/settings/notifications.dart';
import 'package:mymgs/widgets/button.dart';

class ClubSubscriptionButton extends StatefulWidget {
  final Club club;
  const ClubSubscriptionButton({
    required this.club,
  });
  _ClubSubscriptionButtonState createState() => _ClubSubscriptionButtonState();
}

class _ClubSubscriptionButtonState extends State<ClubSubscriptionButton> {
  bool subscribed = false;

  @override
  void initState() {
    isSubscribedToClub(widget.club)
    .then((value) {
      setState(() {
        subscribed = value;
      });
    });
    super.initState();
  }

  void _toggle() async {
    if (!(await isNotificationAllowed('clubs'))) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please turn on club reminders to subscribe.'),
        action: SnackBarAction(
          label: "Configure",
          onPressed: () {
            Navigator.of(context).push(platformPageRoute(
              context: context,
              builder: (_) => NotificationSettings(),
            ));
          },
        ),
      ));
      return;
    }

    if (subscribed) {
      await unsubscribeFromClub(widget.club);
    } else {
      await subscribeToClub(widget.club);
    }

    setState(() {
      subscribed = !subscribed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: MGSButton(
        label: subscribed ? "Unsubscribe" : "Subscribe",
        onPressed: _toggle,
      ),
    );
  }
}
