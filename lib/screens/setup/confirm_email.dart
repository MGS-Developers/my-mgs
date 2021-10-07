import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mymgs/data/setup.dart';
import 'package:mymgs/helpers/responsive.dart';
import 'package:mymgs/widgets/button.dart';
import 'package:mymgs/widgets/text_field.dart';

class ConfirmEmail extends StatefulWidget {
  final VoidCallback onComplete;
  const ConfirmEmail({
    required this.onComplete,
  });

  _ConfirmEmailState createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  String? emailError;
  String? sessionId;
  late TextEditingController email;
  late TextEditingController code;
  bool loading = false;

  @override
  void initState() {
    email = TextEditingController();
    code = TextEditingController();
    super.initState();
  }

  void _send() async {
    if (!email.text.trim().endsWith('@mgs.org')) {
      setState(() {
        emailError = "Please use an email address ending with @mgs.org";
      });
      return;
    }

    setState(() {
      loading = true;
      emailError = null;
    });

    try {
      final _sessionId = await sendEmail(email.text);
      if (_sessionId == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("That doesn't look like a valid email address!"),
        ));
      } else {
        setState(() {
          sessionId = _sessionId;
        });
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Something went wrong! Please try again later."),
      ));
    }

    setState(() {
      loading = false;
    });
  }

  void _confirm() async {
    setState(() {
      loading = true;
    });
    try {
      await confirmCode(code.text, sessionId!);
      widget.onComplete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("That code is incorrect! Please try again."),
      ));
    }

    setState(() {
      loading = false;
    });
  }

  void _debugOverride() async {
    setState(() {
      loading = true;
    });
    try {
      await debugLogin(email.text);
      widget.onComplete();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Debug login failed! See logs for more info."),
      ));
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: Responsive(context).centeredSetupPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: sessionId == null ? [
            Text(
              'Confirm your MGS email',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 10),
            Text(
              'We\'ll send you a code to confirm your address. Your app activity won\'t be connected to your email.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 15),
            MGSTextField(
              controller: email,
              enabled: !loading,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _send(),
              label: "Email address (@mgs.org)",
              error: emailError,
            ),
            const SizedBox(height: 10),
            ButtonBar(
              children: [
                MGSButton(
                  label: "Send!",
                  onPressed: _send,
                  enabled: !loading,
                ),
                if (kDebugMode) MGSButton(
                  label: "Debug",
                  onPressed: _debugOverride,
                  enabled: !loading,
                )
              ],
            ),
          ] : [
            const Image(
              image: AssetImage('assets/confirmation_sent.png'),
              height: 70,
            ),
            const SizedBox(height: 20),
            Text(
              'Enter your verification code',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 10),
            Text(
              'We sent you a 6-digit verification code; please enter it here. It may take a few minutes to arrive.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 15),
            MGSTextField(
              controller: code,
              keyboardType: TextInputType.number,
              enabled: !loading,
              inputFormatters: [
                MaskTextInputFormatter(
                  mask: '######',
                ),
              ],
              onSubmitted: (_) => _confirm(),
            ),
            const SizedBox(height: 10),
            ButtonBar(
              children: [
                MGSButton(
                  label: "Change email",
                  enabled: !loading,
                  onPressed: () {
                    setState(() {
                      sessionId = null;
                    });
                  },
                  outlined: true,
                ),
                MGSButton(
                  label: "Confirm!",
                  enabled: !loading,
                  onPressed: _confirm,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}