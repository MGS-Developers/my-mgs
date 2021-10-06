import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:mymgs/helpers/app_metadata.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/widgets/button.dart';
import 'package:mymgs/widgets/settings/analytics_toggle.dart';
import 'package:mymgs/widgets/settings/toggle.dart';

class SetupConsent extends StatefulWidget {
  final VoidCallback onComplete;
  const SetupConsent({
    required this.onComplete,
  });
  _SetupConsentState createState() => _SetupConsentState();
}

class _SetupConsentState extends State<SetupConsent> {
  late final TapGestureRecognizer _linkTapRecognizer;
  bool consented = false;

  @override
  void initState() {
    super.initState();
    _linkTapRecognizer = TapGestureRecognizer()..onTap = _viewPrivacyNotice;
  }

  @override
  void dispose() {
    super.dispose();
    _linkTapRecognizer.dispose();
  }

  void _viewPrivacyNotice() {
    FlutterWebBrowser.openWebPage(
      url: appPrivacyLink,
    );
  }

  void _attemptContinue() {
    if (!consented) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please consent to data processing"),
        duration: const Duration(seconds: 2),
      ));
      return;
    } else {
      widget.onComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Center(
      child: SingleChildScrollView(
        padding: Responsive(context).centeredSetupPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your privacy settings',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 10),
            RichText(
              textScaleFactor: textScaleFactor,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText1,
                text: 'Please read our ',
                children: [
                  TextSpan(
                    text: 'Privacy Notice',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Colors.blue,
                    ),
                    recognizer: _linkTapRecognizer,
                  ),
                  TextSpan(
                    text: ' for information about how MyMGS uses your personal data.',
                  )
                ],
              ),
            ),

            const SizedBox(height: 10),
            const AnalyticsToggleSetting(),
            ToggleSetting(
              name: "I consent to data processing under the Privacy Notice",
              description: "Required — if you're under 13, ask a parent/guardian to consent on your behalf",
              tracker: "privacy_notice",
              callback: (value) {
                setState(() {
                  consented = value;
                });
              },
            ),

            ButtonBar(
              children: [
                MGSButton(
                  label: "Continue",
                  onPressed: _attemptContinue,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
