import 'package:flutter/material.dart';
import 'package:mymgs/widgets/page_layouts/info.dart';

class InterestsAbout extends StatelessWidget {
  const InterestsAbout();
  @override
  Widget build(BuildContext context) {
    return const InfoScreen(
      title: "About Interests",
      markdownContent: """
Interests are an intuitive way to get notifications, club and event recommendations,
announcements, and more — all specific to topics that interest you.

For example, if you love biology but hate rugby, you can get announcements about
PhilSoc without ever having to hear about the next fixture.

Plus, we'll use your
interests to recommend new clubs you might want to try out or events we think you'll
like.

## Privacy
Your interests stay on your phone. We might send them to a server to query for
matching items, but they'll never be stored remotely. They'll always stay
anonymous.

## Notifications
MyMGS notifications are always sent to _all_ mobile clients, since our servers
don't know what your interests are or even what year group you're in.

Once your phone receives a message, it'll run the filtering locally and decide
whether the notification is relevant to you based on the data we store about you
locally on your phone.

## Usage
We use your interests to help with several components of MyMGS:

- Clubs and Events (admins can specify what interests their club/event appeals to)
- Magazines (admins can specify target audiences for their magazines)
- Notifications (ads and announcements are tailored to you)
- News (occasionally, articles may be specific to interests)
""",
    );
  }
}