import 'package:flutter/material.dart';
import 'package:mymgs/widgets/page_layouts/info.dart';

class SafeguardingPrivacy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const InfoScreen(
      title: "Reporting and privacy",
      markdownContent: """
MyMGS lets you get in touch with a member of the School's Pastoral Staff confidentially
and anonymously.
      
## Who is this service for?
Any MGS student is welcome to use our service. You can open a case at any time —
even during the holidays.

If you or someone else is being bullied, you can confidentially report it.

If you're concerned about your or someone else's mental wellbeing, you can discuss
it with a member of staff.

## Who will I be speaking to?
Once you're connected to a teacher, they'll introduce themselves and discuss the
issue with you.

You'll never be required to disclose your identity, but you're free to do so if
you're comfortable.

## What are passphrases?
To make sure only you can see messages you receive from staff, you can set a
passphrase when you open a case.

You can leave the passphrase blank if you don't want to use one.

If you forget your passphrase, it's impossible to recover it. There are no hidden
recovery mechanisms, in order to ensure perfect security.

Please make sure you keep your passphrase safe if you choose to use one.

MyMGS will not tell you immediately if your passphrase is incorrect, as it doesn't
know whether it is. It will let you know on a message-by-message basis.

There's no limit on how many passphrase guesses you can use.

## Can my cases be linked together?
No. For each case, your phone generates completely new credentials, preventing
anyone from linking them together in an attempt to find out who you are.

Your phone stores which cases you started locally, so our database doesn't know
who you are.

## How do I know it's anonymous?
The app's [open-source code base](https://github.com/MGS-School-Council/my-mgs) makes
it provable that there's no way for your identity to be traced or revealed.

Our servers don't log IP addresses, sessions, or any other user identifiers.
As far as we know, even law enforcement agencies are unable to trace your activity.

Each new case you open is assigned a new, random, military-grade encryption key 
to ensure your messages cannot be intercepted. This key is generated locally on 
your phone, meaning that our servers never get to see it.

## How can I improve my anonymity?
If you're still concerned about anonymity, there are a few additional things you can do:

- We recommend using a free VPN service to ensure your IP address is masked.

- If you're using MGS' WiFi network, please try switching to mobile data if possible.
Smoothwall may intercept some secure connections to enforce web content filtering,
which could cause your messages to be logged.

  If your transmission _does_ get logged, the contents of your messages will still
be encrypted, but your identity may become traceable.

- If you're using the web version of MyMGS, you can install the
[Tor Browser](https://www.torproject.org/) and visit https://web.mymgs.link to
open your case.
      """,
    );
  }
}
